Aqui estão as principais diretrizes de boas práticas gerais de desenvolvimento que transformarão sua rotina de programação, aumentando a qualidade das suas entregas:

---

## 1. Comente o "Porquê", não o "O que"
O código deve ser legível por si só. Não escreva comentários redundantes que apenas repetem o que a instrução faz. Escreva comentários para explicar o motivo de uma decisão não óbvia ou de uma regra de negócio complexa.

*   **Ruim (Comentário Redundante):**
    ```csharp
    // Adiciona 1 ao contador
    contador++; 
    ```
*   **Bom (Comentário com Contexto):**
    ```csharp
    // Necessário incrementar o contador pois o banco de dados inicia o índice da API em 1
    contador++; 
    ```

---

## 2. Métodos Curtos e Focados
Um método deve fazer apenas uma coisa e fazê-la muito bem (Princípio da Responsabilidade Única). Se o seu método tem mais de 25 linhas, há uma grande chance de que ele possa ser quebrado em métodos menores.
*   **Dica:** Facilita muito os testes e a identificação de bugs.

---

## 3. A Regra do Escoteiro (*Boy Scout Rule*)
*"Deixe a área de acampamento mais limpa do que como você a encontrou."*
Ao mexer em um arquivo de código para adicionar uma funcionalidade ou corrigir um bug:
*   Se encontrar uma variável com nome ruim, renomeie-a.
*   Se encontrar código duplicado, refatore.
*   Se encontrar comentários obsoletos ou código morto, apague.
Dessa forma, a base de código do projeto melhora constantemente ao invés de apodrecer com o tempo.

---

## 4. Use Git e GitHub Corretamente
Não faça commits gigantescos de fim de dia com mensagens genéricas como *"ajustes"* ou *"projeto finalizado"*.
*   Faça commits pequenos e frequentes (ex: *"criação da classe Usuario"*, *"validação do campo CPF no formulário"*, *"correção de bug na exclusão de produto"*).
*   Use ramificações (*branches*) se estiver trabalhando em equipe para não quebrar a versão funcional que seu colega está testando.

---

## 5. Refatore assim que Funcionar
O fluxo de desenvolvimento ideal é:
1.  **Faça funcionar:** Escreva o código do jeito mais rápido para validar a lógica e ver se funciona.
2.  **Faça direito:** Limpe o código, remova duplicidades, renomeie variáveis temporárias, adicione tratamento de exceções.
3.  **Faça rápido:** Otimize a performance caso seja necessário (na maioria das vezes, o passo 2 já é suficiente).
**Nunca pule o passo 2!** O "depois eu arrumo" quase nunca acontece.
