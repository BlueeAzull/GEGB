Para evitar que o usuário digite valores incorretos, usamos seletores de opções predefinidas. Isso limpa a interface e previne erros de validação no banco de dados.

---

## 1. CheckBox (Seleção de Sim ou Não)

Permite marcar ou desmarcar opções de forma independente.
*   `Checked`: Propriedade booleana (`true` se marcado, `false` se desmarcado).
*   `CheckedChanged` (Evento): Dispara imediatamente quando o estado do botão muda.

```csharp
private void chkTermos_CheckedChanged(object sender, EventArgs e)
{
    // Habilita o botão de avançar apenas se os termos forem aceitos
    btnAvancar.Enabled = chkTermos.Checked;
}
```

---

## 2. RadioButton (Escolha Única)

Permite que apenas **um** item seja selecionado de cada vez. Quando você clica em um RadioButton, todos os outros na mesma tela são desmarcados automaticamente.
*   **Agrupamento:** Se você precisar de dois grupos de opções independentes (ex: selecionar "Gênero" e "Método de Pagamento"), você **deve** colocá-los dentro de containers separados (como um `Panel` ou um `GroupBox`).

---

## 3. ComboBox (Menu de Opções Suspensas)

Uma lista compacta onde o usuário clica para abrir e escolher uma única opção.
*   `Items`: Lista de strings ou objetos inseridos no menu.
*   `DropDownStyle`: Mude para `DropDownList` para **impedir** que o usuário digite um texto personalizado e garantir que ele selecione apenas itens da lista.
*   `SelectedIndex`: O índice numérico selecionado (inicia em 0, ou -1 se nada estiver selecionado).
*   `SelectedItem`: O objeto/string selecionado.

```csharp
private void btnConfirmarEstado_Click(object sender, EventArgs e)
{
    if (cmbEstados.SelectedIndex == -1)
    {
        MessageBox.Show("Selecione um estado antes de continuar.");
        return;
    }
    
    string estadoSelecionado = cmbEstados.SelectedItem.ToString();
    MessageBox.Show($"Você selecionou: {estadoSelecionado}");
}
```

---

## 4. ListBox (Lista Aberta de Itens)

Exibe uma lista aberta onde todos os itens ficam visíveis, permitindo rolagem se necessário.
*   **Como Adicionar Itens:** `lstClientes.Items.Add("Kevin");`
*   **Como Remover Itens:** `lstClientes.Items.RemoveAt(index);`
*   **Como Limpar a Lista:** `lstClientes.Items.Clear();`

```csharp
private void btnAdicionarNome_Click(object sender, EventArgs e)
{
    string novoNome = txtNomeInput.Text;
    
    if (!string.IsNullOrWhiteSpace(novoNome))
    {
        lstNomes.Items.Add(novoNome); // Adiciona na lista
        txtNomeInput.Clear();
    }
}

private void btnRemoverSelecionado_Click(object sender, EventArgs e)
{
    if (lstNomes.SelectedIndex != -1)
    {
        lstNomes.Items.RemoveAt(lstNomes.SelectedIndex); // Remove da lista
    }
}
```
