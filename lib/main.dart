import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/topbar.dart';
import 'widgets/pages.dart';
import 'widgets/sidebar.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

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
  // pages pré-sidebar
  "planos": Content(
    title: "planos (n deletar pfv)",
    assetPath: "assets/pages/planos.md",
  ),
  "contato": Content(title: "Contato", assetPath: "assets/pages/contato.md"),

  // testes
  // sem categoria
  "markdowntest": Content(
    title: "markdowntest",
    assetPath: "assets/pages/markdowntest.md",
  ),

  // categoria 1
  "categoria1/teste1": Content(
    title: "teste1",
    assetPath: "assets/pages/categoria1/teste1.md",
  ),

  // categoria2 (sub1 e sub2 respectivamente)
  "categoria2/subcategoria1/teste2": Content(
    title: "teste2",
    assetPath: "assets/pages/categoria2/subcategoria1/teste2.md",
  ),
  "categoria2/subcategoria2/teste3": Content(
    title: "teste3",
    assetPath: "assets/pages/categoria2/subcategoria2/teste3.md",
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
  initialLocation: "/planos",
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
