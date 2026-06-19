import 'package:flutter/material.dart';


class DropMenu extends StatefulWidget{
  final Function(String) onPressed;
  /*
  Dropmenu({super.key, required this.onPressed });
  */
  const DropMenu({super.key, required this.onPressed});

  @override
  State<StatefulWidget> createState() => DropmenuState();

}

class DropmenuState extends State<DropMenu>{
  String PaginaSelecionada = "planos.md";
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.menu, color: Colors.white),

      onSelected: (NovaPagina){
        setState(() {
          PaginaSelecionada = NovaPagina!;
          widget.onPressed(PaginaSelecionada);
        });
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "planos.md",
          child: Text("Planos"),
        ),
        PopupMenuItem(
          value: "contato.md",
          child: Text("Contato"),
        ),
      ],
    );
    
  }
}
/*

*/