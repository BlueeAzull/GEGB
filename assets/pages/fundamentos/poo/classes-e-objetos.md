A Programação Orientada a Objetos (POO) é a base de todo o ecossistema .NET. Para criar sistemas organizados, você deve parar de tratar dados como strings soltas e passar a modelar as entidades do mundo real usando **Classes**.

---

## 1. O que é uma Classe?

Uma classe é a descrição de um conceito. Ela define quais características esse conceito terá (Propriedades) e quais comportamentos ele poderá executar (Métodos).

### Estrutura Completa de uma Classe C# (Model)
```csharp
public class Produto
{
    // 1. Campos Privados (Internal Data)
    private string codigoDeBarras;

    // 2. Propriedades Auto-implementadas (Getters e Setters rápidos)
    public int Id { get; set; }
    public string Nome { get; set; }
    public decimal Preco { get; set; }
    public int Estoque { get; set; }

    // 3. Propriedades Personalizadas (Com validação interna)
    public string CodigoDeBarras
    {
        get { return codigoDeBarras; }
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new ArgumentException("Código de barras não pode ser nulo.");
            codigoDeBarras = value;
        }
    }

    // 4. Construtor (Inicializa o objeto com dados obrigatórios)
    public Produto(int id, string nome, decimal preco)
    {
        Id = id;
        Nome = nome;
        Preco = preco;
        Estoque = 0; // Inicia sem estoque por padrão
    }

    // 5. Método (Comportamento)
    public void AdicionarEstoque(int quantidade)
    {
        if (quantidade > 0)
        {
            Estoque += quantidade;
        }
    }
}
```

---

## 2. O que é um Objeto?

O objeto é a representação física de uma classe criada em memória usando o operador `new` (processo chamado de **instanciação**).

```csharp
private void btnCadastrar_Click(object sender, EventArgs e)
{
    // Instanciando o objeto chamando o construtor da classe
    Produto prod = new Produto(1, "Notebook Gamer", 4500.00m);
    
    // Configurando propriedades adicionais
    prod.CodigoDeBarras = "7891234567890";
    
    // Chamando um método do objeto
    prod.AdicionarEstoque(5);

    // Exibindo informações do objeto na tela
    lblInformacao.Text = $"Produto: {prod.Nome} | Estoque Atual: {prod.Estoque} unidades.";
}
```

---

## 3. Benefícios de usar Modelos de Classes no Windows Forms

*   **Tipagem Forte:** Evita passar dados errados entre formulários.
*   **Centralização da Validação:** As regras de validação (como impedir preço negativo) ficam guardadas dentro da classe, e não espalhadas em múltiplos botões de diferentes telas.
*   **Facilidade de Integração:** Coleções de objetos (ex: `List<Produto>`) podem ser conectadas diretamente a tabelas visuais (`DataGridView`) com uma única linha de código.
