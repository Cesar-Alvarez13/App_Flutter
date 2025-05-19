import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../models/person.dart';

class DetailModal extends StatelessWidget {
  final Person person;

  const DetailModal({required this.person, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.deepPurple),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(person.imageUrl),
              ),
              const SizedBox(height: 16),
              const Text(
                'Detalles',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 24),
              _buildField('Nombre', '${person.firstName} ${person.lastName}'),
              _buildField('Correo', person.email),
              _buildField('Calle', person.street),
              _buildField('Rating', person.rating.toStringAsFixed(2)),
              _buildField('Teléfono', person.phone),
              _buildField('Ciudad', person.city),
              _buildField('Estado', person.state),
              _buildField('Código Postal', person.postcode),
              const SizedBox(height: 16),
              const Text(
                'Ubicación',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(person.latitude, person.longitude),
                        zoom: 13,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point:
                                  LatLng(person.latitude, person.longitude),
                              width: 40,
                              height: 40,
                              builder: (ctx) => const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
