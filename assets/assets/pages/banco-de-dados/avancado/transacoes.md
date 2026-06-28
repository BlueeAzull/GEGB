Quando precisamos executar múltiplos comandos SQL relacionados no banco de dados, corremos o risco de um comando dar certo e o seguinte falhar. 

Por exemplo, em um sistema de vendas: se o programa gravar os dados principais da venda na tabela `vendas`, mas falhar ao gravar os itens da venda na tabela `itens_venda` (por falta de luz, erro de rede, etc.), o banco ficará com uma venda fantasma sem nenhum produto associado.

Para resolver isso, usamos **Transações**.

---

## 1. O Conceito de Transação (Tudo ou Nada)

Uma transação agrupa múltiplos comandos SQL em um bloco único. Ela obedece à propriedade da **Atomicidade** (um dos pilares do conceito ACID):
*   **Commit (Confirmar):** Se todos os comandos do bloco executarem sem erros, a transação é confirmada e todas as alterações são salvas permanentemente no banco.
*   **Rollback (Desfazer):** Se qualquer comando falhar, a transação inteira é cancelada e o banco de dados volta exatamente ao estado em que estava antes de iniciar a transação. Nada é salvo.

---

## 2. Implementando Transações com MySqlTransaction

No C#, controlamos a transação utilizando a classe `MySqlTransaction` associada à nossa conexão aberta.

```csharp
using MySql.Data.MySqlClient;

public bool GravarVendaCompleta(Venda venda, List<ItemVenda> itens)
{
    using (MySqlConnection conn = Conexao.ObterConexao())
    {
        conn.Open();
        
        // 1. Inicia a transação na conexão aberta
        using (MySqlTransaction trans = conn.BeginTransaction())
        {
            try
            {
                // Comando 1: Grava o cabeçalho da venda
                string sqlVenda = "INSERT INTO vendas (data, total) VALUES (@data, @total); SELECT LAST_INSERT_ID();";
                int vendaId = 0;

                using (MySqlCommand cmdVenda = new MySqlCommand(sqlVenda, conn, trans))
                {
                    cmdVenda.Parameters.AddWithValue("@data", venda.Data);
                    cmdVenda.Parameters.AddWithValue("@total", venda.Total);

                    // ExecuteScalar retorna o ID da venda recém gerado pelo AUTO_INCREMENT
                    vendaId = Convert.ToInt32(cmdVenda.ExecuteScalar()); 
                }

                // Comando 2: Loop para gravar cada item da venda usando o vendaId recuperado
                string sqlItem = "INSERT INTO itens_venda (venda_id, produto_id, quantidade) VALUES (@vendaId, @prodId, @qtd)";
                
                foreach (var item in itens)
                {
                    using (MySqlCommand cmdItem = new MySqlCommand(sqlItem, conn, trans))
                    {
                        cmdItem.Parameters.AddWithValue("@vendaId", vendaId);
                        cmdItem.Parameters.AddWithValue("@prodId", item.ProdutoId);
                        cmdItem.Parameters.AddWithValue("@qtd", item.Quantidade);

                        cmdItem.ExecuteNonQuery();
                    }
                }

                // 2. Se chegou até aqui sem erros, confirma todas as alterações de uma vez
                trans.Commit();
                return true;
            }
            catch (MySqlException ex)
            {
                // 3. Se deu qualquer erro no bloco try, desfaz tudo o que foi feito
                trans.Rollback();
                MessageBox.Show($"Falha crítica ao gravar venda. Operação cancelada. Erro: {ex.Message}");
                return false;
            }
        }
    }
}
```

---

## 3. Quando usar Transações?

Você deve usar transações sempre que houver dependência entre escritas no banco:
*   Transferências financeiras (debitar de uma conta e creditar em outra).
*   Sistemas de Pedidos/Notas Fiscais (gravar cabeçalho e itens).
*   Cadastros complexos que inserem dados em tabelas de relacionamento muitos-para-muitos (N:N).
