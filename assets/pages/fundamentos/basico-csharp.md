Para programar telas eficientes no Windows Forms, você precisa dominar os conceitos fundamentais da linguagem C#. Como o WinForms lida muito com dados vindos de campos de texto, certas manipulações de tipos são essenciais.

---

## Variáveis e Tipos de Dados Comuns

As variáveis são usadas para armazenar informações na memória. Os tipos mais comuns em aplicativos comerciais são:

```csharp
string nome = "Ana Clara";          // Textos
int idade = 17;                    // Números inteiros
double salario = 1500.50;          // Números decimais (ponto flutuante)
bool estaAtivo = true;             // Verdadeiro ou Falso
DateTime dataCadastro = DateTime.Now; // Datas e horas
```

---

## Conversão de Tipos (Parsing) - Vital para WinForms!

Tudo que o usuário digita em um componente visual (como um `TextBox`) chega ao código como `string`. Se você precisa fazer cálculos matemáticos, deve **converter** essa string para número.

### Conversão Simples (Parse)
```csharp
// Se txtIdade.Text contiver "18", converte para int
int idade = int.Parse(txtIdade.Text);
double peso = double.Parse(txtPeso.Text);
```
> **Cuidado!** Se o usuário digitar letras ou deixar o campo vazio, o `Parse` causará um erro que fechará o aplicativo (*Exception*).

### Conversão Segura (TryParse)
Para evitar que o programa trave, use `TryParse`. Ele valida se a conversão é possível antes de realizá-la:

```csharp
if (int.TryParse(txtIdade.Text, out int idadeConvertida))
{
    // A conversão deu certo, idadeConvertida agora possui o valor numérico
    MessageBox.Show($"Sua idade é {idadeConvertida}");
}
else
{
    // O usuário digitou algo inválido
    MessageBox.Show("Por favor, digite um número de idade válido!", "Erro de Entrada");
}
```

---

## Estruturas de Decisão

Servem para alterar o fluxo de execução do seu aplicativo dependendo de uma condição.

### Estrutura `if` / `else`
```csharp
if (idade >= 18)
{
    lblStatus.Text = "Acesso Autorizado";
    lblStatus.ForeColor = Color.Green;
}
else
{
    lblStatus.Text = "Acesso Negado (Menor de idade)";
    lblStatus.ForeColor = Color.Red;
}
```

### Estrutura `switch`
Útil para substituir múltiplos `if` aninhados quando comparamos a mesma variável com vários valores constantes:

```csharp
switch (txtEstadoCivil.Text.ToUpper())
{
    case "S":
        lblDescricao.Text = "Solteiro(a)";
        break;
    case "C":
        lblDescricao.Text = "Casado(a)";
        break;
    case "D":
        lblDescricao.Text = "Divorciado(a)";
        break;
    default:
        lblDescricao.Text = "Não informado";
        break;
}
```

---

## Listas e Loops (`List<T>` e `foreach`)

Para gerenciar múltiplos objetos (como uma lista de clientes ou produtos), usamos listas dinâmicas:

```csharp
// Criando uma lista de strings
List<string> listaNomes = new List<string>();

// Adicionando itens à lista
listaNomes.Add("Caio");
listaNomes.Add("Kevin");
listaNomes.Add("Pedro");

// Percorrendo a lista e jogando os itens para um ListBox na tela
listBoxNomes.Items.Clear(); // Limpa itens antigos

foreach (string nome in listaNomes)
{
    listBoxNomes.Items.Add(nome);
}
```
