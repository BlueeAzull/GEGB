# GEGB

Guia de Estudos do Grupo B, uma coleção de conteúdo sobre desenvolver aplicativos em C# no Visual Studio, criado para apoiar os estudantes defasados pela presença do lindo (feio) e incrível (horrível) professor.

## Como adicionar páginas

Para adicionar páginas, siga este processo:

1. Crie a página como um arquivo `.md` em `assets/pages`. Adicione subcategorias se necessário.
2. Registre a página no arquivo `pubspec.yaml` na linha 69 (nice), em `assets`.
3. No arquivo `main.dart`, registre a página na array de páginas seguindo o exemplo.

```dart
	"pagekey": Content(
		title: "titulo",
		assetPath: "assets/pages/pagina-ou-categoria",
	),
```

Repita para mais páginas. 4. Em `assets/sidebar_list.json`, registre a página ou categoria seguindo os exemplos já presentes no arquivo. Lembre-se da pageKey da página. 5. Seu arquivo .md foi salvo com sucesso!!!!!!
