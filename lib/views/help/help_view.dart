import 'package:flutter/material.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preguntas Frecuentes',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6D05E8),
              ),
            ),
            const SizedBox(height: 16),

            _faqItem(
              question: '¿Cómo restablezco mi contraseña?',
              answer: 'Para restablecer tu contraseña, ve a la sección Perfil y selecciona "Cambiar Contraseña". Primero deberás verificar tu contraseña actual.',
            ),
            _faqItem(
              question: '¿Cómo puedo contactar al soporte?',
              answer: 'Puedes contactar al soporte a través de la página de Contacto o enviarnos un correo a soporte@tuapp.com.',
            ),
            _faqItem(
              question: '¿Mis datos están seguros?',
              answer: 'Sí, tus datos están encriptados y almacenados de forma segura. Seguimos las mejores prácticas para garantizar tu privacidad.',
            ),
            _faqItem(
              question: '¿Puedo personalizar los ajustes de la app?',
              answer: 'Sí, ve a la sección de Ajustes para personalizar tus preferencias.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqItem({required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFFC012FF),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
