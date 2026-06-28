Enquanto a camada de **Acesso a Dados (Repository)** se preocupa apenas em rodar comandos SQL no banco e a camada de **Apresentação (Form)** cuida de exibir botões e labels, onde colocamos as **regras de negócio** do sistema? 

A resposta é: na **Camada de Serviços** (*Service Layer*).

---

## 1. O Papel da Camada de Serviços

A camada de serviços (muitas vezes chamada de `Business Logic Layer` ou `BLL`) fica posicionada exatamente entre o seu Formulário e o seu Repositório. Ela é o cérebro da aplicação.
*   **Regras de Negócio:** Se o cliente não puder comprar caso tenha dívidas atrasadas, essa regra fica no Serviço.
*   **Validação Cruzada:** Se precisarmos consultar o banco antes de aprovar um cadastro (como ver se um e-mail ou CPF já está cadastrado), o Serviço é quem solicita essa checagem ao Repositório.

---

## 2. Exemplo: Venda de Produto com Validação de Estoque

Imagine que precisamos registrar uma venda de produtos. Não podemos apenas rodar um `INSERT` no banco. Precisamos primeiro:
1.  Verificar se o produto existe.
2.  Verificar se a quantidade solicitada está disponível em estoque.
3.  Deduzir a quantidade do estoque do produto.
4.  Gravar a venda no banco de dados.

### Implementação do Serviço (`VendaService.cs`):
```csharp
public class VendaService
{
    private IProdutoRepository _produtoRepo = new ProdutoRepository();
    private IVendaRepository _vendaRepo = new VendaRepository(); // Repositório hipotético de vendas

    public bool RealizarVenda(int produtoId, int quantidadeVendida, out string mensagemErro)
    {
        mensagemErro = string.Empty;

        // 1. Busca o produto no banco
        Produto produto = _produtoRepo.ObterPorId(produtoId);
        if (produto == null)
        {
            mensagemErro = "Produto não encontrado no sistema.";
            return false;
        }

        // 2. Valida o estoque disponível
        if (produto.Estoque < quantidadeVendida)
        {
            mensagemErro = $"Estoque insuficiente! Estoque atual: {produto.Estoque} unidades.";
            return false;
        }

        // 3. Executa a regra de negócio: desconta o estoque
        produto.Estoque -= quantidadeVendida;

        // 4. Salva a alteração do estoque e registra a venda
        bool atualizouEstoque = _produtoRepo.Atualizar(produto);
        bool registrouVenda = _vendaRepo.GravarVenda(produtoId, quantidadeVendida);

        if (atualizouEstoque && registrouVenda)
        {
            return true; // Venda efetuada com sucesso
        }
        else
        {
            mensagemErro = "Falha de persistência ao gravar os dados da venda.";
            return false;
        }
    }
}
```

---

## 3. Como o Form interage com o Serviço

Ao clicar no botão "Confirmar Venda", o formulário apenas chama o serviço e exibe caixas de mensagem dependendo do retorno:

```csharp
private void btnConfirmarVenda_Click(object sender, EventArgs e)
{
    int prodId = Convert.ToInt32(cmbProdutos.SelectedValue);
    int qtd = Convert.ToInt32(txtQuantidade.Text);

    VendaService vendaService = new VendaService();

    // Tenta realizar a venda pela camada de negócios
    if (vendaService.RealizarVenda(prodId, qtd, out string erro))
    {
        MessageBox.Show("Venda processada com sucesso!", "Sucesso", MessageBoxButtons.OK, MessageBoxIcon.Information);
        AtualizarTabelasDaTela();
    }
    else
    {
        // Se falhar, exibe o motivo gerado pela regra de negócio
        MessageBox.Show($"Não foi possível vender: {erro}", "Falha de Validação", MessageBoxButtons.OK, MessageBoxIcon.Warning);
    }
}
```
Isso mantém o código da interface visual extremamente simples e focado apenas em layout.
