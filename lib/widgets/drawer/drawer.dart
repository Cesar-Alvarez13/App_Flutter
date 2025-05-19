import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final List<String> items;

  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            // Header púrpura armonizado con TemplateScreen
            Container(
              width: double.infinity,
              height: 140,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6D05E8),
                    Color(0xFFC012FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),

            // Opciones excepto la última (Cerrar sesión)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: items.length - 1, // Todas menos la última
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Material(
                      color: isSelected ? const Color(0xFF9E6FFF).withOpacity(0.15) : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => onItemSelected(index),
                        splashColor: const Color(0xFF6D05E8).withOpacity(0.2),
                        highlightColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          child: Row(
                            children: [
                              Icon(
                                _getIconForIndex(index),
                                color: isSelected ? const Color(0xFF6D05E8) : Colors.black54,
                                size: 22,
                              ),
                              const SizedBox(width: 14),
                              Text(
                                items[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  color: isSelected ? const Color(0xFF6D05E8) : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Botón Cerrar sesión fijo abajo con mismo estilo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Material(
                color: selectedIndex == items.length - 1
                    ? const Color(0xFF9E6FFF).withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => onItemSelected(items.length - 1),
                  splashColor: const Color(0xFF6D05E8).withOpacity(0.2),
                  highlightColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          _getIconForIndex(items.length - 1),
                          color: selectedIndex == items.length - 1 ? const Color(0xFF6D05E8) : Colors.black54,
                          size: 22,
                        ),
                        const SizedBox(width: 14),
                        Text(
                          items.last,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: selectedIndex == items.length - 1 ? FontWeight.w600 : FontWeight.normal,
                            color: selectedIndex == items.length - 1 ? const Color(0xFF6D05E8) : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home_outlined;
      case 1:
        return Icons.person_outline;
      case 2:
        return Icons.settings_outlined;
      case 3:
        return Icons.help_outline;
      case 4:
        return Icons.info_outline;
      case 5:
        return Icons.logout;
      default:
        return Icons.circle_outlined;
    }
  }
}
