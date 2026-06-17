import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

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
                            listBullet: TextStyle(color: textColor),
                            code: TextStyle(
                              fontSize: 14,
                              color: Colors.greenAccent,
                              backgroundColor: Colors.transparent,
                              fontFamily: 'monospace',
                            ),
                            codeblockPadding: const EdgeInsets.all(16.0),
                            codeblockDecoration: BoxDecoration(
                              color: Colors.black,
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(text, style: preferredStyle),
    );
  }
}
