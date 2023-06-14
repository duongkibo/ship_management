class Auth {
  final String token;
  final User user;

  Auth({
    required this.token,
    required this.user,
  });

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      token: map['token'] ?? '',
      user: User.fromMap(map['data'] ?? {}),
    );
  }
}

class User {
  final String id;
  final String username;
  final String phone;
  final String email;
  final String fullName;
  final String role;
  final String avatarUrl;
  final int? tauId;

  User({
    required this.id,
    required this.username,
    required this.phone,
    required this.email,
    required this.fullName,
    required this.role,
    required this.avatarUrl,
    required this.tauId,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toString() ?? '',
      username: map['userName']?.toString() ?? '',
      phone: map['soDienThoai']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      fullName: map['hoVaTen']?.toString() ?? '',
      role: map['role']?.toString() ?? '',
      avatarUrl: map['avatarUrl']?.toString() ?? '',
      tauId: map['tauId'] as int?,
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'userName': username,
      'soDienThoai': phone,
      'email': email,
      'hoVaTen': fullName,
      'role': role,
      'avatarUrl': avatarUrl,
      'tauId': tauId,
    };
  }
}
