import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  Future<List<SidebarItem>> _loadSidebarMenu() async {
    final String response = await rootBundle.loadString(
      'assets/sidebar_list.json',
    );
    final List<dynamic> data = json.decode(response);
    return data.map((jsonItem) => SidebarItem.fromJson(jsonItem)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: 256,
          child: FutureBuilder<List<SidebarItem>>(
            future: _loadSidebarMenu(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar menu.'));
              }

              final menuItems = snapshot.data ?? [];

              return ListView(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...menuItems.map((item) => _buildMenuItem(context, item)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, SidebarItem item) {
    if (item.isCategory) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Material(
          color: const Color.fromARGB(255, 24, 24, 24),
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.grey,
            shape: const Border(),
            collapsedShape: const Border(),
            title: Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: item.children!
                .map((child) => _buildMenuItem(context, child))
                .toList(),
          ),
        ),
      );
    } else {
      final String currentPath = GoRouterState.of(
        context,
      ).uri.path.replaceFirst('/', '');
      final bool isSelected = currentPath == item.pageKey;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          color: isSelected
              ? const Color.fromARGB(255, 46, 46, 46)
              : const Color.fromARGB(255, 29, 29, 29),
          child: ListTile(
            tileColor: Colors.transparent,
            selectedTileColor: Colors.transparent,
            selected: isSelected,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                item.title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[300],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            onTap: () {
              if (item.pageKey != null) {
                context.go('/${item.pageKey}');
              }
            },
          ),
        ),
      );
    }
  }
}

class SidebarItem {
  final String title;
  final String? pageKey;
  final List<SidebarItem>? children;

  SidebarItem({required this.title, this.pageKey, this.children});

  factory SidebarItem.fromJson(Map<String, dynamic> json) {
    return SidebarItem(
      title: json['title'] as String,
      pageKey: json['pageKey'] as String?,
      children: json['children'] != null
          ? (json['children'] as List)
                .map((i) => SidebarItem.fromJson(i))
                .toList()
          : null,
    );
  }

  bool get isCategory => children != null && children!.isNotEmpty;
}
