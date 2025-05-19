import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final deepPurple = const Color(0xFF6D05E8);

  bool _receiveNotifications = true;
  bool _notificationSound = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ajustes',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: deepPurple,
            ),
          ),
          const SizedBox(height: 32),

          // Sección General
          Text(
            'General',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: deepPurple.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 12),

          _buildSettingTile(
            icon: Icons.language,
            title: 'Idioma',
            subtitle: 'Español',
            onTap: () {},
          ),

          _buildSettingTile(
            icon: Icons.palette,
            title: 'Tema',
            subtitle: 'Modo oscuro',
            onTap: () {},
          ),

          const Divider(height: 40),

          // Sección Notificaciones
          Text(
            'Notificaciones',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: deepPurple.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 12),

          SwitchListTile(
            value: _receiveNotifications,
            onChanged: (val) {
              setState(() {
                _receiveNotifications = val;
              });
            },
            activeColor: deepPurple,
            title: const Text('Recibir notificaciones'),
          ),

          SwitchListTile(
            value: _notificationSound,
            onChanged: (val) {
              setState(() {
                _notificationSound = val;
              });
            },
            activeColor: deepPurple,
            title: const Text('Sonido de notificaciones'),
          ),

          const Divider(height: 40),

          // Sección Privacidad
          Text(
            'Privacidad',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: deepPurple.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 12),

          _buildSettingTile(
            icon: Icons.lock,
            title: 'Cambiar contraseña',
            onTap: () {},
          ),

          _buildSettingTile(
            icon: Icons.delete_forever,
            title: 'Eliminar cuenta',
            titleColor: Colors.red.shade700,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: titleColor ?? const Color(0xFF6D05E8)),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: titleColor ?? Colors.black87,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      hoverColor: Colors.purple.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
