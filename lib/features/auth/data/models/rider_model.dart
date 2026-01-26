import '../../domain/entities/rider_entity.dart';

class RiderModel extends RiderEntity {
  RiderModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.isApproved,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      isApproved: json['isApproved'] ?? false,
    );
  }
}
