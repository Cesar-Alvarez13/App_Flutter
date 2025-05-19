import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final String email;
  final bool isBiometric;

  const ProfileView({
    super.key,
    required this.email,
    this.isBiometric = false,
  });

  static const Color deepPurple = Color(0xFF6D05E8);

  @override
  Widget build(BuildContext context) {
    final grayBackground = Colors.grey.shade100;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: grayBackground,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isBiometric ? Icons.fingerprint : Icons.account_circle_rounded,
              size: 96,
              color: deepPurple,
            ),
            const SizedBox(height: 16),
            Text(
              isBiometric ? 'Autenticación Biométrica' : 'Perfil',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: deepPurple,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 32),

            if (isBiometric)
              _biometricInputs(context)
            else
              _emailAndPasswordInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _biometricInputs(BuildContext context) {
    // Inputs vacíos para biométrico (solo decorados sin valor)
    return Column(
      children: [
        TextField(
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          obscureText: true,
        ),
      ],
    );
  }

  Widget _emailAndPasswordInfo(BuildContext context) {
    // Muestra email (y en futuro puedes agregar más info)
    return Column(
      children: [
        TextField(
          enabled: false,
          controller: TextEditingController(text: email),
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          obscureText: true,
        ),
      ],
    );
  }
}
