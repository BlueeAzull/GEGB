import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/topbar.dart';
import 'widgets/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}
Map<String, Content> paginas = {
    "planos" : Content(
      title: "planos (n deletar pfv)",
      assetPath: "lib/pages/planos.md",
    ),
    "contato": Content(
      title: "Contato uiui",
      assetPath: "lib/pages/contato.md",
    ),
  };


final GoRouter router = GoRouter(
  initialLocation: "/planos",
  routes: [
    GoRoute(
      path: "/:pagina",
      builder: (context, state) {
        final nome = state.pathParameters["pagina"]!;
        final content = paginas[nome];

        return Scaffold(
          appBar: Topbar(),
          backgroundColor: const Color(0xFF212121),
          body: content ??
              const Center(child: Text("Página não existe")),
        );
      },
    ),
  ],
);

class MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true
        ),
      )
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
