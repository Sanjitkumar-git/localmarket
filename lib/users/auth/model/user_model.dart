
class UserModel  {
  final String id;
  final String fullName;
  final String email;
  final String? photoUrl;
  final String role; 
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.photoUrl,
    this.role = 'customer',
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '').toString(),
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',  
      photoUrl: json['photo_url'],
      role: json['role'] ?? 'customer',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,  
        'photo_url': photoUrl,
        'role': role,
        'created_at': createdAt?.toIso8601String(),
      };

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? photoUrl,
    String? role,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [[id, fullName, email, photoUrl, role, createdAt]];
}