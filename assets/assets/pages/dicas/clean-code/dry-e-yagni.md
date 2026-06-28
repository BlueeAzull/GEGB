Ao desenvolver aplicações, a complexidade é a sua pior inimiga. Para manter o código simples de ler e barato de manter, seguimos princípios consagrados de engenharia de software: **DRY** e **YAGNI**.

---

## 1. DRY: Don't Repeat Yourself (Não se Repita)

O princípio **DRY** dita que toda peça de conhecimento ou lógica deve ter uma representação única, clara e autoritativa dentro do sistema.
*   **O Problema:** Copiar e colar o mesmo bloco de código em múltiplos lugares (ex: a mesma lógica de formatação de CNPJ em 3 telas diferentes). Se a regra de validação mudar, você precisará encontrar e editar todos os arquivos copiados, o que aumenta a chance de esquecer algum e gerar bugs.
*   **A Solução:** Extraia a lógica comum para uma classe utilitária de funções ou crie um método auxiliar que possa ser reutilizado.

### Exemplo: Validação repetida de e-mails em caixas de texto
Em vez de validar se o formato do e-mail é correto diretamente nos eventos de clique de várias telas, crie um validador estático único:

```csharp
public static class Validador
{
    public static bool ValidarEmail(string email)
    {
        if (string.IsNullOrWhiteSpace(email)) return false;
        return email.Contains("@") && email.Contains(".");
    }
}
```

E em qualquer tela, você apenas chama:
```csharp
if (!Validador.ValidarEmail(txtEmail.Text))
{
    MessageBox.Show("E-mail inválido.");
}
```

---

## 2. YAGNI: You Aren't Gonna Need It (Você Não Vai Precisar Disso)

O princípio **YAGNI** afirma que você não deve adicionar funcionalidades ao software até que elas sejam realmente necessárias e solicitadas.
*   **O Problema:** Desenvolvedores adoram tentar adivinhar o futuro. Pensam: *"Vou passar 3 dias escrevendo um sistema genérico de auditoria de logs e exportação de PDF multilíngue, porque um dia o cliente pode querer usar o aplicativo em outro país"*.
*   **A Consequência:** Isso gera um código gigante, complexo, difícil de manter, que consome tempo de desenvolvimento precioso do projeto atual e, na maioria das vezes, **nunca** será usado.
*   **A Solução:** Foque em entregar o escopo atual com o código mais simples e limpo possível. Se uma funcionalidade for solicitada no futuro, o design limpo permitirá adicioná-la sem sofrimento.
