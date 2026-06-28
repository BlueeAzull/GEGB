O Windows possui diversas caixas de diálogo padrão que você pode reutilizar no seu sistema para interagir com o sistema de arquivos ou confirmar ações com o usuário.

---

## 1. MessageBox (Caixas de Mensagem)

O `MessageBox` é usado para exibir avisos rápidos, mensagens de erro ou pedir confirmações simples.

### Exemplo de Mensagem Informativa Simples
```csharp
MessageBox.Show("Operação concluída com sucesso!", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
```

### Exemplo de Pergunta com Confirmação (Yes/No)
Sempre capture o retorno (`DialogResult`) para saber em qual botão o usuário clicou antes de prosseguir com uma ação destrutiva:

```csharp
private void btnExcluir_Click(object sender, EventArgs e)
{
    DialogResult resultado = MessageBox.Show("Deseja realmente excluir este registro?", 
                                             "Confirmação", 
                                             MessageBoxButtons.YesNo, 
                                             MessageBoxIcon.Question);

    if (resultado == DialogResult.Yes)
    {
        // Executa a exclusão...
        MessageBox.Show("Registro apagado.");
    }
    else
    {
        // Cancela a operação
        MessageBox.Show("Exclusão cancelada.");
    }
}
```

---

## 2. OpenFileDialog (Diálogo para Abrir Arquivos)

Abre a tela do Windows Explorer para que o usuário escolha um arquivo.

*   `Filter`: Restringe quais tipos de arquivos podem ser visualizados (ex: apenas arquivos de texto ou apenas imagens).
*   `InitialDirectory`: Define em qual pasta o diálogo deve abrir por padrão.

```csharp
private void btnImportar_Click(object sender, EventArgs e)
{
    using (OpenFileDialog ofd = new OpenFileDialog())
    {
        ofd.Filter = "Documentos PDF (*.pdf)|*.pdf|Arquivos Word (*.docx)|*.docx";
        ofd.Title = "Selecione o contrato";

        if (ofd.ShowDialog() == DialogResult.OK)
        {
            string caminhoDoArquivo = ofd.FileName;
            MessageBox.Show($"Você selecionou o arquivo: {caminhoDoArquivo}");
        }
    }
}
```

---

## 3. SaveFileDialog (Diálogo para Salvar Arquivos)

Abre o gerenciador de arquivos para o usuário escolher em qual pasta e com qual nome deseja salvar um arquivo gerado pelo seu sistema.

```csharp
private void btnExportar_Click(object sender, EventArgs e)
{
    using (SaveFileDialog sfd = new SaveFileDialog())
    {
        sfd.Filter = "Planilha Excel (*.csv)|*.csv";
        sfd.FileName = "lista_clientes.csv";

        if (sfd.ShowDialog() == DialogResult.OK)
        {
            string caminhoOndeSalvar = sfd.FileName;
            // Código para gravar dados nesse caminho...
        }
    }
}
```

---

## 4. FolderBrowserDialog (Selecionar Pastas)

Usado quando você não precisa selecionar um arquivo específico, mas sim indicar uma pasta inteira no computador (por exemplo, escolher onde salvar um backup de dados).

```csharp
private void btnBackup_Click(object sender, EventArgs e)
{
    using (FolderBrowserDialog fbd = new FolderBrowserDialog())
    {
        fbd.Description = "Selecione a pasta de destino para o Backup";

        if (fbd.ShowDialog() == DialogResult.OK)
        {
            string pastaSelecionada = fbd.SelectedPath;
            MessageBox.Show($"O backup será salvo em: {pastaSelecionada}");
        }
    }
}
```
