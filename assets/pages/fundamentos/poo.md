A Programação Orientada a Objetos (POO) é um paradigma de desenvolvimento de software que tenta aproximar a estrutura do código à forma como interagimos com o mundo real. Em vez de escrever códigos em blocos sequenciais gigantescos, dividimos a lógica em **Objetos** que conversam entre si.

---

## O que é uma Classe e um Objeto?

*   **Classe:** É o "molde" ou a "planta baixa". Ela apenas descreve como algo deve ser construído.
*   **Objeto:** É a instância física criada a partir daquele molde.

Pense em uma receita de bolo (Classe) e os bolos que você assa na cozinha usando a receita (Objetos).

### Criando uma Classe Básica em C#
As propriedades representam as características do objeto, e os métodos representam as ações que ele pode realizar:

```csharp
public class Cliente
{
    // Propriedades (Características)
    public int Id { get; set; }
    public string Nome { get; set; }
    public string Cpf { get; set; }
    public DateTime DataNascimento { get; set; }

    // Construtor (Como inicializar a classe)
    public Cliente(int id, string nome, string cpf)
    {
        Id = id;
        Nome = nome;
        Cpf = cpf;
        DataNascimento = DateTime.Now;
    }

    // Método (Ação)
    public bool ValidarCpf()
    {
        // Regra de validação simplificada
        return Cpf.Length == 11;
    }
}
```

### Instanciando e Usando o Objeto na Tela (Form)
Ao clicar em um botão, você pode criar um objeto a partir daquela classe e usar seus dados:

```csharp
private void btnCadastrar_Click(object sender, EventArgs e)
{
    // Instanciando o objeto
    Cliente novoCliente = new Cliente(1, txtNome.Text, txtCpf.Text);

    if (novoCliente.ValidarCpf())
    {
        MessageBox.Show($"Cliente {novoCliente.Nome} cadastrado com sucesso!");
    }
    else
    {
        MessageBox.Show("O CPF digitado está incorreto.", "Erro de Validação");
    }
}
```

---

## Os 4 Pilares da POO

### 1. Encapsulamento
Protege os dados internos de um objeto escondendo os detalhes de implementação e expondo apenas o que for seguro através de modificadores de acesso (`public`, `private`, `protected`).
> Exemplo: Para dirigir um carro, você só precisa acelerar e virar o volante. Você não precisa mexer nos pistões do motor diretamente. As propriedades `{ get; set; }` nos ajudam nisso.

### 2. Herança
Permite que uma classe herde propriedades e métodos de outra classe ("classe mãe"), evitando a duplicação de código.

```csharp
// Classe Base (Mãe)
public class Usuario
{
    public string Login { get; set; }
    public string Senha { get; set; }
}

// Classe Derivada (Filha) - Herda tudo de Usuario usando o caractere ':'
public class Administrador : Usuario
{
    public string ChaveSeguranca { get; set; }
    
    public void ResetarSenhaUsuario()
    {
        // Ação administrativa especial
    }
}
```

### 3. Polimorfismo
A capacidade de um objeto se comportar de diferentes maneiras dependendo do contexto. Métodos com o mesmo nome em classes diferentes podem ter comportamentos diferentes.
> Exemplo: Um método `CalcularDesconto()` funciona de forma diferente para um `ClienteComum` e um `ClienteVIP`.

### 4. Abstração
Esconder a complexidade desnecessária focando apenas no essencial para o sistema.
> Se você está desenvolvendo um sistema escolar, as características físicas de um Aluno (como cor do cabelo ou altura) são ignoradas. Focamos apenas nas notas, faltas e matrícula.
