Desenvolvedores produtivos utilizam o teclado para acelerar tarefas repetitivas de digitação e formatação. O Visual Studio possui diversos atalhos e **snippets** (atalhos de digitação) que economizam horas de trabalho.

---

## 1. Atalhos de Teclado Essenciais

| Atalho | Ação |
| :--- | :--- |
| `Ctrl + K + D`** | Formatar Documento:** Corrige a indentação e espaçamentos do arquivo inteiro instantaneamente. |
| `Ctrl + .` ou `Alt + Enter`** | Quick Actions:** Abre a lâmpada de sugestões (importa `using` ausente, gera classes, renomeia variáveis com segurança). |
| `F7`** | Ver Código:** Sai da tela de design do Form e abre o arquivo `.cs` de código. |
| `Shift + F7`** | Ver Designer:** Abre a tela gráfica de arrastar componentes a partir do código. |
| `F12`** | Ir para Definição:** Abre o arquivo original do método ou classe onde o cursor está posicionado. |
| `Alt + F12`** | Espiar Definição:** Abre uma mini janela por cima do código mostrando a definição sem sair do arquivo atual. |
| `Ctrl + Shift + B`** | Compilar Solução:** Compila o projeto em segundo plano para achar erros sem precisar rodá-lo. |
| `F5`** | Iniciar com Depuração:** Roda o app em modo debug (permite usar breakpoints). |
| `Ctrl + F5`** | Iniciar sem Depuração:** Roda o aplicativo de forma muito mais rápida. |

---

## 2. Code Snippets (Geração de Código Automático)

Snippets são palavras-chave que geram blocos de código inteiros. Digite a palavra-chave e **pressione a tecla TAB duas vezes seguidas**:

*   `prop` + Tab + Tab: Gera uma propriedade automática padrão.
    ```csharp
    public int MyProperty { get; set; }
    ```
*   `ctor` + Tab + Tab: Cria o construtor padrão da classe onde o cursor está.
    ```csharp
    public NomeDaClasse()
    {
    }
    ```
*   `try` + Tab + Tab: Monta a estrutura de tratamento de erro padrão.
    ```csharp
    try
    {
    }
    catch (Exception)
    {
        throw;
    }
    ```
*   `foreach` + Tab + Tab: Escreve a estrutura de laço para percorrer coleções.
    ```csharp
    foreach (var item in collection)
    {
    }
    ```
*   `cw` + Tab + Tab: Escreve o comando rápido de console.
    ```csharp
    Console.WriteLine();
    ```
*   `if` + Tab + Tab: Cria a estrutura de decisão básica.
    ```csharp
    if (true)
    {
    }
    ```
