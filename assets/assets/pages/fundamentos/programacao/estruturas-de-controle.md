As estruturas de controle determinam qual direção o código irá tomar e quantas vezes um bloco de código se repetirá.

---

## 1. Condicionais: `if`, `else if` e `else`

Servem para executar ações baseadas em testes lógicos.

```csharp
private void btnValidar_Click(object sender, EventArgs e)
{
    if (decimal.TryParse(txtNota.Text, out decimal nota))
    {
        if (nota < 0 || nota > 10)
        {
            MessageBox.Show("A nota deve ser entre 0 e 10.");
        }
        else if (nota >= 6.0m)
        {
            lblResultado.Text = "Aprovado!";
            lblResultado.ForeColor = Color.Green;
        }
        else
        {
            lblResultado.Text = "Reprovado.";
            lblResultado.ForeColor = Color.Red;
        }
    }
}
```

---

## 2. Operadores Lógicos

Permitem combinar múltiplas condições no mesmo `if`:
*   `&&` (E / AND): Verdadeiro apenas se **todas** as condições forem verdadeiras.
*   `||` (OU / OR): Verdadeiro se pelo menos **uma** das condições for verdadeira.
*   `!` (NÃO / NOT): Inverte o valor lógico.

```csharp
// Se a idade for maior de 18 E tiver carteira assinada
if (idade >= 18 && temCarteira) { ... }

// Se o campo for nulo OU estiver vazio
if (string.IsNullOrEmpty(txtNome.Text) || string.IsNullOrWhiteSpace(txtNome.Text)) { ... }
```

---

## 3. Estrutura de Escolha: `switch`

Quando você precisa comparar uma única variável com múltiplos valores possíveis.

```csharp
private void cmbNivelAcesso_SelectedIndexChanged(object sender, EventArgs e)
{
    string nivel = cmbNivelAcesso.SelectedItem?.ToString();

    switch (nivel)
    {
        case "Administrador":
            btnExcluir.Visible = true;
            btnConfig.Visible = true;
            break;
        case "Operador":
            btnExcluir.Visible = false;
            btnConfig.Visible = false;
            break;
        default:
            btnExcluir.Visible = false;
            btnConfig.Visible = false;
            break;
    }
}
```

---

## 4. Laços de Repetição (Loops)

Repetem um bloco de código enquanto uma condição for atendida.

### O laço `for` (Repetição com contador)
```csharp
// Adiciona números de 1 a 10 em um ListBox
lstNumeros.Items.Clear();
for (int i = 1; i <= 10; i++)
{
    lstNumeros.Items.Add(i);
}
```

### O laço `foreach` (Excelente para ler coleções ou controles visuais)
Você pode usar o `foreach` para fazer varreduras automáticas em controles da tela. Por exemplo, limpar todas as caixas de texto de um formulário de uma só vez:

```csharp
private void btnLimparCampos_Click(object sender, EventArgs e)
{
    // Varre todos os controles que estão dentro do formulário
    foreach (Control controle in this.Controls)
    {
        // Se o controle for uma caixa de texto
        if (controle is TextBox)
        {
            controle.Text = string.Empty; // Limpa o texto
        }
    }
}
```
> **Nota:** Se as caixas de texto estiverem dentro de um `Panel` ou `GroupBox`, você deve varrer `panel1.Controls` em vez de `this.Controls`.
