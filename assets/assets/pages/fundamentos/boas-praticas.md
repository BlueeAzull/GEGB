Para garantir que o código dos seus primeiros projetos em C# não se transforme em uma bagunça impossível de manter, siga estas diretrizes essenciais ao trabalhar com fundamentos de telas e programação:

---

## 1. Convenção de Nomes para Controles (Padrão Húngaro Adaptado)

Nunca deixe os nomes dos controles como o Visual Studio cria por padrão (`button1`, `textBox3`, `label5`). Sempre renomeie-os usando prefixos padronizados de três letras em minúsculo:

| Componente | Prefixo | Exemplo de Nome |
| :--- | :--- | :--- |
| **TextBox** | `txt` | `txtEmailUsuario` |
| **Button** | `btn` | `btnEntrar` |
| **Label** | `lbl` | `lblMensagemStatus` |
| **ComboBox** | `cmb` | `cmbEstados` |
| **ListBox** | `lst` | `lstProdutos` |
| **DataGridView** | `dgv` | `dgvVendas` |
| **CheckBox** | `chk` | `chkLembrarSenha` |
| **RadioButton** | `rdb` | `rdbMasculino` |
| **Form** | `frm` | `frmCadastroCliente` |

---

## 2. Nomes de Variáveis e Classes Legíveis

*   **Variáveis e Parâmetros:** Use camelCase (inicia com letra minúscula e as seguintes com maiúscula).
    *   *Bom:* `int idadeDoUsuario;`
    *   *Ruim:* `int id;` ou `int IdadeDoUsuario;`
*   **Classes e Métodos:** Use PascalCase (inicia com letra maiúscula).
    *   *Bom:* `public class ContaBancaria { }` e `public void GravarDados() { }`
    *   *Ruim:* `public class conta_bancaria { }` ou `public void gravardados() { }`

---

## 3. Nunca Escreva Lógica de Negócios nos Eventos da Tela

Os eventos das telas (como o `Click` do botão) devem ser apenas o **meio de campo**. Eles pegam o texto da tela, chamam uma classe que valida/calcula os dados e devolvem o resultado para a tela.
*   **Errado:** Colocar cálculos de impostos, consultas no banco de dados e envio de e-mails direto no clique do botão.
*   **Certo:** O botão chama `calculadora.Calcular(valor);` e exibe o retorno.

---

## 4. O Uso Correto do `try-catch` para Tratamento de Erros

Sempre que existir a possibilidade de uma operação externa falhar (como conversões de dados, leitura de arquivos ou acesso ao banco), envolva a chamada em um bloco `try-catch`.

```csharp
private void btnDividir_Click(object sender, EventArgs e)
{
    try
    {
        int numero1 = int.Parse(txtNum1.Text);
        int numero2 = int.Parse(txtNum2.Text);
        
        int resultado = numero1 / numero2;
        lblResultado.Text = resultado.ToString();
    }
    catch (DivideByZeroException)
    {
        MessageBox.Show("Não é possível dividir um número por zero!", "Erro Matemático", MessageBoxButtons.OK, MessageBoxIcon.Error);
    }
    catch (FormatException)
    {
        MessageBox.Show("Por favor, preencha apenas números válidos nos campos.", "Entrada Inválida", MessageBoxButtons.OK, MessageBoxIcon.Warning);
    }
    catch (Exception ex)
    {
        MessageBox.Show($"Ocorreu um erro inesperado: {ex.Message}", "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
    }
}
```

---

## 5. Mantenha o Código Limpo e Indentado

*   Remova blocos de código comentados antigos que não servem para nada. Use o Git para guardar histórico!
*   Use a tecla de atalho `Ctrl + K + D` no Visual Studio para formatar e indentar todo o documento automaticamente.
