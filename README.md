# GEGB — Guia de Estudos do Grupo B

O **GEGB** é uma plataforma e guia de estudos interativo desenvolvido para consolidar, aprofundar e democratizar o aprendizado de desenvolvimento de software em C# e Windows Forms (WinForms).

O projeto nasceu com o intuito de apoiar os estudantes da nossa turma (especialmente os do Grupo B) a superarem dificuldades de ritmo ou metodologia nas aulas regulares, servindo como uma ponte para nivelar o conhecimento com o conteúdo avançado ministrado no Grupo A. Este guia será atualizado continuamente ao longo do ano letivo de forma a acompanhar e documentar cada etapa de nosso aprendizado.

---

## Como Executar o Projeto Localmente

Como a aplicação é construída com **Flutter**, você precisará do Flutter SDK instalado em sua máquina.

1. Instale as dependências do projeto:
   ```bash
   flutter pub get
   ```
2. Inicie o servidor de desenvolvimento ou execute no seu navegador/dispositivo de preferência:
   ```bash
   flutter run
   ```

---

## Como Adicionar Novas Páginas e Conteúdos

Para manter o guia atualizado com novas matérias ou dicas, siga o passo a passo a seguir para adicionar novas telas e artigos:

### 1. Criar o Arquivo de Conteúdo (.md)
Crie um arquivo com a extensão `.md` (Markdown) dentro do diretório `assets/pages/`. Se necessário, organize por subpastas (ex: `assets/pages/banco-de-dados/minha-materia.md`).

### 2. Registrar o Asset no `pubspec.yaml`
Para que o Flutter inclua o arquivo Markdown no pacote da aplicação, você precisa listá-lo no arquivo `pubspec.yaml` sob a seção `assets:`:
```yaml
flutter:
  assets:
    - assets/sidebar_list.json
    - assets/pages/banco-de-dados/minha-materia.md
```

### 3. Registrar a Rota e Conteúdo no `lib/main.dart`
Abra o arquivo `lib/main.dart` e localize o mapa global `paginas`. Adicione a nova chave identificadora (`pageKey`) correspondente e ligue ao construtor `Content`:
```dart
Map<String, Content> paginas = {
  // Exemplo de novo registro:
  "banco-de-dados/minha-materia": Content(
    title: "Título Exibido no Topo da Página",
    assetPath: "assets/pages/banco-de-dados/minha-materia.md",
  ),
};
```

### 4. Adicionar ao Menu Lateral em `assets/sidebar_list.json`
Para tornar a página acessível no menu de navegação lateral, insira o item no arquivo JSON. Se a página for um item de subcategoria:
```json
{
  "title": "Minha Matéria",
  "pageKey": "banco-de-dados/minha-materia"
}
```
Ou se estiver inserindo dentro de uma estrutura com mais filhos (`children`):
```json
{
  "title": "Banco de Dados & CRUD",
  "children": [
    {
      "title": "Minha Matéria",
      "pageKey": "banco-de-dados/minha-materia"
    }
  ]
}
```

### 5. Verificar e Rodar!
Após realizar os passos acima, execute `flutter pub get` novamente para atualizar a tabela de assets da aplicação e execute `flutter run` para testar sua nova página em tempo de execução.

---

## Responsáveis do Projeto

Você pode conferir a lista de idealizadores e contribuidores responsáveis por este material acessando a seção **Contate-nos** ou navegando até a rota `/contato` na barra superior da aplicação.
