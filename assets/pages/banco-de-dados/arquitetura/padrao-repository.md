O padrão **Repository** (Repositório) serve como uma ponte de comunicação entre a sua camada de domínio (regras de negócio e telas) e a sua camada de banco de dados física. Ele age como uma coleção em memória (uma lista) onde você pode adicionar, remover ou buscar registros sem precisar saber como e onde eles são gravados.

---

## 1. Por que usar o Padrão Repository?

Se você colocar comandos SQL diretamente no clique de um botão no Form, seu projeto ficará acoplado. Se amanhã você decidir mudar o banco do MySQL para SQL Server ou Oracle:
*   Sem Repositório: Você terá que abrir todos os arquivos de formulário do projeto e reescrever todas as conexões e queries.
*   Com Repositório: Você altera apenas a implementação concreta do repositório, mantendo o código das suas telas 100% intacto.

---

## 2. Definindo a Interface do Contrato (`IProdutoRepository.cs`)

Primeiro, definimos o contrato contendo quais ações o repositório deve realizar.

```csharp
using System.Data;

public interface IProdutoRepository
{
    bool Inserir(Produto produto);
    bool Atualizar(Produto produto);
    bool Excluir(int id);
    DataTable ObterTodos();
    Produto ObterPorId(int id);
}
```

---

## 3. Implementando o Repositório Concreto (`ProdutoRepository.cs`)

Aqui nós realmente escrevemos a lógica SQL específica do MySQL para atender ao contrato.

```csharp
using System.Data;
using MySql.Data.MySqlClient;

public class ProdutoRepository : IProdutoRepository
{
    public bool Inserir(Produto produto)
    {
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "INSERT INTO produtos (nome, preco, estoque) VALUES (@nome, @preco, @estoque)";
            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@nome", produto.Nome);
                cmd.Parameters.AddWithValue("@preco", produto.Preco);
                cmd.Parameters.AddWithValue("@estoque", produto.Estoque);

                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }
    }

    public bool Atualizar(Produto produto)
    {
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "UPDATE produtos SET nome = @nome, preco = @preco, estoque = @estoque WHERE id = @id";
            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", produto.Id);
                cmd.Parameters.AddWithValue("@nome", produto.Nome);
                cmd.Parameters.AddWithValue("@preco", produto.Preco);
                cmd.Parameters.AddWithValue("@estoque", produto.Estoque);

                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }
    }

    public bool Excluir(int id)
    {
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "DELETE FROM produtos WHERE id = @id";
            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }
    }

    public DataTable ObterTodos()
    {
        DataTable tabela = new DataTable();
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "SELECT id, nome, preco, estoque FROM produtos";
            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                {
                    conn.Open();
                    adapter.Fill(tabela);
                }
            }
        }
        return tabela;
    }

    public Produto ObterPorId(int id)
    {
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "SELECT id, nome, preco, estoque FROM produtos WHERE id = @id";
            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return new Produto(
                            reader.GetInt32("id"),
                            reader.GetString("nome"),
                            reader.GetDecimal("preco")
                        ) { Estoque = reader.GetInt32("estoque") };
                    }
                }
            }
        }
        return null;
    }
}
```

---

## 4. Como usar no Form

```csharp
public partial class frmProdutos : Form
{
    // Instancia o repositório como campo de classe
    private IProdutoRepository _repository = new ProdutoRepository();

    private void btnSalvar_Click(object sender, EventArgs e)
    {
        // 1. Cria o objeto Produto com os dados da tela
        Produto prod = new Produto(0, txtNome.Text, decimal.Parse(txtPreco.Text));

        // 2. Envia para o repositório salvar
        if (_repository.Inserir(prod))
        {
            MessageBox.Show("Salvo!");
            dgvProdutos.DataSource = _repository.ObterTodos(); // Atualiza a tabela
        }
    }
}
```
Observe como o formulário não possui nenhuma linha de código relacionada ao MySQL, ConnectionString ou SqlDataReader. Ele apenas conversa com o repositório.
