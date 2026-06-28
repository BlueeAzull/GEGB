Para armazenar dados temporariamente na memória enquanto o aplicativo está rodando, usamos **Variáveis**. No C#, cada variável possui um tipo de dado rígido definido na sua criação.

---

## 1. Tipos de Dados Fundamentais

*   `string`: Guarda cadeias de caracteres (textos). Ex: `"Maria"`.
*   `int`: Guarda números inteiros. Ex: `42`, `-10`.
*   `double`: Guarda números decimais de dupla precisão. Ex: `1.75`.
*   `decimal`: Números decimais de alta precisão. **Sempre use para dinheiro/valores financeiros** para evitar erros de arredondamento de ponto flutuante. Ex: `1500.50m` (o sufixo `m` indica que é um decimal).
*   `bool`: Verdadeiro ou falso (`true` ou `false`).
*   `DateTime`: Armazena datas e horas complexas.

---

## 2. Declaração Explícita vs. Implícita (`var`)

Você pode declarar variáveis definindo o tipo explicitamente ou deixando o C# deduzi-lo usando a palavra-chave `var`:

```csharp
// Declaração explícita
string nome = "João";
int quantidade = 10;

// Declaração implícita (o C# descobre o tipo em tempo de compilação)
var sobrenome = "Silva"; // Deduz string
var total = 450.50m;     // Deduz decimal pelo sufixo 'm'
```
> **Regra:** `var` só pode ser usado quando a variável é inicializada na mesma linha em que é declarada.

---

## 3. Conversões Seguras (TryParse) para Preços e Números

Como todos os inputs de dados de um usuário vêm de caixas de texto (`TextBox.Text`), precisamos convertê-los antes de fazer operações matemáticas. O uso de `Parse` causa erros catastróficos se o campo estiver vazio. Use sempre `TryParse`.

### Exemplo de Cálculo de Total de Venda:
```csharp
private void btnCalcular_Click(object sender, EventArgs e)
{
    // Tentativa de conversão da quantidade
    if (!int.TryParse(txtQuantidade.Text, out int qtd))
    {
        MessageBox.Show("Quantidade inválida! Insira um número inteiro.");
        return;
    }

    // Tentativa de conversão do preço unitário
    if (!decimal.TryParse(txtPrecoUnitario.Text, out decimal preco))
    {
        MessageBox.Show("Preço unitário inválido! Use vírgula para centavos.");
        return;
    }

    // Se as conversões forem bem-sucedidas, calcula o total com precisão decimal
    decimal valorTotal = qtd * preco;
    lblTotal.Text = $"Total: {valorTotal:C2}"; // Formata como moeda local (R$)
}
```

---

## 4. Escopo de Variáveis no Formulário

*   **Variáveis Locais:** Declaradas dentro de um método (como o clique de um botão). Elas nascem e morrem dentro do método. Outro botão não consegue acessá-las.
*   **Campos de Classe (Variáveis Globais do Form):** Declaradas diretamente dentro do corpo da classe `Form`, fora de qualquer método. Elas persistem enquanto a tela estiver aberta e podem ser acessadas de qualquer método da tela.

```csharp
public partial class frmExemplo : Form
{
    // Campo de classe - mantém o saldo acumulado
    private decimal saldoConta = 0;

    private void btnDepositar_Click(object sender, EventArgs e)
    {
        if (decimal.TryParse(txtValor.Text, out decimal valor))
        {
            saldoConta += valor; // Altera o campo de classe
            lblSaldo.Text = $"Saldo: {saldoConta:C2}";
        }
    }
}
```
