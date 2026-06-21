import 'package:flutter/material.dart';
import 'dropmenu.dart';

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
            DropMenu(),

            /*IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu, color: Colors.white),
            )*/
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
            TextButton(
              onPressed: () {},
              child: Text(
                'Contate-nos',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
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
