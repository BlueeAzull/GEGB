Escrever blocos `try-catch` em todas as ações do seu aplicativo é exaustivo, e fatalmente você acabará esquecendo de tratar algum ponto de erro. Quando um erro não tratado (*Unhandled Exception*) ocorre no Windows Forms, a aplicação exibe uma janela técnica confusa e encerra o programa de forma abrupta na cara do usuário.

Para capturar esses erros inesperados de forma elegante e centralizada, usamos o **Tratamento de Exceções Global**.

---

## 1. Onde Configurar? (Program.cs)

A configuração é feita diretamente no ponto de entrada do sistema, no arquivo `Program.cs`, antes de iniciar a primeira tela.

```csharp
using System;
using System.Threading;
using System.Windows.Forms;

internal static class Program
{
    [STAThread]
    static void Main()
    {
        // 1. Assina o evento para erros ocorridos na Thread de UI (telas)
        Application.ThreadException += new ThreadExceptionEventHandler(TratarErroInterface);

        // 2. Garante que erros de UI passem pelo nosso manipulador
        Application.SetUnhandledExceptionMode(UnhandledExceptionMode.CatchException);

        // 3. Assina o evento para erros em threads secundárias (operações em segundo plano)
        AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(TratarErroSegundoPlano);

        ApplicationConfiguration.Initialize();
        Application.Run(new Form1());
    }

    private static void TratarErroInterface(object sender, ThreadExceptionEventArgs e)
    {
        ExibirMensagemErroAmigavel(e.Exception);
    }

    private static void TratarErroSegundoPlano(object sender, UnhandledExceptionEventArgs e)
    {
        if (e.ExceptionObject is Exception ex)
        {
            ExibirMensagemErroAmigavel(ex);
        }
    }

    private static void ExibirMensagemErroAmigavel(Exception ex)
    {
        // Aqui, em vez de deixar o programa crashar silenciosamente:
        // 1. Mostramos uma mensagem amigável para o usuário
        MessageBox.Show($"Ocorreu um erro inesperado no sistema. Contate o suporte técnico.\n\nDetalhes: {ex.Message}", 
                        "Erro do Sistema", 
                        MessageBoxButtons.OK, 
                        MessageBoxIcon.Error);

        // 2. Opcional: Gravar o log do erro em um arquivo de texto local
        try
        {
            string logCaminho = "erros_log.txt";
            string logTexto = $"[{DateTime.Now}] ERRO: {ex.Message}\nStacktrace: {ex.StackTrace}\n\n";
            System.IO.File.AppendAllText(logCaminho, logTexto);
        }
        catch { /* Ignora se falhar ao gravar o log */ }
    }
}
```

---

## 2. Quando ainda usar o `try-catch` local?

O tratamento global serve apenas como uma **rede de segurança de última hora** para evitar que o programa feche sozinho na cara do usuário. 
*   Você ainda deve usar `try-catch` locais em operações previsíveis onde você pode se recuperar do erro. Por exemplo, se a conversão de um preço falhar, você avisa ao usuário sobre o erro localmente e permite que ele tente redigitar os dados.
