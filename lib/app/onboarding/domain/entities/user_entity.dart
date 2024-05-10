import 'package:fusion_app_store/constants/user_type.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';

class UserEntity {
  final String username;
  final String userLoginEmail;
  final String password;
  final String avatarUrl;
  final String bio;
  final String address;
  final String website;
  final String privacyPolicy;
  final String termsAndConditions;
  final UserType userType;
  final Set<String> likedApps;
  final Set<String> ownedApps;
  final Set<String> reviewedApps;
  final bool active;
  final int reputation;
  final int strikes;
  final DateTime joinedAt;

  UserEntity({
    required this.username,
    required this.userLoginEmail,
    required this.password,
    required this.avatarUrl,
    required this.bio,
    required this.address,
    required this.website,
    required this.privacyPolicy,
    required this.termsAndConditions,
    required this.userType,
    required this.likedApps,
    required this.ownedApps,
    required this.reviewedApps,
    required this.active,
    required this.reputation,
    required this.strikes,
    required this.joinedAt,
  });

  UserEntity.clone(
    UserEntity entity, {
    String? username,
    String? userLoginEmail,
    String? password,
    String? avatarUrl,
    String? bio,
    String? address,
    String? website,
    String? privacyPolicy,
    String? termsAndConditions,
    UserType? userType,
    Set<String>? likedApps,
    Set<String>? ownedApps,
    Set<String>? reviewedApps,
    bool? active,
    int? reputation,
    int? strikes,
    DateTime? joinedAt,
  })  : username = username ?? entity.username,
        userLoginEmail = userLoginEmail ?? entity.userLoginEmail,
        password = password ?? entity.password,
        avatarUrl = avatarUrl ?? entity.avatarUrl,
        bio = bio ?? entity.bio,
        address = address ?? entity.address,
        website = website ?? entity.website,
        privacyPolicy = privacyPolicy ?? entity.privacyPolicy,
        termsAndConditions = termsAndConditions ?? entity.termsAndConditions,
        userType = userType ?? entity.userType,
        likedApps = likedApps ?? Set.from(entity.likedApps),
        ownedApps = ownedApps ?? Set.from(entity.ownedApps),
        reviewedApps = reviewedApps ?? Set.from(entity.reviewedApps),
        active = active ?? entity.active,
        reputation = reputation ?? entity.reputation,
        strikes = strikes ?? entity.strikes,
        joinedAt = joinedAt ?? entity.joinedAt;

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.username: username,
      StorageKeys.userLoginEmail: userLoginEmail,
      StorageKeys.password: password,
      StorageKeys.avatarUrl: avatarUrl,
      StorageKeys.bio: bio,
      StorageKeys.address: address,
      StorageKeys.website: website,
      StorageKeys.privacyPolicy: privacyPolicy,
      StorageKeys.termsAndConditions: termsAndConditions,
      StorageKeys.userType: userType.name,
      StorageKeys.likedApps: likedApps,
      StorageKeys.ownedApps: ownedApps,
      StorageKeys.reviewedApps: reviewedApps,
      StorageKeys.active: active,
      StorageKeys.reputation: reputation,
      StorageKeys.strikes: strikes,
      StorageKeys.joinedAt: joinedAt.toString(),
    };
  }

  static UserEntity fromMap({required Map<String, dynamic> map}) {
    return UserEntity(
      username: map[StorageKeys.username],
      userLoginEmail: map[StorageKeys.userLoginEmail],
      password: map[StorageKeys.password],
      avatarUrl: map[StorageKeys.avatarUrl],
      bio: map[StorageKeys.bio],
      address: map[StorageKeys.address],
      website: map[StorageKeys.website],
      privacyPolicy: map[StorageKeys.privacyPolicy],
      termsAndConditions: map[StorageKeys.termsAndConditions],
      userType: UserType.values
          .where((e) => e.name == map[StorageKeys.userType])
          .first,
      likedApps: Set.from(map[StorageKeys.likedApps]),
      ownedApps: Set.from(map[StorageKeys.ownedApps]),
      reviewedApps: Set.from(map[StorageKeys.reviewedApps]),
      active: map[StorageKeys.active],
      reputation: map[StorageKeys.reputation],
      strikes: map[StorageKeys.strikes],
      joinedAt: DateTime.parse(map[StorageKeys.joinedAt]),
    );
  }

  static UserEntity get empty => UserEntity(
        username: "",
        userLoginEmail: "",
        password: "",
        avatarUrl: "",
        bio: "",
        address: "",
        website: "",
        privacyPolicy: "",
        termsAndConditions: "",
        userType: UserType.other,
        likedApps: {},
        ownedApps: {},
        reviewedApps: {},
        active: true,
        reputation: 0,
        strikes: 0,
        joinedAt: DateTime.now(),
      );
}
