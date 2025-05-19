import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../views/home/home_view.dart';
import '../../views/profile/perfil_view.dart';
import '../../views/settings/settings_view.dart';
import '../../views/help/help_view.dart';
import '../../views/about/about_view.dart';
import '../../views/login/login_view.dart';
import '../drawer/drawer.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  String email = '';
  bool isBiometric = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      email = args['email'] ?? '';
      isBiometric = args['isBiometric'] ?? false;
    }
  }

  final List<String> _titles = [
    'Home',
    'Profile',
    'Settings',
    'Help',
    'About',
    'Logout',
  ];

  final List<String> _subtitles = [
    'Bienvenido a la página principal',
    'Tu perfil personal y ajustes',
    'Preferencias y configuración de la app',
    'Obtén ayuda y soporte',
    'Acerca de esta aplicación',
    '',
  ];
  List<Widget> get _pages {
    return [
      const HomeView(key: PageStorageKey('HomeView')),
      ProfileView(
        key: const PageStorageKey('ProfileView'),
        email: email,
        isBiometric: isBiometric,
      ),
      const SettingsView(key: PageStorageKey('SettingsView')),
      const HelpView(key: PageStorageKey('HelpView')),
      const AboutView(key: PageStorageKey('AboutView')),
      const SizedBox.shrink(), // Logout no tiene vista
    ];
  }

  void _onItemSelected(int index) {
    if (index == _titles.length - 1) {
      _logout();
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pop(context); // cerrar drawer
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
        items: _titles,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header estilizado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    tooltip: 'Menu',
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _titles[_selectedIndex],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _subtitles[_selectedIndex],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Vista actual
            Expanded(
              child: _pages[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
