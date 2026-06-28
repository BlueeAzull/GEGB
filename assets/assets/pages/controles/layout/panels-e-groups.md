Os componentes de agrupamento servem para organizar visualmente os elementos de uma tela e gerenciar seu comportamento em conjunto.

---

## 1. Panel (Painéis Invisíveis)

O **Panel** é um container simples e flexível. Ele é invisível por padrão (a menos que você configure uma cor de fundo ou borda).
*   **Barra de Rolagem Automática:** Se você tiver muitos campos em uma tela e o espaço físico for menor que o necessário, configure a propriedade `AutoScroll` do Panel como `True`. O painel exibirá barras de rolagem verticais ou horizontais automaticamente apenas quando os componentes filhos estourarem o seu tamanho.
*   **Navegação Dinâmica:** Muito usado para injetar telas de forma dinâmica na área de conteúdo central do app sem precisar abrir novas janelas soltas.

---

## 2. GroupBox (Agrupamento com Moldura)

O **GroupBox** desenha uma borda fina ao redor dos componentes e exibe um título de texto no canto superior esquerdo.
*   **Finalidade Principal:** Organizar logicamente seções de um formulário (ex: moldura para "Dados Pessoais" e outra para "Endereço").
*   **Importante para RadioButtons:** Colocar RadioButtons dentro de um GroupBox os isola dos demais controles. Isso permite que o usuário marque uma opção no Grupo A (ex: "Masculino") e outra opção no Grupo B (ex: "Cartão de Crédito") ao mesmo tempo na mesma janela.

---

## 3. TabControl (Navegação em Abas)

Permite criar múltiplas abas ou páginas (`TabPages`) dentro da mesma janela, poupando espaço de tela e simplificando a interface.

### Casos de Uso Comuns:
*   Aba 1: **Consulta** (contém o campo de busca e a grade `DataGridView`).
*   Aba 2: **Cadastro** (contém os campos de texto e os botões de salvar).

### Como trocar de aba via código:
Ao clicar em um botão "Editar" na listagem de dados, você pode carregar as informações nos campos e mudar a aba visível programaticamente:

```csharp
private void btnEditar_Click(object sender, EventArgs e)
{
    if (dgvClientes.CurrentRow != null)
    {
        // 1. Carrega os dados da linha selecionada nos campos da aba de cadastro
        txtNome.Text = dgvClientes.CurrentRow.Cells["Nome"].Value.ToString();
        
        // 2. Muda a aba visível para a aba de Cadastro (índice 1)
        tabFinanceiro.SelectedIndex = 1;
    }
}
```

### Escondendo as Abas Superiores (Layout Moderno)
Se você deseja usar o `TabControl` para controlar o fluxo da tela (como um assistente passo a passo ou menu lateral customizado) e não quer que o usuário veja as orelhas das abas no topo:
1.  Configure a propriedade `SizeMode` como `Fixed`.
2.  Defina a propriedade `ItemSize` com largura e altura iguais a `0, 1` (quase invisível).
3.  Agora, controle a navegação entre as abas exclusivamente através de botões na tela (ex: "Avançar" ou "Voltar") usando `tabMenu.SelectedIndex = ...`.
