Os componentes básicos de entrada e saída de dados são o ponto inicial de qualquer tela. Vamos aprender como trabalhar com eles e suas principais propriedades.

---

## 1. Label (Rótulos de Texto)
Usado para exibir textos estáticos na tela (como instruções ou nomes de campos).
*   `Text`: Define a string que será exibida.
*   `Font`: Altera a fonte, tamanho e estilos (negrito, itálico).
*   `ForeColor`: Controla a cor do texto.
*   `TextAlign`: Define o alinhamento do texto dentro da caixa da Label (ex: `MiddleCenter` ou `TopLeft`).

---

## 2. TextBox (Caixas de Texto)
A principal forma do usuário inserir dados textuais.
*   `Text`: A propriedade que contém a string digitada pelo usuário.
*   `PlaceholderText`: Texto cinza exibido quando o campo está vazio (ex: *"Digite seu CPF..."*).
*   `Multiline`: Permite que a caixa de texto tenha múltiplas linhas (útil para observações ou endereços).
*   `UseSystemPasswordChar`: Quando definido como `True`, mascara os caracteres digitados com bolinhas (perfeito para campos de Senha).
*   `MaxLength`: Limita o número máximo de caracteres que o usuário pode digitar.

---

## 3. Button (Botões de Ação)
Executam códigos quando clicados.
*   `Text`: O rótulo visível do botão.
*   `Enabled`: Quando `False`, desabilita o clique e deixa o botão cinza (útil para bloquear envios enquanto campos obrigatórios estão vazios).
*   **Evento padrão `Click`:** Onde escrevemos o comportamento do botão.

---

## 4. LinkLabel (Links clicáveis)
Um botão estilizado como um link de internet azul e sublinhado.
*   `LinkClicked` (Evento): Permite abrir páginas da web ou disparar lógicas de navegação.

```csharp
private void lnkRecuperarSenha_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
{
    // Exemplo: abrindo o navegador padrão com um link externo
    System.Diagnostics.Process.Start(new System.Diagnostics.ProcessStartInfo
    {
        FileName = "https://meusite.com/recuperar-senha",
        UseShellExecute = true
    });
}
```

---

## Exemplo: Formulário de Login Simples
Um exemplo clássico juntando os quatro componentes:

```csharp
private void btnEntrar_Click(object sender, EventArgs e)
{
    string usuario = txtUsuario.Text;
    string senha = txtSenha.Text;

    if (string.IsNullOrWhiteSpace(usuario) || string.IsNullOrWhiteSpace(senha))
    {
        MessageBox.Show("Por favor, preencha todos os campos!");
        return;
    }

    if (usuario == "admin" && senha == "123")
    {
        MessageBox.Show("Acesso autorizado!");
    }
    else
    {
        MessageBox.Show("Usuário ou senha incorretos.");
    }
}
```
