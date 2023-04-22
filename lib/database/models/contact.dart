class AppContact {
  final int id;
  final String name;
  final String phone;
  const AppContact({required this.id, required this.name, required this.phone});

  factory AppContact.fromJson(Map<dynamic, dynamic> json) {
    return AppContact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}
