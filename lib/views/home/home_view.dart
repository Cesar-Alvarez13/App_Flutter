import 'package:flutter/material.dart';
import '../../models/person.dart';
import '../../services/api_service.dart';
import '../../widgets/card/card.dart';
import '../../views/detail/detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Person> persons = [];
  bool isLoading = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    _loadPersons();
  }

  Future<void> _loadPersons() async {
    setState(() {
      persons.clear();
      isLoading = true;
      errorMsg = '';
    });

    try {
      // Método que devuelve un Stream<Person> con registros válidos a medida que se obtienen
      await for (final person in PersonService.fetchPersonsStream()) {
        setState(() {
          persons.add(person);
        });
      }
    } catch (e) {
      setState(() {
        errorMsg = 'Error al cargar personas: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(16),
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (errorMsg.isNotEmpty) {
      return Center(
        child: Text(errorMsg, style: const TextStyle(color: Colors.redAccent)),
      );
    }

    if (persons.isEmpty && isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6D05E8)),
      );
    }

    if (persons.isEmpty) {
      return const Center(
        child: Text('No hay personas registradas',
            style: TextStyle(fontSize: 16, color: Colors.grey)),
      );
    }

    return ListView.builder(
      itemCount: persons.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == persons.length) {
          // Mostrar spinner en la lista mientras sigue cargando
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(color: Color(0xFF6D05E8)),
            ),
          );
        }

        final p = persons[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: PersonCard(
            person: p,
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.05),
                builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.all(16),
                  child: DetailModal(person: p),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
