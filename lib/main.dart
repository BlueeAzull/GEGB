import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/topbar.dart';
import 'widgets/pages.dart';
import 'widgets/sidebar.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

final ValueNotifier<bool> sidebarNotifier = ValueNotifier<bool>(true);

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
  "contato": Content(
    title: "Contato uiui",
    assetPath: "assets/pages/contato.md",
  ),

  // testes
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

  // return Scaffold(
  //   backgroundColor: const Color(0xFF212121),
  //   body: ValueListenableBuilder<bool>(
  //     valueListenable: sidebarNotifier,
  //     builder: (context, isSidebarVisible, child) {
  //       return Row(
  //         children: [
  //           AnimatedSize(
  //             duration: const Duration(milliseconds: 250),
  //             curve: Curves.easeInOut,
  //             child: isSidebarVisible
  //                 ? const SizedBox(width: 280, child: Sidebar())
  //                 : const SizedBox.shrink(),
  //           ),

  //           Expanded(
  //             child: Column(
  //               children: [
  //                 const Topbar(),
  //                 Expanded(
  //                   child:
  //                       content ??
  //                       Center(
  //                         child: Text(
  //                           "Erro: A chave '$nome' não foi encontrada no mapa de páginas.",
  //                           style: const TextStyle(
  //                             color: Colors.orangeAccent,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   ),
  // );
}

Widget _construirLayoutDoApp(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return Scaffold(
    backgroundColor: const Color(0xFF212121),
    body: ValueListenableBuilder<bool>(
      valueListenable: sidebarNotifier,
      builder: (context, isSidebarVisible, _) {
        return Row(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: isSidebarVisible
                  ? const SizedBox(width: 280, child: Sidebar())
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
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
