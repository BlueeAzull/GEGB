import 'package:flutter/material.dart';
import 'widgets/topbar.dart';
import 'widgets/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF212121),
        appBar: Topbar(),
        body: Center(
          child: Content(
            title: "parmeira diferente",
            text: "vai parmera contra corinthians",
          ),
        ),
      ),
    );
  }
}
