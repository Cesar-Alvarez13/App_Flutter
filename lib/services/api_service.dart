import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/person.dart';
import '../db/database_helper.dart';

class PersonService {
  static final _dbHelper = DatabaseHelper();

  static Stream<Person> fetchPersonsStream() async* {
    await _dbHelper.deleteAllPersons();

    List<String> ids = [];

    while (ids.length < 5) {
      final url = Uri.parse('https://randomuser.me/api/?results=5');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        // Si falla, simplemente termina el stream (o podrías lanzar error)
        break;
      }

      final data = json.decode(response.body);

      for (var result in data['results']) {
        if (ids.length >= 5) break;

        if (result['login']?['uuid'] == null ||
            result['name']?['first'] == null ||
            result['name']?['last'] == null ||
            result['email'] == null ||
            result['location']?['street']?['number'] == null ||
            result['location']?['street']?['name'] == null ||
            result['location']?['city'] == null ||
            result['location']?['state'] == null ||
            result['location']?['postcode'] == null ||
            result['phone'] == null ||
            result['picture']?['large'] == null ||
            result['location']?['coordinates']?['latitude'] == null ||
            result['location']?['coordinates']?['longitude'] == null) {
          continue;
        }

        final latitude = double.tryParse(result['location']['coordinates']['latitude']) ?? 0.0;
        final longitude = double.tryParse(result['location']['coordinates']['longitude']) ?? 0.0;
        if (latitude == 0.0 && longitude == 0.0) continue;

        final person = Person(
          id: result['login']['uuid'],
          firstName: result['name']['first'],
          lastName: result['name']['last'],
          email: result['email'],
          street:
              '${result['location']['street']['number']} ${result['location']['street']['name']}',
          city: result['location']['city'],
          state: result['location']['state'],
          postcode: result['location']['postcode'].toString(),
          phone: result['phone'],
          imageUrl: result['picture']['large'],
          rating: 4.5, // O random si quieres
          latitude: latitude,
          longitude: longitude,
        );

        if (!ids.contains(person.id)) {
          await _dbHelper.insertPerson(person);
          ids.add(person.id);
          yield person;  // Emitir el registro válido para que la UI lo reciba
        }
      }
    }
  }
}
