Vamos ver como realizar as duas primeiras operações básicas do banco de dados MySQL a partir do C#: **Inserir (Create)** e **Consultar (Read)**.

---

## 1. Cadastro / Inserção de Dados (INSERT)

Para inserir registros, usamos a query `INSERT INTO`. Como estamos lidando com variáveis vindas das caixas de texto digitadas pelo usuário, **sempre** usaremos parâmetros para segurança contra injeção SQL.

```csharp
using MySql.Data.MySqlClient;

public bool CadastrarProduto(string nome, decimal preco, int estoque)
{
    // 1. Obtém a instância de conexão através da nossa classe Conexao
    using (MySqlConnection conn = Conexao.ObterConexao())
    {
        // 2. Query SQL com variáveis parametrizadas usando '@'
        string sql = "INSERT INTO produtos (nome, preco, estoque) VALUES (@nome, @preco, @estoque)";

        using (MySqlCommand cmd = new MySqlCommand(sql, conn))
        {
            // 3. Substitui os parâmetros pelos valores reais com limpeza automática
            cmd.Parameters.AddWithValue("@nome", nome);
            cmd.Parameters.AddWithValue("@preco", preco);
            cmd.Parameters.AddWithValue("@estoque", estoque);

            try
            {
                conn.Open(); // Abre a conexão física
                
                // 4. Executa a query. Retorna o número de linhas afetadas no banco de dados.
                int linhas = cmd.ExecuteNonQuery(); 
                
                return linhas > 0; // Se alterou mais de 0 linhas, deu certo!
            }
            catch (MySqlException ex)
            {
                MessageBox.Show($"Erro ao salvar no banco: {ex.Message}");
                return false;
            }
        }
    }
}
```

---

## 2. Leitura / Consulta de Dados (SELECT)

Temos duas formas de ler dados: usando um leitor rápido linha por linha (`MySqlDataReader`) ou usando um adaptador estruturado (`MySqlDataAdapter`).

### Forma A: Carregando dados para uma Tabela (`DataTable`)
Muito útil para ligar diretamente a um controle de grade (`DataGridView.DataSource`).

```csharp
using System.Data;
using MySql.Data.MySqlClient;

public DataTable ConsultarTodosProdutos()
{
    DataTable tabela = new DataTable();

    using (MySqlConnection conn = Conexao.ObterConexao())
    {
        string sql = "SELECT id, nome, preco, estoque FROM produtos";

        using (MySqlCommand cmd = new MySqlCommand(sql, conn))
        {
            try
            {
                conn.Open();
                // O DataAdapter preenche a tabela em memória automaticamente
                using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                {
                    adapter.Fill(tabela);
                }
            }
            catch (MySqlException ex)
            {
                MessageBox.Show($"Erro de consulta: {ex.Message}");
            }
        }
    }
    return tabela; // Retorna a tabela cheia ou vazia
}
```

### Forma B: Lendo linha por linha com o `DataReader`
Muito útil para carregar dados de um único objeto (ex: buscar os dados de um cliente pelo ID para jogar nos campos de texto da tela).

```csharp
public Produto BuscarProdutoPorId(int id)
{
    using (MySqlConnection conn = Conexao.ObterConexao())
    {
        string sql = "SELECT id, nome, preco, estoque FROM produtos WHERE id = @id";

        using (MySqlCommand cmd = new MySqlCommand(sql, conn))
        {
            cmd.Parameters.AddWithValue("@id", id);

            try
            {
                conn.Open();
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read()) // Se encontrou o registro
                    {
                        string nome = reader.GetString("nome");
                        decimal preco = reader.GetDecimal("preco");
                        int estoque = reader.GetInt32("estoque");

                        return new Produto(id, nome, preco) { Estoque = estoque };
                    }
                }
            }
            catch (MySqlException ex)
            {
                MessageBox.Show($"Erro de busca: {ex.Message}");
            }
        }
    }
    return null; // Retorna nulo se não encontrou o ID
}
```
