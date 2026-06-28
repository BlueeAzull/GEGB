Para fechar o ciclo de manipulação de dados, veremos as duas últimas operações no MySQL: **Atualizar (Update)** e **Excluir (Delete)**.

---

## 1. Atualização de Dados (UPDATE)

Para atualizar um registro, precisamos saber qual é o seu identificador exclusivo (ID/Chave Primária). Caso contrário, atualizaremos todos os dados da tabela de uma só vez!

```csharp
using MySql.Data.MySqlClient;

public bool AlterarProduto(int id, string novoNome, decimal novoPreco, int novoEstoque)
{
    using (MySqlConnection conn = Conexao.ObterConexao())
    {
        // Altera apenas o produto que bate com o ID fornecido
        string sql = "UPDATE produtos SET nome = @nome, preco = @preco, estoque = @estoque WHERE id = @id";

        using (MySqlCommand cmd = new MySqlCommand(sql, conn))
        {
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@nome", novoNome);
            cmd.Parameters.AddWithValue("@preco", novoPreco);
            cmd.Parameters.AddWithValue("@estoque", novoEstoque);

            try
            {
                conn.Open();
                int linhas = cmd.ExecuteNonQuery();
                return linhas > 0;
            }
            catch (MySqlException ex)
            {
                MessageBox.Show($"Erro de atualização: {ex.Message}");
                return false;
            }
        }
    }
}
```

---

## 2. Exclusão de Dados (DELETE)

A exclusão remove fisicamente o registro do banco de dados.

> ⚠️ **ALERTA MÁXIMO:** Nunca esqueça da cláusula `WHERE id = @id` em um comando `DELETE`. Se você omitir o `WHERE`, o MySQL apagará **todos** os registros da tabela sem pedir confirmação!

```csharp
public bool ExcluirProduto(int id)
{
    using (MySqlConnection conn = Conexao.ObterConexao())
    {
        string sql = "DELETE FROM produtos WHERE id = @id";

        using (MySqlCommand cmd = new MySqlCommand(sql, conn))
        {
            cmd.Parameters.AddWithValue("@id", id);

            try
            {
                conn.Open();
                int linhas = cmd.ExecuteNonQuery();
                return linhas > 0;
            }
            catch (MySqlException ex)
            {
                // Código de erro 1451: Ocorre quando tentamos deletar um registro 
                // que possui chaves estrangeiras vinculadas em outras tabelas.
                if (ex.Number == 1451)
                {
                    MessageBox.Show("Este produto não pode ser excluído porque está associado a " +
                                    "vendas ou notas fiscais existentes no sistema.", 
                                    "Restrição de Segurança", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
                else
                {
                    MessageBox.Show($"Erro ao excluir: {ex.Message}");
                }
                return false;
            }
        }
    }
}
```

---

## Dica: Exclusão Lógica vs. Exclusão Física

Em sistemas comerciais do mundo real, a exclusão física (`DELETE`) é pouco recomendada, pois você perde todo o histórico de dados de faturamento.
*   **Exclusão Lógica (Soft Delete):** Adicione uma coluna na sua tabela como `ativo BOOLEAN DEFAULT TRUE`.
*   Para excluir, você faz um `UPDATE produtos SET ativo = FALSE WHERE id = @id`.
*   Para listar, você apenas busca os ativos: `SELECT * FROM produtos WHERE ativo = TRUE`.
*   Dessa forma, os dados continuam no banco para relatórios fiscais, mas ficam invisíveis para o usuário comum.
