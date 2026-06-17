- fazer menu de páginas e variavel no assetPath
- sistema de categorias
- sistema de pesquisa por titulo
- pagina de contato
- mais elementos de markdown
- adicionar sistema de tema claro e escuro

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
