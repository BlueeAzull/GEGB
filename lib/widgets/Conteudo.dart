import 'package:flutter/material.dart';
import 'package:gegb/widgets/pages.dart';


class Conteudo extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() => ConteudoState();
}
class ConteudoState extends State<Conteudo>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Content(
      title: "planos (n deletar pfv)",
      assetPath: "lib/pages/planos.md"
      );
  }
}