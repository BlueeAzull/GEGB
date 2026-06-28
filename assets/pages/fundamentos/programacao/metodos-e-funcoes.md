Métodos (ou funções) são blocos de código nomeados que realizam uma tarefa específica. Eles servem para organizar o código, evitar a repetição de lógicas iguais (princípio DRY) e isolar comportamentos para facilitar testes e manutenção.

---

## 1. Estrutura de um Método

A assinatura básica de um método no C# é composta por:
`ModificadorAcesso TipoRetorno NomeDoMetodo(Parâmetros) { ... }`

```csharp
// Método público, que retorna um número decimal e recebe dois parâmetros
public decimal CalcularDesconto(decimal valorTotal, decimal porcentagem)
{
    decimal desconto = valorTotal * (porcentagem / 100);
    return desconto; // Retorna o valor calculado para quem chamou
}
```

---

## 2. Métodos sem Retorno (`void`)

Quando o método apenas realiza uma ação e não precisa devolver nenhuma informação matemática ou lógica para o chamador, usamos o tipo de retorno `void`.

```csharp
// Método que limpa as caixas de texto informadas
private void LimparCamposCadastro()
{
    txtNome.Clear();
    txtEmail.Clear();
    txtTelefone.Clear();
    txtNome.Focus(); // Coloca o cursor de digitação de volta no Nome
}
```

---

## 3. Passagem de Parâmetros especiais: `ref` e `out`

Por padrão, quando passamos variáveis comuns para um método, o C# passa uma **cópia** do valor. Alterar a variável dentro do método não altera a variável original que estava fora.

### O modificador `out` (Saída)
Obrigatório para retornar mais de um valor de um método ou quando o próprio método já retorna um booleano de sucesso. Ele passa uma referência direta e obriga o método a preencher essa variável antes de terminar.

```csharp
// Método que tenta dividir dois números de forma segura
public bool TentarDividir(double dividendo, double divisor, out double resultado)
{
    if (divisor == 0)
    {
        resultado = 0; // Obrigatório inicializar
        return false;  // Divisão falhou
    }

    resultado = dividendo / divisor;
    return true; // Divisão deu certo
}
```

**Como chamar:**
```csharp
double num1 = 10;
double num2 = 0;

if (TentarDividir(num1, num2, out double res))
{
    lblResultado.Text = $"Resultado: {res}";
}
else
{
    lblResultado.Text = "Erro: Divisão por zero!";
}
```

---

## 4. O modificador `ref` (Referência)
Passa a própria variável física para dentro do método. Qualquer alteração feita dentro do método altera diretamente a variável que foi passada por parâmetro. Ao contrário de `out`, a variável passada em `ref` já deve vir inicializada de fora.

```csharp
public void AumentarPreco(ref decimal precoBase)
{
    precoBase += 50.00m; // Modifica diretamente a variável original
}
```
