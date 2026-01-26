class ProfileEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String bikeModel;
  final String bikeRegistrationNumber;
  final bool isApproved;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.bikeModel,
    required this.bikeRegistrationNumber,
    required this.isApproved,
  });
}
