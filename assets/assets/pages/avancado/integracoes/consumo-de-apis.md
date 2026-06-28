Muitos aplicativos desktop precisam interagir com serviços na internet: consultar cotações de moedas, integrar com gateways de pagamento ou realizar buscas automatizadas de endereços. A forma mais comum de realizar essa integração é consumindo uma **API REST**.

Vamos ver como consumir uma API de consulta de endereços a partir de um CEP.

---

## 1. O que usaremos?

*   **HttpClient:** A classe padrão do .NET para enviar requisições HTTP e receber respostas da web.
*   **System.Text.Json:** A biblioteca oficial do .NET para converter textos em formato JSON vindos da API em classes C# (processo chamado de **desserialização**).

---

## 2. Definindo a Classe de Dados (Model da API)

Primeiro, criamos uma classe em C# que corresponde exatamente à estrutura de dados retornada pela API do ViaCEP.

```csharp
public class CepResposta
{
    // Os nomes das propriedades devem bater com as chaves do JSON retornado pela API
    public string cep { get; set; }
    public string logradouro { get; set; }
    public string bairro { get; set; }
    public string localidade { get; set; } // Cidade
    public string uf { get; set; }         // Estado
    public bool erro { get; set; }         // Retornado pelo ViaCEP se o CEP não existir
}
```

---

## 3. Realizando a Chamada HTTP Assíncrona

Instanciamos o `HttpClient` e realizamos a requisição usando `GetFromJsonAsync` (ou lendo como string e fazendo o Parse). **Nota de boa prática:** O `HttpClient` deve ser instanciado uma única vez na classe e reutilizado para evitar consumo excessivo de sockets de rede do sistema operacional.

```csharp
using System;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;

public class ViaCepService
{
    // Reutiliza a instância de HttpClient
    private static readonly HttpClient client = new HttpClient();

    public async Task<CepResposta> BuscarEnderecoPorCepAsync(string cep)
    {
        // Limpa formatação do CEP (remove traços ou espaços)
        string cepLimpo = cep.Replace("-", "").Replace(" ", "").Trim();

        if (cepLimpo.Length != 8)
        {
            throw new ArgumentException("O CEP deve conter exatamente 8 dígitos.");
        }

        string url = $"https://viacep.com.br/ws/{cepLimpo}/json/";

        try
        {
            // Envia o GET assincronamente e lê a resposta já convertendo em classe C#
            string jsonResponse = await client.GetStringAsync(url);
            
            // Desserializa a string JSON recebida para o nosso objeto CepResposta
            CepResposta resposta = JsonSerializer.Deserialize<CepResposta>(jsonResponse);
            
            return resposta;
        }
        catch (HttpRequestException)
        {
            // Ocorre se estiver sem internet ou se a API estiver fora do ar
            return null;
        }
    }
}
```

---

## 4. Conectando a API aos TextBoxes da Tela

No formulário, quando o usuário digitar o CEP e clicar no botão "Buscar CEP", chamamos o serviço de forma assíncrona para que a tela não congele:

```csharp
private async void btnBuscarCep_Click(object sender, EventArgs e)
{
    string cepInput = txtCep.Text;

    if (string.IsNullOrWhiteSpace(cepInput))
    {
        MessageBox.Show("Digite um CEP primeiro.");
        return;
    }

    ViaCepService service = new ViaCepService();
    
    try
    {
        this.Cursor = Cursors.WaitCursor; // Mostra cursor de carregamento

        // Aguarda a resposta da API na internet
        CepResposta endereco = await service.BuscarEnderecoPorCepAsync(cepInput);

        if (endereco != null && !endereco.erro)
        {
            // Preenche automaticamente as caixas de texto com o retorno
            txtRua.Text = endereco.logradouro;
            txtBairro.Text = endereco.bairro;
            txtCidade.Text = endereco.localidade;
            txtEstado.Text = endereco.uf;
        }
        else
        {
            MessageBox.Show("CEP não encontrado.");
        }
    }
    catch (Exception ex)
    {
        MessageBox.Show($"Falha ao buscar CEP: {ex.Message}");
    }
    finally
    {
        this.Cursor = Cursors.Default; // Restaura cursor
    }
}
```
Com isso, você consegue otimizar drasticamente a velocidade de cadastro de endereços dos seus clientes!
