class VendorModel {
  final int active;
  final int availability;
  final String category;
  final String city;
  final String coverImageUrl;
  final String description;
  final String email;
  final int kycApproved;
  final String name;
  final String phone;
  final String profileImageUrl;
  final int rank;
  final String state;
  final String typeVendor;
  final String userType;
  final String id;

  VendorModel({
    required this.active,
    required this.availability,
    required this.category,
    required this.city,
    required this.coverImageUrl,
    required this.description,
    required this.email,
    required this.kycApproved,
    required this.name,
    required this.phone,
    required this.profileImageUrl,
    required this.rank,
    required this.state,
    required this.typeVendor,
    required this.userType,
    required this.id,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      active: json['active'],
      availability: json['availability'],
      category: json['category'],
      city: json['city'],
      coverImageUrl: json['coverImageUrl'],
      description: json['description'],
      email: json['email'],
      kycApproved: json['kycApproved'],
      name: json['name'],
      phone: json['phone'],
      profileImageUrl: json['profileImageUrl'],
      rank: json['rank'],
      state: json['state'],
      typeVendor: json['typeVendor'],
      userType : json['userType'],
      id: json['_id'],
    );
  }
}
