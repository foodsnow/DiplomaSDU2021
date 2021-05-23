class User {
  int id;
  String name;
  String email;
  String phone;
  Address address;

  User({this.id, this.name, this.email, this.phone, this.address});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: Address.fromJson(json['address']),
    );
  }
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'email': email, 'phone': phone};
}

class Address {
  String street;
  String zipcode;

  Address({this.street, this.zipcode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['address'],
      zipcode: json['zipcode'],
    );
  }
}
