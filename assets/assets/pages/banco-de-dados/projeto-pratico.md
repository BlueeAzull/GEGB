Para colocar em prática todo o conhecimento adquirido sobre conexão com banco de dados, consultas SQL e arquitetura de software, você irá construir um **Gerenciador de Livros (Sistema de Biblioteca)** completo.

Esse projeto é ideal para consolidar as quatro operações do CRUD (Create, Read, Update, Delete) em uma aplicação Windows Forms conectada ao MySQL.

> Sugerimos que tente realizar o projeto por si só, e ler a este artigo somente quando não conseguir fazer mais progresso.

---

## 1. O Banco de Dados (MySQL)

Primeiro, abra seu gerenciador de banco de dados (MySQL Workbench, DBeaver ou similar) e execute o script abaixo para criar a tabela que usaremos no projeto:

```sql
CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

CREATE TABLE IF NOT EXISTS livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    ano_publicacao INT NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);
```

---

## 2. A Interface Gráfica (UI) no Visual Studio

No seu projeto Windows Forms, crie uma tela amigável. Recomendamos adicionar os seguintes componentes de interface:

1. **TextBoxes**:
   * `txtTitulo` (para o título do livro)
   * `txtAutor` (para o autor)
   * `txtAno` (para o ano de publicação)
2. **ComboBox**:
   * `cmbGenero` (com itens pré-definidos como: Ficção, Fantasia, Terror, Científico, Biografia)
3. **CheckBox**:
   * `chkDisponivel` (marcado por padrão como disponível)
4. **DataGridView**:
   * `dgvLivros` (para listar os livros cadastrados)
5. **Buttons**:
   * `btnCadastrar` (Salvar novo livro)
   * `btnEditar` (Atualizar informações de um livro selecionado)
   * `btnExcluir` (Deletar o livro do banco)
   * `btnLimpar` (Limpar os campos de texto)
6. **TextBox para Busca**:
   * `txtPesquisa` (para buscar livros pelo título/autor em tempo real)

---

## 3. Criando a Classe de Modelo (`Livro.cs`)

Crie uma classe simples para representar o objeto Livro no C#. Isso facilita o transporte de dados entre a interface e o banco.

```csharp
public class Livro
{
    public int Id { get; set; }
    public string Titulo { get; set; }
    public string Autor { get; set; }
    public string Genero { get; set; }
    public int AnoPublicacao { get; set; }
    public bool Disponivel { get; set; }

    public Livro() { }

    public Livro(int id, string titulo, string autor, string genero, int anoPublicacao, bool disponivel)
    {
        Id = id;
        Titulo = titulo;
        Autor = autor;
        Genero = genero;
        AnoPublicacao = anoPublicacao;
        Disponivel = disponivel;
    }
}
```

---

## 4. O Repositório de Acesso a Dados (`LivroRepository.cs`)

Esta classe será responsável por conter todas as queries SQL e a interação direta com o MySQL, deixando o código do seu Form muito mais limpo.

