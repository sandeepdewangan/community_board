import 'package:domain/auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel extends UserEntity {
  const new({
    required super.id,
    required super.username,
    super.avatarUrl,
    required super.role,
  });

  factory UserModel.fromSupabaseUser(User user) {
    final metadata = user.userMetadata ?? {};

    return UserModel(
      id: user.id,
      username: metadata['username'] as String? ?? '',
      avatarUrl: metadata['avatar_url'] as String?,
      role: metadata['role'] as String? ?? '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @JsonKey(name: 'avatar_url')
  @override
  String? get avatarUrl;
}
