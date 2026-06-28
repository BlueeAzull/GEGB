Para manter seu banco de dados MySQL performático e livre de corrupções de dados, siga estas diretrizes essenciais ao integrar seu código C#:

---

## 1. Proteção Absoluta contra SQL Injection

Este é o item mais importante de segurança de banco de dados.
*   **Nunca** junte variáveis de texto diretamente dentro de uma string de query SQL (`"SELECT * FROM... '" + txt + "'"`).
*   **Sempre** utilize parâmetros (`MySqlCommand.Parameters.AddWithValue()`). Os parâmetros tratam caracteres especiais (como aspas simples e comandos SQL) garantindo que sejam interpretados apenas como texto inofensivo pelo banco.

---

## 2. Escolha Correta de Tipos de Dados no Banco

*   **Valores Monetários / Preços:** Use sempre o tipo `DECIMAL` no banco de dados (ex: `DECIMAL(10,2)`) e `decimal` no C#. Nunca use `FLOAT` ou `DOUBLE`, pois eles sofrem de imprecisão de arredondamento binário.
*   **Datas:** Use `DATETIME` ou `DATE` no banco de dados e mapeie para o tipo `DateTime` no C#. Evite salvar datas como strings comum (`VARCHAR`), pois isso impede ordenação lógica e cálculos de datas (como saber quantos dias se passaram entre duas datas).

---

## 3. Gestão Inteligente do Ciclo de Vida da Conexão

*   Abra a conexão o mais tarde possível (apenas antes de rodar o comando) e feche o mais cedo possível.
*   **Nunca** declare conexões estáticas globais abertas indefinidamente.
*   Utilize a instrução `using` do C# para envelopar conexões. Ela chama o método `.Dispose()` implicitamente, liberando a conexão física no servidor MySQL de forma garantida, mesmo sob cenários de exceções.

---

## 4. Chaves Estrangeiras (Foreign Keys) e Integridade Referencial

Nunca ligue tabelas de forma artificial usando apenas campos do tipo inteiro simples.
*   Defina explicitamente as restrições de chave estrangeira (`FOREIGN KEY`) no banco de dados.
*   Isso impede que uma venda seja cadastrada para um cliente que não existe, ou que um produto cadastrado em vendas anteriores seja excluído acidentalmente do banco de dados, protegendo a integridade histórica dos dados fiscais do sistema.

---

## 5. Centralize a Configuração de Acesso

*   Nunca escreva a string de conexão repetida em várias classes.
*   Utilize uma classe utilitária de conexão (como a classe `Conexao.cs`) ou leia a string diretamente do arquivo de configuração do sistema (`App.config` ou `appsettings.json`). Isso permite migrar de servidor mudando apenas uma linha em um arquivo de texto de configuração externa.
