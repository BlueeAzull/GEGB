Ao construir aplicações complexas com recursos avançados (como threads, conexões web e gráficos customizados), a atenção às boas práticas deve ser redobrada para evitar travamentos inexplicáveis, lentidão e consumo excessivo de memória (*Memory Leaks*).

---

## 1. Evite Vazamentos de Recursos Nativos (GDI+ e Arquivos)

Muitas classes do .NET que lidam com manipulação de hardware (como arquivos de texto, streams de dados, fontes tipográficas, imagens carregadas e pincéis de desenho) não são limpas imediatamente pelo Garbage Collector automático do C#.
*   Elas implementam a interface `IDisposable`.
*   **Boas Práticas:** Sempre envolva a instanciação dessas classes na instrução `using` para garantir que os recursos nativos sejam descartados fisicamente da memória RAM e do sistema de arquivos imediatamente após o uso.

```csharp
// Forma correta: fecha o arquivo e libera a memória mesmo se houver erro
using (StreamWriter escritor = new StreamWriter("log.txt"))
{
    escritor.WriteLine("Mensagem de log");
}
```

---

## 2. O Perigo de Vazamento de Memória por Eventos Órfãos

Se você tem uma classe de dados de longa duração (como um serviço estático de notificação de rede) e assina um evento dela a partir de um Formulário:

```csharp
ServidorNotificacoes.MensagemRecebida += TratarMensagemRecebida;
```

Quando o usuário fechar o Formulário, a tela **continuará presa na memória RAM**! Isso ocorre porque o `ServidorNotificacoes` (que é de longa duração) ainda possui uma referência direta para o método do formulário, impedindo que o Garbage Collector limpe a tela.
*   **Boas Práticas:** Sempre se desinscreva de eventos de classes globais ou de longa duração no método de fechamento (`FormClosed` ou no método `Dispose`) do seu formulário:

```csharp
private void frmPrincipal_FormClosed(object sender, FormClosedEventArgs e)
{
    // Remove a assinatura do evento para permitir que o Garbage Collector limpe esta tela da memória
    ServidorNotificacoes.MensagemRecebida -= TratarMensagemRecebida;
}
```

---

## 3. Reutilização de Instâncias de HttpClient

Instanciar um novo `HttpClient` a cada chamada HTTP de API REST parece natural, mas causa um problema sério no sistema operacional chamado **Socket Exhaustion** (esgotamento de portas de rede). Mesmo quando você fecha o `HttpClient` usando `using`, o sistema operacional mantém as conexões de rede em modo de espera (`TIME_WAIT`) por até 4 minutos.
*   **Boas Práticas:** Declare o `HttpClient` como um campo de classe estático e privado e reutilize a mesma única instância para todas as chamadas do seu aplicativo.

```csharp
public class MeuServicoWeb
{
    // Instância única reutilizável em todas as chamadas
    private static readonly HttpClient _httpClient = new HttpClient();
}
```

---

## 4. Gerenciamento Inteligente de Erros Assíncronos

Ao disparar métodos assíncronos (`async Task`), nunca engula exceções silenciosamente. Tratamento de exceções adequado deve cobrir chamadas de rede e processamentos de fundo.
*   Se o usuário estiver sem conexão à internet e a API REST falhar, o código deve notificar de forma educada e permitir a tentativa de nova busca, sem travar silenciosamente.
