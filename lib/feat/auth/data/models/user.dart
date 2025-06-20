class UserDm {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final int avaterId;

  const UserDm({
    required this.id,
    required this.password,
    required this.name,
    required this.email,
    required this.phone,
    required this.avaterId,
  });

  UserDm copyWith({
    String? id,
    String? password,
    String? name,
    String? email,
    String? phone,
    int? avaterId,
  }) {
    return UserDm(
      id: id ?? this.id,
      password: password ?? this.password,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avaterId: avaterId ?? this.avaterId,
    );
  }

  Map<dynamic, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'confirmPassword': password,
    'phone': phone,
    'avaterId': avaterId,
  };

  factory UserDm.fromJson(Map<String, dynamic> json) {
    return UserDm(
      id: json['_id'],
      password: json['email'],
      name: json['password'],
      email: json['name'],
      phone: json['phone'],
      avaterId: json['avaterId'],
    );
  }
}
