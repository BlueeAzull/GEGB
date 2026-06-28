Escrever código limpo não é preciosismo: é o que define se você conseguirá dar manutenção no seu software daqui a duas semanas ou se terá que refazê-lo do zero. 

Abaixo estão quatro comparações clássicas de códigos comuns em projetos de estudantes e como transformá-los em um código limpo e elegante.

---

## 1. Nomes Genéricos vs. Nomes Autoexplicativos

O código limpo deve ser legível como um texto comum. Evite economizar letras nos nomes das variáveis.

### Código Confuso (Incompreensível)
```csharp
// O que são 'n1', 'n2', 'r' e 'a'? 
double n1 = 1500.00;
double n2 = 0.10;
double r = n1 * n2;
bool a = r > 100;
```

### Código Limpo (Autoexplicativo)
```csharp
double salarioBruto = 1500.00;
double taxaDesconto = 0.10;
double valorDesconto = salarioBruto * taxaDesconto;
bool isDescontoAlto = valorDesconto > 100;
```

---

## 2. Ninho de IFs (Hadouken) vs. Early Return (Retorno Precoce)

Evite aninhar múltiplos blocos de condições para validar dados. O código cresce para a direita e fica difícil de acompanhar.

### Código Confuso (Hadouken)
```csharp
private void btnEnviar_Click(object sender, EventArgs e)
{
    if (txtNome.Text != "")
    {
        if (txtEmail.Text != "")
        {
            if (txtSenha.Text != "")
            {
                // Processamento principal...
                MessageBox.Show("Cadastro realizado!");
            }
            else
            {
                MessageBox.Show("Senha vazia!");
            }
        }
        else
        {
            MessageBox.Show("E-mail vazio!");
        }
    }
    else
    {
        MessageBox.Show("Nome vazio!");
    }
}
```

### Código Limpo (Retorno Precoce)
Valide os erros primeiro, saia do método imediatamente se algo estiver errado (`return`), e deixe o fluxo principal livre no final do método.

```csharp
private void btnEnviar_Click(object sender, EventArgs e)
{
    if (string.IsNullOrWhiteSpace(txtNome.Text))
    {
        MessageBox.Show("Nome vazio!");
        return;
    }

    if (string.IsNullOrWhiteSpace(txtEmail.Text))
    {
        MessageBox.Show("E-mail vazio!");
        return;
    }

    if (string.IsNullOrWhiteSpace(txtSenha.Text))
    {
        MessageBox.Show("Senha vazia!");
        return;
    }

    // Processamento principal livre de aninhamentos
    MessageBox.Show("Cadastro realizado!");
}
```

---

## 3. Repetição de Código vs. Reuso com Métodos

O princípio **DRY** (*Don't Repeat Yourself* - Não se Repita) é sagrado. Se você copiou e colou a mesma lógica duas vezes, ela deveria ser um método.

### Código Confuso (Copiado e Colado)
```csharp
private void btnSalvar_Click(object sender, EventArgs e)
{
    // Limpa campos na tela
    txtNome.Text = "";
    txtEmail.Text = "";
    txtTelefone.Text = "";
    txtEndereco.Text = "";
    chkAtivo.Checked = false;
}

private void btnCancelar_Click(object sender, EventArgs e)
{
    // Limpa os mesmos campos novamente
    txtNome.Text = "";
    txtEmail.Text = "";
    txtTelefone.Text = "";
    txtEndereco.Text = "";
    chkAtivo.Checked = false;
}
```

### Código Limpo (Reuso)
```csharp
private void btnSalvar_Click(object sender, EventArgs e)
{
    // Processamento...
    LimparFormulario();
}

private void btnCancelar_Click(object sender, EventArgs e)
{
    LimparFormulario();
}

// Método auxiliar único
private void LimparFormulario()
{
    txtNome.Clear();
    txtEmail.Clear();
    txtTelefone.Clear();
    txtEndereco.Clear();
    chkAtivo.Checked = false;
}
```

---

## 4. "Gambiarras" Matemáticas vs. Métodos Auxiliares Expressivos

Evite usar expressões complexas direto no meio da lógica onde o leitor precisa calcular mentalmente o que o código está fazendo.

### Código Confuso
```csharp
// O que esse cálculo faz? O que significa 0.275 e 869.36?
double imposto = (rendimento * 0.275) - 869.36;
```

### Código Limpo
```csharp
double imposto = CalcularImpostoDeRenda(rendimento);

// ...

private double CalcularImpostoDeRenda(double rendimento)
{
    const double aliquotaMaxima = 0.275;
    const double parcelaDeduzir = 869.36;
    
    return (rendimento * aliquotaMaxima) - parcelaDeduzir;
}
```
