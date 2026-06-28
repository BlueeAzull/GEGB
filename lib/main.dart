import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/topbar.dart';
import 'widgets/pages.dart';
import 'widgets/sidebar.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'yandex_metrika/yandex_metrika.dart';

final ValueNotifier<bool> sidebarNotifier = ValueNotifier<bool>(false);
final ValueNotifier<bool> isDarkThemeNotifier = ValueNotifier<bool>(true);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

Map<String, Content> paginas = {
  "inicio": Content(title: "Início", assetPath: "assets/pages/inicio.md"),
  "contato": Content(title: "Contato", assetPath: "assets/pages/contato.md"),


  // --- CATEGORIA 1: FUNDAMENTOS ---
  // Introdução
  "fundamentos/introducao/instalacao-visual-studio": Content(
    title: "Instalação do VS",
    assetPath: "assets/pages/fundamentos/introducao/instalacao-visual-studio.md",
  ),
  "fundamentos/introducao/anatomia-do-projeto": Content(
    title: "Anatomia do Projeto",
    assetPath: "assets/pages/fundamentos/introducao/anatomia-do-projeto.md",
  ),
  // Programação C#
  "fundamentos/programacao/variaveis-e-tipos": Content(
    title: "Variáveis e Tipos",
    assetPath: "assets/pages/fundamentos/programacao/variaveis-e-tipos.md",
  ),
  "fundamentos/programacao/estruturas-de-controle": Content(
    title: "Controle de Fluxo",
    assetPath: "assets/pages/fundamentos/programacao/estruturas-de-controle.md",
  ),
  "fundamentos/programacao/metodos-e-funcoes": Content(
    title: "Métodos e Funções",
    assetPath: "assets/pages/fundamentos/programacao/metodos-e-funcoes.md",
  ),
  // Orientação a Objetos
  "fundamentos/poo/classes-e-objetos": Content(
    title: "Classes e Objetos",
    assetPath: "assets/pages/fundamentos/poo/classes-e-objetos.md",
  ),
  "fundamentos/poo/heranca-e-polimorfismo": Content(
    title: "Herança e Polimorfismo",
    assetPath: "assets/pages/fundamentos/poo/heranca-e-polimorfismo.md",
  ),
  "fundamentos/boas-praticas": Content(
    title: "Boas Práticas (Fundamentos)",
    assetPath: "assets/pages/fundamentos/boas-praticas.md",
  ),

  // --- CATEGORIA 2: CONTROLES ---
  // Controles Básicos
  "controles/basicos/labels-e-buttons": Content(
    title: "Labels e Buttons",
    assetPath: "assets/pages/controles/basicos/labels-e-buttons.md",
  ),
  "controles/basicos/seletores-e-opcoes": Content(
    title: "Seletores e Opções",
    assetPath: "assets/pages/controles/basicos/seletores-e-opcoes.md",
  ),
  // Controles Avançados
  "controles/avancados/datagridview-essencial": Content(
    title: "DataGridView Essencial",
    assetPath: "assets/pages/controles/avancados/datagridview-essencial.md",
  ),
  "controles/avancados/listview-e-treeview": Content(
    title: "ListView e TreeView",
    assetPath: "assets/pages/controles/avancados/listview-e-treeview.md",
  ),
  // Controles de Layout
  "controles/layout/panels-e-groups": Content(
    title: "Panels e Groups",
    assetPath: "assets/pages/controles/layout/panels-e-groups.md",
  ),
  "controles/layout/responsividade": Content(
    title: "Responsividade",
    assetPath: "assets/pages/controles/layout/responsividade.md",
  ),
  // Caixas de Diálogo e Telas
  "controles/dialogos/dialogos-padrao": Content(
    title: "Diálogos Padrão",
    assetPath: "assets/pages/controles/dialogos/dialogos-padrao.md",
  ),
  "controles/dialogos/comunicacao-entre-forms": Content(
    title: "Comunicação entre Forms",
    assetPath: "assets/pages/controles/dialogos/comunicacao-entre-forms.md",
  ),
  "controles/boas-praticas": Content(
    title: "Boas Práticas (Controles)",
    assetPath: "assets/pages/controles/boas-praticas.md",
  ),

  // --- CATEGORIA 3: BANCO DE DADOS & CRUD ---
  // Configuração e Conexão
  "banco-de-dados/configuracao/instalacao-mysql": Content(
    title: "Instalação do MySQL",
    assetPath: "assets/pages/banco-de-dados/configuracao/instalacao-mysql.md",
  ),
  "banco-de-dados/conexao/classe-conexao": Content(
    title: "Classe de Conexão",
    assetPath: "assets/pages/banco-de-dados/conexao/classe-conexao.md",
  ),
  // Operações SQL
  "banco-de-dados/operacoes/inserir-e-consultar": Content(
    title: "Inserir e Consultar",
    assetPath: "assets/pages/banco-de-dados/operacoes/inserir-e-consultar.md",
  ),
  "banco-de-dados/operacoes/atualizar-e-excluir": Content(
    title: "Atualizar e Excluir",
    assetPath: "assets/pages/banco-de-dados/operacoes/atualizar-e-excluir.md",
  ),
  // Arquitetura
  "banco-de-dados/arquitetura/padrao-repository": Content(
    title: "Padrão Repository",
    assetPath: "assets/pages/banco-de-dados/arquitetura/padrao-repository.md",
  ),
  "banco-de-dados/arquitetura/camada-de-servicos": Content(
    title: "Camada de Serviços",
    assetPath: "assets/pages/banco-de-dados/arquitetura/camada-de-servicos.md",
  ),
  // Avançado de BD
  "banco-de-dados/avancado/transacoes": Content(
    title: "Transações SQL",
    assetPath: "assets/pages/banco-de-dados/avancado/transacoes.md",
  ),
  "banco-de-dados/projeto-pratico": Content(
    title: "Projeto Prático (CRUD)",
    assetPath: "assets/pages/banco-de-dados/projeto-pratico.md",
  ),
  "banco-de-dados/boas-praticas": Content(
    title: "Boas Práticas (Banco de Dados)",
    assetPath: "assets/pages/banco-de-dados/boas-praticas.md",
  ),

  // --- CATEGORIA 4: DICAS & CLEAN CODE ---
  "dicas/separacao-de-responsabilidades": Content(
    title: "Separação de Responsabilidades",
    assetPath: "assets/pages/dicas/separacao-de-responsabilidades.md",
  ),
  "dicas/codigo-confuso-vs-codigo-limpo": Content(
    title: "Código Confuso VS Limpo",
    assetPath: "assets/pages/dicas/codigo-confuso-vs-codigo-limpo.md",
  ),
  "dicas/clean-code/dry-e-yagni": Content(
    title: "DRY e YAGNI",
    assetPath: "assets/pages/dicas/clean-code/dry-e-yagni.md",
  ),
  "dicas/clean-code/retornos-precoces": Content(
    title: "Retornos Precoces",
    assetPath: "assets/pages/dicas/clean-code/retornos-precoces.md",
  ),
  "dicas/erros/try-catch-global": Content(
    title: "Try-Catch Global",
    assetPath: "assets/pages/dicas/erros/try-catch-global.md",
  ),
  "dicas/produtividade/atalhos-do-visual-studio": Content(
    title: "Atalhos do VS",
    assetPath: "assets/pages/dicas/produtividade/atalhos-do-visual-studio.md",
  ),
  "dicas/boas-praticas": Content(
    title: "Boas Práticas (Dicas)",
    assetPath: "assets/pages/dicas/boas-praticas.md",
  ),

  // --- CATEGORIA 5: PROGRAMAÇÃO AVANÇADA ---
  // Assincronismo
  "avancado/assincronismo/async-await": Content(
    title: "Async e Await",
    assetPath: "assets/pages/avancado/assincronismo/async-await.md",
  ),
  "avancado/assincronismo/background-worker-e-threads": Content(
    title: "Threads e BackgroundWorker",
    assetPath: "assets/pages/avancado/assincronismo/background-worker-e-threads.md",
  ),
  // Customização e Desenho
  "avancado/customizacao/desenho-customizado": Content(
    title: "Desenho Customizado (GDI+)",
    assetPath: "assets/pages/avancado/customizacao/desenho-customizado.md",
  ),
  // Integrações
  "avancado/integracoes/geracao-de-relatorios-pdf": Content(
    title: "Geração de PDF",
    assetPath: "assets/pages/avancado/integracoes/geracao-de-relatorios-pdf.md",
  ),
  "avancado/integracoes/consumo-de-apis": Content(
    title: "Consumo de APIs REST",
    assetPath: "assets/pages/avancado/integracoes/consumo-de-apis.md",
  ),
  // Deploy
  "avancado/deploy/gerar-executavel": Content(
    title: "Gerar Executável (.exe)",
    assetPath: "assets/pages/avancado/deploy/gerar-executavel.md",
  ),
  "avancado/boas-praticas": Content(
    title: "Boas Práticas (Avançado)",
    assetPath: "assets/pages/avancado/boas-praticas.md",
  ),
};

