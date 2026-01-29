import 'package:todoapp/domain/entities/user.dart' show User;

class UserModel {
  final String id;
  final String name;
  final String avatar;
  final String email;

  const UserModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'avatar': avatar, 'email': email};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      email: json['email'] as String,
    );
  }
  User toEntity() {
    return User(id: id, name: name, email: email, avatar: avatar);
  }
}
