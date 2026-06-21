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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'GEGB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontFamily: 'Archivo Black',
              ),
            ),

            Row(
              // Menu
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
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
