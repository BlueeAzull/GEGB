Para exibir dados de forma estruturada e hierárquica, o Windows Forms nos fornece dois componentes clássicos inspirados no próprio Windows Explorer: o **TreeView** e o **ListView**.

---

## 1. TreeView (Estrutura de Árvore)

Ideal para exibir dados hierárquicos (como categorias e subcategorias, ou pastas e arquivos).
*   `Nodes`: Coleção de nós (`TreeNode`) da árvore. Cada nó pode conter outros subnós recursivamente.
*   `SelectedNode`: O nó que está atualmente selecionado na tela.

### Exemplo: Adicionando categorias de forma estruturada
```csharp
private void btnPopularArvore_Click(object sender, EventArgs e)
{
    treeMenu.Nodes.Clear();

    // 1. Cria o nó raiz (Pai)
    TreeNode noFundamentos = new TreeNode("Fundamentos");
    
    // 2. Adiciona subnós (Filhos)
    noFundamentos.Nodes.Add("Telas");
    noFundamentos.Nodes.Add("Básico de C#");
    noFundamentos.Nodes.Add("POO");

    // 3. Adiciona outro nó raiz
    TreeNode noForms = new TreeNode("Básico de Forms");
    noForms.Nodes.Add("MySQL");
    noForms.Nodes.Add("CRUD");

    // 4. Insere as raízes no TreeView
    treeMenu.Nodes.Add(noFundamentos);
    treeMenu.Nodes.Add(noForms);
}
```

---

## 2. ListView (Listagem Detalhada com Ícones)

Exibe uma lista de itens que podem ser visualizados de várias maneiras: com ícones grandes, pequenos, em lista simples ou tabela detalhada.
*   `View`: Propriedade crucial. Defina como `Details` para criar uma tabela com colunas estruturadas, ou `LargeIcon`/`SmallIcon` para exibir cards com imagens.
*   `Columns`: Define as colunas do cabeçalho.
*   `Items`: Itens da lista. Cada item (`ListViewItem`) pode conter múltiplos subitens (valores para as outras colunas).

### Exemplo: Preenchendo um ListView no modo Detalhes (Details)
```csharp
private void btnPopularList_Click(object sender, EventArgs e)
{
    // Configura o ListView para exibir colunas em grade
    lvProdutos.View = View.Details;
    lvProdutos.FullRowSelect = true;
    lvProdutos.GridLines = true;

    // Limpa colunas e dados antigos
    lvProdutos.Columns.Clear();
    lvProdutos.Items.Clear();

    // Adiciona as colunas
    lvProdutos.Columns.Add("ID", 50);
    lvProdutos.Columns.Add("Nome do Produto", 150);
    lvProdutos.Columns.Add("Preço", 80);

    // Cria e adiciona um item (ID) com seus subitens (Nome, Preço)
    ListViewItem item1 = new ListViewItem("101");
    item1.SubItems.Add("Mouse Sem Fio");
    item1.SubItems.Add("R$ 89,90");

    ListViewItem item2 = new ListViewItem("102");
    item2.SubItems.Add("Teclado Mecânico");
    item2.SubItems.Add("R$ 249,90");

    // Insere no ListView
    lvProdutos.Items.Add(item1);
    lvProdutos.Items.Add(item2);
}
```
