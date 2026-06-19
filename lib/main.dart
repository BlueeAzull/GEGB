import 'package:flutter/material.dart';
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

class MyAppState extends State<MyApp> {
  final String _assetFolderPath = "lib/pages/";
  String _assetName = "planos.md";
  String _assetPath = "lib/pages/planos.md";
  void mudar_assetPath(String AssetNameNovo){
    if (AssetNameNovo.endsWith(".md")){
      _assetName = AssetNameNovo;
      setState(() {
        _assetPath = _assetFolderPath + _assetName;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF212121),
        appBar: Topbar(onPressed: mudar_assetPath),
        body: Center(
          child: Content(
            title: "planos (n deletar pfv)",
            assetPath: _assetPath
          )
        ),
      ),
    );
  }
}