```csharp
using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Windows.Forms;

public class LivroRepository
{
    // C - CREATE: Inserir um novo livro
    public bool Inserir(Livro livro)
    {
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "INSERT INTO livros (titulo, autor, genero, ano_publicacao, disponivel) " +
                         "VALUES (@titulo, @autor, @genero, @ano, @disponivel)";

            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@titulo", livro.Titulo);
                cmd.Parameters.AddWithValue("@autor", livro.Autor);
                cmd.Parameters.AddWithValue("@genero", livro.Genero);
                cmd.Parameters.AddWithValue("@ano", livro.AnoPublicacao);
                cmd.Parameters.AddWithValue("@disponivel", livro.Disponivel);

                try
                {
                    conn.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
                catch (MySqlException ex)
                {
                    MessageBox.Show($"Erro ao cadastrar livro: {ex.Message}");
                    return false;
                }
            }
        }
    }

    // R - READ: Listar todos os livros (retorna um DataTable para ligar no DataGridView)
    public DataTable ListarTodos()
    {
        DataTable tabela = new DataTable();
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "SELECT id AS 'ID', titulo AS 'Título', autor AS 'Autor', " +
                         "genero AS 'Gênero', ano_publicacao AS 'Ano de Publicação', " +
                         "disponivel AS 'Disponível' FROM livros";

            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                try
                {
                    conn.Open();
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                    {
                        adapter.Fill(tabela);
                    }
                }
                catch (MySqlException ex)
                {
                    MessageBox.Show($"Erro ao listar livros: {ex.Message}");
                }
            }
        }
        return tabela;
    }

    // R - READ: Filtrar livros pelo título ou autor
    public DataTable Buscar(string termo)
    {
        DataTable tabela = new DataTable();
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "SELECT id AS 'ID', titulo AS 'Título', autor AS 'Autor', " +
                         "genero AS 'Gênero', ano_publicacao AS 'Ano de Publicação', " +
                         "disponivel AS 'Disponível' FROM livros " +
                         "WHERE titulo LIKE @termo OR autor LIKE @termo";

            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                // O sinal '%' serve como caractere curinga no SQL
                cmd.Parameters.AddWithValue("@termo", $"%{termo}%");

                try
                {
                    conn.Open();
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                    {
                        adapter.Fill(tabela);
                    }
                }
                catch (MySqlException ex)
                {
                    MessageBox.Show($"Erro ao buscar livros: {ex.Message}");
                }
            }
        }
        return tabela;
    }

    // U - UPDATE: Atualizar dados de um livro existente
    public bool Atualizar(Livro livro)
    {
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "UPDATE livros SET titulo = @titulo, autor = @autor, genero = @genero, " +
                         "ano_publicacao = @ano, disponivel = @disponivel WHERE id = @id";

            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", livro.Id);
                cmd.Parameters.AddWithValue("@titulo", livro.Titulo);
                cmd.Parameters.AddWithValue("@autor", livro.Autor);
                cmd.Parameters.AddWithValue("@genero", livro.Genero);
                cmd.Parameters.AddWithValue("@ano", livro.AnoPublicacao);
                cmd.Parameters.AddWithValue("@disponivel", livro.Disponivel);

                try
                {
                    conn.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
                catch (MySqlException ex)
                {
                    MessageBox.Show($"Erro ao atualizar livro: {ex.Message}");
                    return false;
                }
            }
        }
    }

    // D - DELETE: Remover livro permanentemente
    public bool Excluir(int id)
    {
        using (MySqlConnection conn = Conexao.ObterConexao())
        {
            string sql = "DELETE FROM livros WHERE id = @id";

            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@id", id);

                try
                {
                    conn.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
                catch (MySqlException ex)
                {
                    MessageBox.Show($"Erro ao excluir livro: {ex.Message}");
                    return false;
                }
            }
        }
    }
}
```

---

## 5. Implementando o Código no Form (`FormBiblioteca.cs`)

Agora, conecte a lógica visual ao repositório de banco de dados. No código por trás do seu formulário:

