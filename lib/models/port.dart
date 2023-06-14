import 'package:equatable/equatable.dart';

class Port extends Equatable {
  final String id;
  final String name;
  final String address;

  Port({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Port.fromMap(Map<String, dynamic> map) {
    return Port(
      id: map['id'].toString(),
      name: map['tenCang'] ?? '',
      address: map['diaChi'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, address];
}
