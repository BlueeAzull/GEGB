A conexão com o banco de dados é um recurso de hardware valioso. Espalhar códigos de conexão repetidos em todos os botões do sistema gera duplicidade e dificulta a manutenção (por exemplo, se a senha do banco mudar, você terá que editar todas as telas). 

A solução é centralizar a criação e controle de conexão em uma única classe utilitária.

---

## 1. Instalando o Driver MySQL no C#

1.  Abra o seu projeto no Visual Studio.
2.  No menu superior, vá em: **Tools (Ferramentas) > NuGet Package Manager > Manage NuGet Packages for Solution**.
3.  Pesquise por `MySql.Data` na aba *Browse*.
4.  Selecione seu projeto e clique em **Install**.

---

## 2. A Classe de Conexão Estática (`Conexao.cs`)

Crie uma nova classe no seu projeto chamada `Conexao.cs`. Ela usará o namespace `MySql.Data.MySqlClient` e conterá a String de Conexão.

```csharp
using MySql.Data.MySqlClient;

public static class Conexao
{
    // Define as credenciais de acesso ao seu MySQL local
    private static string server = "localhost";
    private static string database = "gegb_db";
    private static string user = "root";
    private static string password = "suasenhadobanco"; // Mude para a senha que você configurou

    // Monta a Connection String padronizada
    private static string connString = $"Server={server};Database={database};Uid={user};Pwd={password};";

    /// <summary>
    /// Cria e retorna uma nova instância de conexão com o banco de dados.
    /// Quem chamar este método deve abrir e fechar a conexão corretamente.
    /// </summary>
    public static MySqlConnection ObterConexao()
    {
        return new MySqlConnection(connString);
    }
}
```

---

## 3. Testando se o Banco está Online (Load da Tela)

Para garantir que o aplicativo não trave silenciosamente por falta de comunicação com o banco ao iniciar:

```csharp
private void frmPrincipal_Load(object sender, EventArgs e)
{
    // Tenta abrir uma conexão rápida para testar se o banco está respondendo
    using (MySqlConnection conn = Conexao.ObterConexao())
    {
        try
        {
            conn.Open();
            lblStatusBanco.Text = "Conectado ao Banco MySQL";
            lblStatusBanco.ForeColor = Color.Green;
        }
        catch (MySqlException)
        {
            MessageBox.Show("Não foi possível conectar ao banco de dados local. " +
                            "Certifique-se de que o serviço do MySQL Server está rodando no computador.", 
                            "Erro Crítico de Conexão", MessageBoxButtons.OK, MessageBoxIcon.Error);
            
            // Opcional: fechar o aplicativo se o banco for obrigatório
            Application.Exit();
        }
    }
}
```
> **Atenção:** Observe o uso de `using` ao redor da conexão. Ele garante que, mesmo se ocorrer um erro durante o `conn.Open()`, a conexão será desalocada da memória.