Widget _construirConteudoPagina(BuildContext context, GoRouterState state) {
  final nome = state.uri.path.replaceFirst('/', '');
  final content = paginas[nome];

  return content ??
      Center(
        child: Text(
          "Erro: A chave '$nome' não foi encontrada no mapa de páginas.",
          style: const TextStyle(color: Colors.orangeAccent, fontSize: 16),
        ),
      );
}

Widget _construirLayoutDoApp(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  final double larguraTela = MediaQuery.of(context).size.width;
  final bool isMobile = larguraTela < 700;
  return Scaffold(
    body: ValueListenableBuilder<bool>(
      valueListenable: sidebarNotifier,
      builder: (context, isSidebarVisible, _) {
        // mobile
        if (isMobile) {
          return Stack(
            children: [
              Column(
                children: [
                  const Topbar(),
                  Expanded(child: child),
                ],
              ),

              if (isSidebarVisible) ...[
                GestureDetector(
                  onTap: () => sidebarNotifier.value =
                      false, // Clicar fora fecha a sidebar
                  child: Container(color: Colors.black54),
                ),

                SafeArea(
                  child: Row(
                    children: [
                      SizedBox(
                        width: larguraTela * 0.52, // largura
                        child: const Sidebar(isMobile: true),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        }

        // desktop
        return Row(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: isSidebarVisible
                  ? const SizedBox(width: 280, child: Sidebar(isMobile: false))
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Column(
                children: [
                  const Topbar(),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}

final GoRouter router = GoRouter(
  initialLocation: "/inicio",
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return _construirLayoutDoApp(context, state, child);
      },
      routes: [
        // url de profundidade 1 (ex planos)
        GoRoute(path: "/:p1", builder: _construirConteudoPagina),
        // url de profundidade 2 (ex teste1)
        GoRoute(path: "/:p1/:p2", builder: _construirConteudoPagina),
        // url de profundidade 3 (ex teste2 e 3)
        GoRoute(path: "/:p1/:p2/:p3", builder: _construirConteudoPagina),
      ],
    ),
  ],
);

class MyAppState extends State<MyApp> {
  String? _lastRoute;

  @override
  void initState() {
    super.initState();
    router.routerDelegate.addListener(_onRouteChanged);
  }

  @override
  void dispose() {
    router.routerDelegate.removeListener(_onRouteChanged);
    super.dispose();
  }

  void _onRouteChanged() {
    final String currentRoute = router.routerDelegate.currentConfiguration.uri.toString();
    if (_lastRoute != currentRoute) {
      _lastRoute = currentRoute;
      trackPage(currentRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkThemeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp.router(
          onGenerateTitle: (context) => "GEGB",
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFFF5F5F5),
            extensions: const <ThemeExtension<dynamic>>[
              Temas(
                fundoSidebar: Color(0xFFE0E0E0),
                categoriaSidebar: Color.fromARGB(255, 207, 207, 207),
                itemPadraoSidebar: Color.fromARGB(255, 219, 219, 219),
                itemSelecionadoSidebar: Color(0xFFCCCCCC),
                texto: Colors.black87,
                textoUnselected: Color.fromARGB(221, 31, 31, 31),
              ),
            ],
          ),

          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF212121),
            extensions: const <ThemeExtension<dynamic>>[
              Temas(
                fundoSidebar: Color(0xFF1A1A1A),
                categoriaSidebar: Color.fromARGB(255, 24, 24, 24),
                itemPadraoSidebar: Color(0xFF1D1D1D),
                itemSelecionadoSidebar: Color(0xFF2E2E2E),
                texto: Colors.white,
                textoUnselected: Color.fromARGB(221, 218, 218, 218),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Temas extends ThemeExtension<Temas> {
  final Color fundoSidebar;
  final Color categoriaSidebar;
  final Color itemPadraoSidebar;
  final Color itemSelecionadoSidebar;
  final Color texto;
  final Color textoUnselected;

  const Temas({
    required this.fundoSidebar,
    required this.categoriaSidebar,
    required this.itemPadraoSidebar,
    required this.itemSelecionadoSidebar,
    required this.texto,
    required this.textoUnselected,
  });

  @override
  ThemeExtension<Temas> copyWith({
    Color? fundoSidebar,
    Color? categoriaSidebar,
    Color? itemPadraoSidebar,
    Color? itemSelecionadoSidebar,
    Color? texto,
    Color? textoUnselected,
  }) {
    return Temas(
      fundoSidebar: fundoSidebar ?? this.fundoSidebar,
      categoriaSidebar: categoriaSidebar ?? this.categoriaSidebar,
      itemPadraoSidebar: itemPadraoSidebar ?? this.itemPadraoSidebar,
      itemSelecionadoSidebar:
          itemSelecionadoSidebar ?? this.itemSelecionadoSidebar,
      texto: texto ?? this.texto,
      textoUnselected: textoUnselected ?? this.textoUnselected,
    );
  }

  @override
  ThemeExtension<Temas> lerp(ThemeExtension<Temas>? other, double t) {
    if (other is! Temas) return this;
    return Temas(
      fundoSidebar: Color.lerp(fundoSidebar, other.fundoSidebar, t)!,
      categoriaSidebar: Color.lerp(
        categoriaSidebar,
        other.categoriaSidebar,
        t,
      )!,
      itemPadraoSidebar: Color.lerp(
        itemPadraoSidebar,
        other.itemPadraoSidebar,
        t,
      )!,
      itemSelecionadoSidebar: Color.lerp(
        itemSelecionadoSidebar,
        other.itemSelecionadoSidebar,
        t,
      )!,
      texto: Color.lerp(texto, other.texto, t)!,
      textoUnselected: Color.lerp(textoUnselected, other.textoUnselected, t)!,
    );
  }
}

/*
Eu coloquei oq tava em ideias.txt aqui pq eu nn sei se deixar la fora vai fuder tudo
PERDÃO EEVEEEEEE
ai tu mexe dps pra organizar se tu quiser

BOAS PRATICAS SERA O CONTEUDO FINAL DE CADA SUB-CATEGORIA:
  -Boas Praticas

Fundamentos:
  -Telas
  -Basico de C#
  -POO(Programação Orientada a Objetos, oq é, onde usar, beneficios, Classes,  Herança, etc)
  
Basico De Forms:
  -Comunicação entre Forms
  -Mysql(Como baixar, como usar, onde usar, separação de logica)
  -CRUD(Create, Read, Update, Delete,Oq é, Onde usar)
  
Dicas:
  -Separação de responsabilidades
  -Codigo Confuso VS codigo Limpo


*/
