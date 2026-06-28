Em um aplicativo real com múltiplas telas, os formulários precisam conversar entre si (por exemplo, a tela principal precisa receber o usuário logado, ou passar o ID de um produto selecionado para a tela de edição).

---

## 1. Abrindo e Fechando Telas

Para exibir um novo formulário, instanciamos a classe da tela desejada:

### Show() (Não-Modal)
Exibe a tela secundária permitindo que o usuário continue clicando na tela anterior em segundo plano.
```csharp
frmSobre sobre = new frmSobre();
sobre.Show();
```

### ShowDialog() (Modal)
Exibe a tela secundária e **bloqueia** qualquer clique ou interação com as telas anteriores até que a nova seja fechada. Essencial para telas de Login, Cadastro ou Confirmações.
```csharp
frmConfig config = new frmConfig();
config.ShowDialog();
```

### Fechando o Form
Para fechar o formulário atual e desalocar seus recursos de vídeo:
```csharp
this.Close();
```

---

## 2. Passando Dados para a Tela Filho

Existem duas formas principais de enviar informações ao abrir uma tela.

### Método A: Pelo Construtor (Recomendado se o dado for obrigatório)
Modifique o construtor padrão da tela filho para receber parâmetros:

**Na tela filho (`frmDetalhes.cs`):**
```csharp
public partial class frmDetalhes : Form
{
    private int produtoId;

    // Construtor alterado para receber o ID
    public frmDetalhes(int id)
    {
        InitializeComponent();
        produtoId = id;
        lblInfo.Text = $"Exibindo produto: {produtoId}";
    }
}
```

**Na tela pai (`frmPrincipal.cs`):**
```csharp
private void btnVerDetalhes_Click(object sender, EventArgs e)
{
    // Passa o ID diretamente na criação do objeto da tela
    frmDetalhes tela = new frmDetalhes(104);
    tela.ShowDialog();
}
```

### Método B: Por Propriedades Públicas (Se o dado for opcional)
Defina propriedades públicas na tela filho e preencha-as antes de exibi-la:

**Na tela filho (`frmDetalhes.cs`):**
```csharp
public int ProdutoId { get; set; }
```

**Na tela pai (`frmPrincipal.cs`):**
```csharp
frmDetalhes tela = new frmDetalhes();
tela.ProdutoId = 104; // Atribui à propriedade
tela.ShowDialog();
```

---

## 3. Retornando Dados da Tela Filho para a Tela Pai

Para saber o resultado de uma tela sem precisar criar complexidades, usamos a propriedade `DialogResult`.

**Na tela de Login (`frmLogin.cs`):**
```csharp
private void btnLogar_Click(object sender, EventArgs e)
{
    if (txtSenha.Text == "123")
    {
        this.DialogResult = DialogResult.OK; // Define sucesso e fecha a tela automaticamente
    }
    else
    {
        MessageBox.Show("Senha incorreta!");
    }
}
```

**Na tela Principal (`frmPrincipal.cs`):**
```csharp
private void frmPrincipal_Load(object sender, EventArgs e)
{
    frmLogin login = new frmLogin();
    
    // Abre a tela de login. Se o usuário fechar ou falhar, o app encerra
    if (login.ShowDialog() != DialogResult.OK)
    {
        Application.Exit();
    }
}
```
