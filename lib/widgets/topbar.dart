import 'package:flutter/material.dart';
import '../main.dart';
import 'package:go_router/go_router.dart';

// TO-DO: estilizar
class Topbar extends StatelessWidget implements PreferredSizeWidget {
  const Topbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          // Icon e título
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                style: ButtonStyle(
                  mouseCursor: WidgetStateProperty.all(
                    SystemMouseCursors.click,
                  ),
                ),
                onPressed: () {
                  sidebarNotifier.value = !sidebarNotifier.value;
                },
                icon: Icon(Icons.menu, color: Colors.white),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'GEGB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            Spacer(),

            // Barra de pesquisa
            Expanded(
              flex: 3,
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Pesquisar...',
                    hintStyle: TextStyle(color: Colors.white60),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                ),
              ),
            ),

            Spacer(),

            // Contate-nos
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: TextButton(
                style: ButtonStyle(
                  mouseCursor: WidgetStateProperty.all(
                    SystemMouseCursors.click,
                  ),
                ),
                onPressed: () {
                  context.go('/contato');
                },
                child: Text(
                  'Contate-nos',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
