Para armazenar as informações do seu aplicativo de forma permanente, precisamos de um Banco de Dados Relacional. O **MySQL** é um dos bancos mais robustos, populares e fáceis de configurar localmente.

---

## 1. Instalando o Servidor e a Interface Gráfica

A Microsoft e a Oracle recomendam instalar as seguintes ferramentas gratuitas:

1.  **MySQL Installer (Community Edition):** Baixe do site oficial [dev.mysql.com/downloads/installer](https://dev.mysql.com/downloads/installer).
2.  Durante a instalação, escolha o modo de instalação **Developer Default** ou selecione manualmente:
    *   *MySQL Server:* O serviço que armazena os dados.
    *   *MySQL Workbench:* A ferramenta gráfica (programa) para gerenciar o banco e criar comandos SQL.
3.  **Configuração de Senha:** Durante a instalação do servidor, você criará a senha do usuário administrador (`root`). **Não esqueça esta senha!** Ela será necessária na string de conexão do C#.

---

## 2. Criando o Banco de Dados (Schema)

Abra o **MySQL Workbench** e conecte-se à sua instância local. Em seguida, clique no botão de "New SQL Tab" e execute o comando abaixo para criar seu primeiro banco de dados:

```sql
CREATE DATABASE gegb_db;
USE gegb_db;
```
*(Para executar os comandos, clique no ícone de raio no topo da aba de texto do Workbench).*

---

## 3. Criando as Tabelas (DDL)

Agora que temos o banco de dados criado e selecionado, vamos criar uma tabela chamada `produtos` para armazenar nosso cadastro. O script define os tipos das colunas:

```sql
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- Chave primária que se auto-incrementa a cada cadastro
    nome VARCHAR(100) NOT NULL,               -- Texto com limite de 100 caracteres (obrigatório)
    preco DECIMAL(10, 2) NOT NULL,            -- Valor decimal (dinheiro), máximo 10 dígitos com 2 casas decimais
    estoque INT DEFAULT 0                     -- Quantidade em estoque, inicia com 0 se não informado
);
```

---

## 4. Testando Inserções Diretamente no Banco

Antes de programar no C#, é uma boa prática popular o banco com alguns registros de teste diretamente via comandos SQL:

```sql
-- Insere registros de teste
INSERT INTO produtos (nome, preco, estoque) VALUES ('Teclado Gamer', 189.90, 15);
INSERT INTO produtos (nome, preco, estoque) VALUES ('Mouse Sem Fio', 79.90, 30);

-- Consulta os registros inseridos
SELECT * FROM produtos;
```

Com o banco de dados estruturado e populado localmente, estamos prontos para conectar o C# a ele.