```csharp
using System;
using System.Data;
using System.Windows.Forms;

public partial class FormBiblioteca : Form
{
    private readonly LivroRepository _repository;
    private int _idSelecionado = 0; // Guarda o ID do livro clicado no Grid

    public FormBiblioteca()
    {
        InitializeComponent();
        _repository = new LivroRepository();
    }

    // Evento disparado ao carregar o Form
    private void FormBiblioteca_Load(object sender, EventArgs e)
    {
        CarregarGrid();
    }

    // Método auxiliar para atualizar o Grid
    private void CarregarGrid()
    {
        dgvLivros.DataSource = _repository.ListarTodos();
    }

    // Ação do botão Cadastrar
    private void btnCadastrar_Click(object sender, EventArgs e)
    {
        if (!ValidarCampos()) return;

        Livro novoLivro = new Livro
        {
            Titulo = txtTitulo.Text.Trim(),
            Autor = txtAutor.Text.Trim(),
            Genero = cmbGenero.SelectedItem.ToString(),
            AnoPublicacao = int.Parse(txtAno.Text.Trim()),
            Disponivel = chkDisponivel.Checked
        };

        if (_repository.Inserir(novoLivro))
        {
            MessageBox.Show("Livro cadastrado com sucesso!");
            LimparCampos();
            CarregarGrid();
        }
    }

    // Evento de clique em uma linha do DataGridView
    private void dgvLivros_CellClick(object sender, DataGridViewCellEventArgs e)
    {
        // Garante que o clique foi em uma linha válida (não no cabeçalho)
        if (e.RowIndex >= 0)
        {
            DataGridViewRow row = dgvLivros.Rows[e.RowIndex];
            
            _idSelecionado = Convert.ToInt32(row.Cells["ID"].Value);
            txtTitulo.Text = row.Cells["Título"].Value.ToString();
            txtAutor.Text = row.Cells["Autor"].Value.ToString();
            cmbGenero.SelectedItem = row.Cells["Gênero"].Value.ToString();
            txtAno.Text = row.Cells["Ano de Publicação"].Value.ToString();
            chkDisponivel.Checked = Convert.ToBoolean(row.Cells["Disponível"].Value);
        }
    }

    // Ação do botão Editar
    private void btnEditar_Click(object sender, EventArgs e)
    {
        if (_idSelecionado == 0)
        {
            MessageBox.Show("Selecione um livro na tabela primeiro!");
            return;
        }

        if (!ValidarCampos()) return;

        Livro livroEditado = new Livro
        {
            Id = _idSelecionado,
            Titulo = txtTitulo.Text.Trim(),
            Autor = txtAutor.Text.Trim(),
            Genero = cmbGenero.SelectedItem.ToString(),
            AnoPublicacao = int.Parse(txtAno.Text.Trim()),
            Disponivel = chkDisponivel.Checked
        };

        if (_repository.Atualizar(livroEditado))
        {
            MessageBox.Show("Livro atualizado com sucesso!");
            LimparCampos();
            CarregarGrid();
        }
    }

    // Ação do botão Excluir
    private void btnExcluir_Click(object sender, EventArgs e)
    {
        if (_idSelecionado == 0)
        {
            MessageBox.Show("Selecione um livro na tabela primeiro!");
            return;
        }

        DialogResult confirmacao = MessageBox.Show(
            "Tem certeza de que deseja excluir permanentemente este livro?",
            "Confirmar Exclusão",
            MessageBoxButtons.YesNo,
            MessageBoxIcon.Warning
        );

        if (confirmacao == DialogResult.Yes)
        {
            if (_repository.Excluir(_idSelecionado))
            {
                MessageBox.Show("Livro excluído com sucesso!");
                LimparCampos();
                CarregarGrid();
            }
        }
    }

    // Evento de alteração de texto na busca (pesquisa em tempo real)
    private void txtPesquisa_TextChanged(object sender, EventArgs e)
    {
        string busca = txtPesquisa.Text.Trim();
        if (string.IsNullOrEmpty(busca))
        {
            CarregarGrid();
        }
        else
        {
            dgvLivros.DataSource = _repository.Buscar(busca);
        }
    }

    // Método auxiliar para limpar o formulário
    private void LimparCampos()
    {
        txtTitulo.Clear();
        txtAutor.Clear();
        txtAno.Clear();
        cmbGenero.SelectedIndex = -1;
        chkDisponivel.Checked = true;
        _idSelecionado = 0;
    }

    private void btnLimpar_Click(object sender, EventArgs e)
    {
        LimparCampos();
    }

    // Validação básica de entradas do usuário
    private bool ValidarCampos()
    {
        if (string.IsNullOrWhiteSpace(txtTitulo.Text) || 
            string.IsNullOrWhiteSpace(txtAutor.Text) ||
            cmbGenero.SelectedIndex == -1)
        {
            MessageBox.Show("Preencha todos os campos obrigatórios (Título, Autor e Gênero).");
            return false;
        }

        if (!int.TryParse(txtAno.Text, out int ano) || ano < 0 || ano > DateTime.Now.Year)
        {
            MessageBox.Show($"Insira um ano de publicação válido (numérico entre 0 e {DateTime.Now.Year}).");
            return false;
        }

        return true;
    }
}
```

---

## 6. Desafios Extras para Evoluir o Projeto

Depois de concluir o CRUD básico acima, tente implementar estas melhorias para aprofundar seu aprendizado:

1. **Exclusão Lógica**: Altere a operação de exclusão para que apenas mude a coluna `disponivel` ou `ativo` para `FALSE` em vez de deletar fisicamente da tabela (usando o `UPDATE`).
2. **Histórico de Empréstimos**: Crie uma segunda tabela `emprestimos` relacionando `livros` com uma tabela de `usuarios` usando chaves estrangeiras.
3. **Padrão de Validação**: Mova as validações de campos do Form para uma camada separada, garantindo maior reuso de código e organização.
