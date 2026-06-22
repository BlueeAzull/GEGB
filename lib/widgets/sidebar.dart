import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:go_router/go_router.dart';
import '../main.dart';

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
    final sidebarCores = Theme.of(context).extension<Temas>()!;

    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: sidebarCores.fundoSidebar,
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

              final paginasPesquisaveis = _mapearPaginasParaPesquisa(menuItems);

              return ListView(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SearchAnchor.bar(
                      barHintText: 'Pesquisar...',
                      barBackgroundColor: WidgetStateProperty.all(
                        sidebarCores.categoriaSidebar,
                      ),
                      barElevation: WidgetStateProperty.all(0),
                      barShape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                            final input = controller.text.toLowerCase();

                            final filtradas = paginasPesquisaveis.where((pag) {
                              return pag.title.toLowerCase().contains(input) ||
                                  pag.caminhoCompleto.toLowerCase().contains(
                                    input,
                                  );
                            }).toList();

                            return filtradas.map((pag) {
                              return ListTile(
                                title: Text(
                                  pag.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  pag.caminhoCompleto,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: sidebarCores.texto,
                                ),
                                onTap: () {
                                  controller.closeView(pag.title);
                                  context.go('/${pag.pageKey}');
                                },
                              );
                            }).toList();
                          },
                    ),
                  ),

                  // O resto do seu menu original continua aqui embaixo:
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
    final sidebarCores = Theme.of(context).extension<Temas>()!;

    if (item.isCategory) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Material(
          color: sidebarCores.categoriaSidebar,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            iconColor: sidebarCores.texto,
            collapsedIconColor: sidebarCores.textoUnselected,
            shape: const Border(),
            collapsedShape: const Border(),
            title: Text(
              item.title,
              style: TextStyle(
                color: sidebarCores.texto,
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
              ? sidebarCores.itemSelecionadoSidebar
              : sidebarCores.itemPadraoSidebar,
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
                  color: isSelected
                      ? sidebarCores.texto
                      : sidebarCores.textoUnselected,
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

  List<PaginaPesquisavel> _mapearPaginasParaPesquisa(
    List<SidebarItem> items, {
    String caminhoPai = "",
  }) {
    List<PaginaPesquisavel> resultado = [];

    for (var item in items) {
      if (item.isCategory) {
        String novoCaminho = caminhoPai.isEmpty
            ? item.title
            : "$caminhoPai > ${item.title}";
        resultado.addAll(
          _mapearPaginasParaPesquisa(item.children!, caminhoPai: novoCaminho),
        );
      } else if (item.pageKey != null) {
        resultado.add(
          PaginaPesquisavel(
            title: item.title,
            pageKey: item.pageKey!,
            caminhoCompleto: caminhoPai.isEmpty ? "Geral" : caminhoPai,
          ),
        );
      }
    }
    return resultado;
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

class PaginaPesquisavel {
  final String title;
  final String pageKey;
  final String caminhoCompleto;

  PaginaPesquisavel({
    required this.title,
    required this.pageKey,
    required this.caminhoCompleto,
  });
}
