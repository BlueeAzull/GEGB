import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:highlight/highlight.dart' show highlight, Node, Mode;
import 'package:highlight/languages/cs.dart';

class Content extends StatelessWidget {
  final String title;
  final String assetPath;

  const Content({Key? key, required this.title, required this.assetPath})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey[900];
    final textColor = Colors.grey[300];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: FutureBuilder<String>(
          future: rootBundle.loadString(assetPath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Erro ao carregar o arquivo.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final textMarkdown = snapshot.data ?? '';

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: SelectionArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: MarkdownBody(
                          data: textMarkdown,
                          builders: {'code': CodeBlockBuilder()},
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              height: 1.5,
                            ),
                            h1: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            h2: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            h3: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            listBullet: TextStyle(color: textColor),
                            blockquote: TextStyle(color: textColor),
                            blockquoteDecoration: BoxDecoration(
                              color: Colors.grey[800],
                            ),
                            code: TextStyle(
                              fontSize: 14,
                              color: Colors.greenAccent,
                              backgroundColor: Colors.transparent,
                              fontFamily: 'monospace',
                            ),
                            codeblockPadding: const EdgeInsets.all(16.0),
                            codeblockDecoration: BoxDecoration(
                              color: Color(0xFF282C35),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey[800]!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// CUSTOM MD BUILDERS

class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final String text = element.textContent;

    String language = 'csharp';
    if (element.attributes['class'] != null) {
      language = element.attributes['class']!.replaceAll('language-', '');
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF282C35), // Fundo do bloco de código
        borderRadius: BorderRadius.circular(8.0),
      ),
      // SelectableText.rich garante a prioridade 2 (selecionar trechos específicos)
      child: SelectableText.rich(
        TextSpan(
          children: _buildHighlightedSpans(text, language),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 14.0,
            color: Color(0xFFABB2BF), // Cor base padrão
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildHighlightedSpans(String source, String language) {
    _registerLanguage(language);
    final result = highlight.parse(source.trimRight(), language: language);
    return _toTextSpans(result.nodes ?? []);
  }

  void _registerLanguage(String language) {
    Map<String, Mode> langs = {'cs': cs, 'csharp': cs};
    final def = langs[language];
    if (def != null) {
      highlight.registerLanguage(language, def);
    }
  }

  // CORREÇÃO DA COR AQUI:
  List<TextSpan> _toTextSpans(List<Node> nodes) {
    return nodes.map((node) {
      if (node.value != null) {
        return TextSpan(
          text: node.value,
          style: _styleForClass(node.className),
        );
      }
      // Se o nó não tiver valor direto, ele tem filhos.
      // Precisamos de aplicar o estilo neste nó pai para que os filhos herdem a cor!
      return TextSpan(
        style: _styleForClass(node.className),
        children: _toTextSpans(node.children ?? []),
      );
    }).toList();
  }

  // Retorna a cor correta baseado na classe do token do Highlight
  TextStyle? _styleForClass(String? className) {
    if (className == null)
      return null; // Permite que o nó filho herde a cor do pai

    const styles = {
      'keyword': TextStyle(color: Color(0xFFC678DD)), // Roxo
      'string': TextStyle(color: Color(0xFF98C379)), // Verde
      'comment': TextStyle(
        color: Color(0xFF5C6370),
        fontStyle: FontStyle.italic,
      ), // Cinza
      'number': TextStyle(color: Color(0xFFD19A66)), // Laranja/Castanho
      'literal': TextStyle(color: Color(0xFF56B6C2)), // Ciano
      'type': TextStyle(color: Color(0xFFE5C07B)), // Amarelo/Bege
      'built_in': TextStyle(color: Color(0xFFE5C07B)), // Amarelo
      'title': TextStyle(color: Color(0xFF61AFEF)), // Azul
      'function': TextStyle(color: Color(0xFF61AFEF)), // Azul
      'attr': TextStyle(color: Color(0xFF56B6C2)), // Ciano
      'variable': TextStyle(color: Color(0xFFE06C75)), // Vermelho suave
      'meta': TextStyle(color: Color(0xFF56B6C2)), // Ciano
      'punctuation': TextStyle(color: Color(0xFFABB2BF)), // Cinza claro
    };

    return styles[className];
  }
}
