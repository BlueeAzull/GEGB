import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class DropMenu extends StatefulWidget{
  const DropMenu({super.key});

  @override
  State<StatefulWidget> createState() => DropmenuState();

}

class DropmenuState extends State<DropMenu>{
  String PaginaSelecionada = "planos";
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.menu, color: Colors.white),

      onSelected: (NovaPagina){
        GoRouter.of(context).go("/$NovaPagina");
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "planos",
          child: Text("Planos"),
        ),
        PopupMenuItem(
          value: "contato",
          child: Text("Contato"),
        ),
      ],
    );
    
  }
}
/*

*/