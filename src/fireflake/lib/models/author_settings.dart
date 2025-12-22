import 'package:equatable/equatable.dart';

class AuthorSettings extends Equatable {
  final String name;
  final String bio;
  final String email;

  const AuthorSettings({
    this.name = '',
    this.bio = '',
    this.email = '',
  });

  AuthorSettings copyWith({
    String? name,
    String? bio,
    String? email,
  }) {
    return AuthorSettings(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'email': email,
    };
  }

  factory AuthorSettings.fromJson(Map<String, dynamic> json) {
    return AuthorSettings(
      name: json['name'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [name, bio, email];
}
