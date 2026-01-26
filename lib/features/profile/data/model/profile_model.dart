import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.bikeModel,
    required super.bikeRegistrationNumber,
    required super.isApproved,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      bikeModel: json['bikeModel'] ?? '',
      bikeRegistrationNumber: json['bikeRegistrationNumber'] ?? '',
      isApproved: json['isApproved'] ?? false,
    );
  }
}
