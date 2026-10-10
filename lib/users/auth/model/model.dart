import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  final String id;        // Firebase Auth UID / Document ID
  final String name;
  final String email;
  final String? profileImageUrl;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
  });

  // 1. Firebase (Map/JSON) bata Model ma convert garne (Read garda)
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '', // Repo ma data['id'] = doc.id garera inject gareko thiyum
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImageUrl: json['profileImageUrl'],
    );
  }

  // 2. Model bata Firebase (Map/JSON) ma convert garne (Create/Update garda)
  Map<String, dynamic> toJson() {
    return {
      // ⚠️ Note: 'id' lai yeta map vitra rakhidaina, 
      // kina ki id ta Firestore ko Document ID banera bascha!
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
}
class UserProfileRepo{

final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("users");

Future<void> createUserProfile(UserProfile users) async {
  await _collectionReference.doc(users.id).set(users.toJson());
}

Future<UserProfile> fetchUserProfile(String userId) async {
  final doc = await _collectionReference.doc(userId).get();
  if (!doc.exists) {
    throw Exception("User Not found");
  }
  final data = doc.data() as Map<String, dynamic>;
  data['id'] = doc.id;
  return UserProfile.fromJson(data);
}

Future<List<UserProfile>> fetchUserProfiles() async {
  final snapshot = await _collectionReference.get();
  return snapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return UserProfile.fromJson(data);
  }).toList();
}

Future<void> updateUserProfile(String userId, UserProfile users)async{
  await _collectionReference.doc(userId).update(users.toJson());
}
Future<void> deleteUserProfile(String userId)async{
  await _collectionReference.doc(userId).delete();
}}