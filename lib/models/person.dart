class Person {
  final String id; // uuid
  final String firstName;
  final String lastName;
  final String email;
  final String street;
  final String imageUrl;
  final double rating;
  final String city;
  final String state;
  final String postcode;
  final String phone;
  final double latitude;
  final double longitude;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.street,
    required this.imageUrl,
    required this.rating,
    required this.city,
    required this.state,
    required this.postcode,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      street: map['street'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] != null) ? (map['rating'] as num).toDouble() : 0.0,
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      postcode: map['postcode'] ?? '',
      phone: map['phone'] ?? '',
      latitude: (map['latitude'] != null) ? (map['latitude'] as num).toDouble() : 0.0,
      longitude: (map['longitude'] != null) ? (map['longitude'] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'street': street,
      'imageUrl': imageUrl,
      'rating': rating,
      'city': city,
      'state': state,
      'postcode': postcode,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
