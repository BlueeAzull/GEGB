import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget /* implements PreferredSizeWidget */ {
  /* final Function(String title, String pageKey) onPageSelected;

  const Sidebar({Key? key, required this.onPageSelected}) : super(key: key); */

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
      width: 280,
      color: const Color(0xFF1A1A1A),
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
            children: [
              // const DrawerHeader(
              //   decoration: BoxDecoration(color: Colors.black26),
              //   child: Text('AAAAAAAAAAAAA'),
              // ),
              ...menuItems.map((item) => _buildMenuItem(context, item)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, SidebarItem item) {
    if (item.isCategory) {
      return ExpansionTile(
        iconColor: Colors.white,
        collapsedIconColor: Colors.grey,
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
      );
    } else {
      return ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(item.title, style: TextStyle(color: Colors.grey[300])),
        ),
        onTap: () {
          if (item.pageKey != null) {
            context.go('/${item.pageKey}');
          }
        },
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
