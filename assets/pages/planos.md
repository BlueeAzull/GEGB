- fazer menu de páginas e sidebar x
- sistema de categorias x
- sistema de pesquisa por titulo
- mais elementos de markdown: eve
- adicionar sistema de tema claro e escuro
- ajustar a pagina de contato

```csharp
using System;

namespace TesteMarkdown
{
  class Program
  {
    static void Main(string[] args)
    {
      // Isto é um comentário em C#
      string mensagem = "Olá do C#! O Syntax Highlighting está a funcionar?";
      int quantidadeTentativas = 3;

      Console.WriteLine(mensagem);

      for (int i = 1; i <= quantidadeTentativas; i++)
      {
        Console.WriteLine($"Tentativa número: {i}");
      }
    }
  }
}
```
