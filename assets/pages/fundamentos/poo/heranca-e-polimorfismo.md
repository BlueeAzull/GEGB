Além de criar classes isoladas, a POO nos dá ferramentas para compartilhar lógica comum e mudar o comportamento de classes filhas sem reescrever códigos.

---

## 1. Herança (Reutilização de Código)

A herança permite que uma classe filha herde todos os atributos, propriedades e métodos de uma classe pai (ou classe base). No C#, representamos isso usando o caractere dois-pontos (`:`).

### Exemplo: Sistema Escolar
```csharp
// Classe Base (Pai)
public class Pessoa
{
    public string Nome { get; set; }
    public string Email { get; set; }

    public Pessoa(string nome, string email)
    {
        Nome = nome;
        Email = email;
    }
}

// Classe Derivada (Filha)
public class Aluno : Pessoa
{
    public string Matricula { get; set; }

    // Chama o construtor da classe base usando 'base'
    public Aluno(string nome, string email, string matricula) : base(nome, email)
    {
        Matricula = matricula;
    }
}
```

---

## 2. Polimorfismo (Comportamentos Diferentes)

Polimorfismo significa "muitas formas". Ele permite que um método com a mesma assinatura se comporte de formas diferentes em classes filhas. Para isso, usamos `virtual` na classe base e `override` na classe filha.

```csharp
public class Funcionario
{
    public string Nome { get; set; }
    public decimal SalarioBase { get; set; }

    // Método virtual: permite ser alterado pelas subclasses
    public virtual decimal CalcularBonus()
    {
        return SalarioBase * 0.10m; // Bônus padrão de 10%
    }
}

public class Diretor : Funcionario
{
    // Sobrescreve o método usando 'override'
    public override decimal CalcularBonus()
    {
        // Diretores ganham o bônus padrão de 10% + bônus fixo de R$ 500
        return base.CalcularBonus() + 500.00m;
    }
}
```

---

## 3. O Modificador de Acesso `protected`

*   `private`: Apenas a própria classe enxerga.
*   `public`: Qualquer classe do projeto enxerga.
*   `protected`: Enxergado apenas pela própria classe base e pelas suas classes filhas. Mantém as informações ocultas do formulário, mas acessíveis às subclasses.

---

## 4. Interfaces (`interface`)

Uma interface é um **contrato**. Ela não tem código lógico nenhum, apenas define quais métodos e propriedades uma classe é obrigada a implementar se assinar esse contrato.

```csharp
// Nome de interface sempre começa com 'I' por convenção
public interface IImprimivel
{
    void ImprimirFicha();
}

// Classe que assina o contrato e é obrigada a implementar ImprimirFicha()
public class RelatorioFinanceiro : IImprimivel
{
    public void ImprimirFicha()
    {
        // Lógica para desenhar o relatório na impressora
    }
}
```
As interfaces são muito úteis para desacoplar as camadas de banco de dados e de negócios (ex: `IUsuarioRepository`).
