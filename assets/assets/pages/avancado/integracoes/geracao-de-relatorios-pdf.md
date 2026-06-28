Gerar relatórios impressos ou exportá-los em formato PDF é um requisito quase universal para sistemas de gestão (ERP). No C#, a forma mais eficiente de realizar essa tarefa sem depender de ferramentas visuais caras de terceiros é utilizar bibliotecas de código aberto no NuGet, como a **PdfSharp** ou **QuestPDF**.

Vamos ver como gerar um PDF estruturado de forma programática.

---

## 1. Instalando a biblioteca PdfSharp

1.  Abra o Gerenciador de Pacotes NuGet do seu projeto.
2.  Pesquise por `PdfSharp` e clique em Instalar.

---

## 2. Escrevendo o Código de Geração de PDF

O `PdfSharp` funciona desenhando elementos em uma página virtual, utilizando uma lógica muito parecida com a que vimos no artigo de GDI+ (desenho customizado).

```csharp
using System.IO;
using System.Windows.Forms;
using PdfSharp.Drawing;
using PdfSharp.Pdf;

public void GerarPdfSimples(string caminhoDestino)
{
    // 1. Cria um novo documento PDF vazio
    PdfDocument documento = new PdfDocument();
    documento.Info.Title = "Relatório de Vendas GEGB";

    // 2. Cria uma página em branco no tamanho A4
    PdfPage pagina = documento.AddPage();

    // 3. Obtém o objeto Graphics para desenhar na página
    XGraphics gfx = XGraphics.FromPdfPage(pagina);

    // 4. Define as fontes que usaremos no documento
    XFont fonteTitulo = new XFont("Arial", 20, XFontStyle.Bold);
    XFont fonteTexto = new XFont("Arial", 12, XFontStyle.Regular);

    // 5. Desenha o Título do Relatório
    // Parâmetros: Texto, Fonte, Pincel de cor, retângulo da página, alinhamento
    gfx.DrawString("Relatório de Vendas", 
                   fonteTitulo, 
                   XBrushes.Black, 
                   new XRect(0, 40, pagina.Width, 50), 
                   XStringFormats.Center);

    // 6. Desenha uma linha divisória decorativa
    gfx.DrawLine(XPens.Gray, 40, 90, pagina.Width - 40, 90);

    // 7. Escreve o conteúdo do relatório
    int linhaY = 120;
    string[] vendas = {
        "Item 1: Notebook Gamer - R$ 4500,00",
        "Item 2: Mouse Sem Fio - R$ 89,90",
        "Item 3: Teclado Mecânico - R$ 249,90"
    };

    foreach (string venda in vendas)
    {
        // Desenha cada linha da venda na página virtual
        gfx.DrawString(venda, 
                       fonteTexto, 
                       XBrushes.DarkSlateGray, 
                       40, 
                       linhaY);
        
        linhaY += 25; // Move o cursor vertical para a próxima linha
    }

    // 8. Desenha o rodapé
    gfx.DrawLine(XPens.Gray, 40, pagina.Height - 60, pagina.Width - 40, pagina.Height - 60);
    gfx.DrawString("Gerado pelo Sistema GEGB - Todos os direitos reservados.", 
                   new XFont("Arial", 9, XFontStyle.Italic), 
                   XBrushes.Gray, 
                   40, 
                   pagina.Height - 50);

    // 9. Salva o arquivo fisicamente no disco
    documento.Save(caminhoDestino);
    documento.Close();
}
```

---

## 3. Disparando a Geração via Botão

Você pode acionar essa lógica combinando-a com o `SaveFileDialog` que vimos anteriormente:

```csharp
private void btnExportarPdf_Click(object sender, EventArgs e)
{
    using (SaveFileDialog sfd = new SaveFileDialog())
    {
        sfd.Filter = "Documento PDF (*.pdf)|*.pdf";
        sfd.FileName = "Relatorio_De_Vendas.pdf";

        if (sfd.ShowDialog() == DialogResult.OK)
        {
            try
            {
                GerarPdfSimples(sfd.FileName);
                MessageBox.Show("Relatório em PDF gerado com sucesso!", "Exportação Concluída", 
                                MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Falha crítica ao gerar PDF: {ex.Message}", "Erro", 
                                MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
```
