O **DataGridView** é o componente mais importante para sistemas comerciais. Ele exibe dados em formato de planilha (tabela com linhas e colunas) e permite que o usuário selecione registros para editar ou excluir.

---

## 1. Configurando o GridView para Melhor Usabilidade

Por padrão, o DataGridView vem configurado com comportamentos pouco amigáveis. Sempre mude as seguintes propriedades na janela de propriedades:

*   `SelectionMode`: Mude para `FullRowSelect`. Isso faz com que a linha inteira seja selecionada quando o usuário clica em qualquer célula.
*   `AllowUserToAddRows`: Defina como `False`. Remove aquela linha vazia extra no final do grid que costuma causar erros de conversão.
*   `ReadOnly`: Mude para `True` se você deseja que o usuário apenas visualize dados e não edite diretamente digitando nas células do grid (a edição deve ocorrer em formulários dedicados).
*   `MultiSelect`: Mude para `False` para limitar a seleção a apenas um registro por vez.
*   `AutoSizeColumnsMode`: Mude para `Fill` para fazer as colunas se expandirem proporcionalmente e cobrirem toda a largura do grid.

---

## 2. Alimentando o DataGridView com Dados

A forma mais rápida de popular o grid é vinculando uma fonte de dados (`DataSource`) diretamente a ele.

```csharp
private void btnCarregarGrid_Click(object sender, EventArgs e)
{
    // Simulação de lista de objetos
    List<Cliente> lista = new List<Cliente>
    {
        new Cliente { Id = 1, Nome = "Caio", Email = "caio@email.com" },
        new Cliente { Id = 2, Nome = "Kevin", Email = "kevin@email.com" }
    };

    // Vincula a lista diretamente ao DataGridView
    dgvClientes.DataSource = null; // Limpa associação anterior
    dgvClientes.DataSource = lista;
}
```

---

## 3. Capturando Dados da Linha Selecionada

Para recuperar informações do registro que o usuário clicou (por exemplo, obter o ID do cliente selecionado para abrir a tela de edição), usamos o evento `CellClick` ou a propriedade `CurrentRow`.

```csharp
private void dgvClientes_CellClick(object sender, DataGridViewCellEventArgs e)
{
    // Verifica se há alguma linha selecionada válida
    if (dgvClientes.CurrentRow != null)
    {
        // 1. Acessa as células pelo nome da coluna ou pelo índice
        int id = Convert.ToInt32(dgvClientes.CurrentRow.Cells["Id"].Value);
        string nome = dgvClientes.CurrentRow.Cells["Nome"].Value.ToString();
        string email = dgvClientes.CurrentRow.Cells["Email"].Value.ToString();

        // 2. Preenche os campos do formulário para edição
        txtId.Text = id.ToString();
        txtNome.Text = nome;
        txtEmail.Text = email;
    }
}
```
> **Nota:** Certifique-se de que o nome da célula (`"Id"`, `"Nome"`) seja exatamente idêntico ao nome da propriedade do seu objeto ou ao nome da coluna retornada no banco de dados.
