import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Coordenadas aproximadas de la dirección proporcionada
    final LatLng location = LatLng(20.652502, -103.422799);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Acerca de esta aplicación',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6D05E8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Esta aplicación fue desarrollada para ofrecer una experiencia fluida y '
              'moderna, con una interfaz limpia y funcional, adaptada a dispositivos móviles y escritorio.',
              style: textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Versión',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFFC012FF),
              ),
            ),
            Text(
              '1.0.0',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Desarrollador',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6D05E8),
              ),
            ),
            Text(
              'Cesar Alvarez',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Divider(
              color: Colors.purple.shade200,
              thickness: 1,
            ),
            const SizedBox(height: 20),
            Text(
              'Contacto',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFFC012FF),
              ),
            ),
            Text(
              'Email: cesaram34313@gmail.com\n'
              'Website: https://github.com/Cesar-Alvarez13',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    'Ubicación: Condominio Puerta Aqua, Av. Universidad 1151, El Secreto, 45066 Zapopan, Jal.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 250,
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FlutterMap(
                        options: MapOptions(
                          center: location,
                          zoom: 15,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: const ['a', 'b', 'c'],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: location,
                                width: 40,
                                height: 40,
                                builder: (ctx) => const Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
