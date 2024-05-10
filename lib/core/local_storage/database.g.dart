// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _userLoginEmailMeta =
      const VerificationMeta('userLoginEmail');
  @override
  late final GeneratedColumn<String> userLoginEmail = GeneratedColumn<String>(
      'user_login_email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
      'bio', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _websiteMeta =
      const VerificationMeta('website');
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
      'website', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _privacyPolicyMeta =
      const VerificationMeta('privacyPolicy');
  @override
  late final GeneratedColumn<String> privacyPolicy = GeneratedColumn<String>(
      'privacy_policy', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _termsAndConditionsMeta =
      const VerificationMeta('termsAndConditions');
  @override
  late final GeneratedColumn<String> termsAndConditions =
      GeneratedColumn<String>('terms_and_conditions', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userTypeMeta =
      const VerificationMeta('userType');
  @override
  late final GeneratedColumn<String> userType = GeneratedColumn<String>(
      'user_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _likedAppsMeta =
      const VerificationMeta('likedApps');
  @override
  late final GeneratedColumn<String> likedApps = GeneratedColumn<String>(
      'liked_apps', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownedAppsMeta =
      const VerificationMeta('ownedApps');
  @override
  late final GeneratedColumn<String> ownedApps = GeneratedColumn<String>(
      'owned_apps', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewedAppsMeta =
      const VerificationMeta('reviewedApps');
  @override
  late final GeneratedColumn<String> reviewedApps = GeneratedColumn<String>(
      'reviewed_apps', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'));
  static const VerificationMeta _reputationMeta =
      const VerificationMeta('reputation');
  @override
  late final GeneratedColumn<int> reputation = GeneratedColumn<int>(
      'reputation', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _strikesMeta =
      const VerificationMeta('strikes');
  @override
  late final GeneratedColumn<int> strikes = GeneratedColumn<int>(
      'strikes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _joinedAtMeta =
      const VerificationMeta('joinedAt');
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
      'joined_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        username,
        userLoginEmail,
        password,
        avatarUrl,
        bio,
        address,
        website,
        privacyPolicy,
        termsAndConditions,
        userType,
        likedApps,
        ownedApps,
        reviewedApps,
        active,
        reputation,
        strikes,
        joinedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('user_login_email')) {
      context.handle(
          _userLoginEmailMeta,
          userLoginEmail.isAcceptableOrUnknown(
              data['user_login_email']!, _userLoginEmailMeta));
    } else if (isInserting) {
      context.missing(_userLoginEmailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    } else if (isInserting) {
      context.missing(_avatarUrlMeta);
    }
    if (data.containsKey('bio')) {
      context.handle(
          _bioMeta, bio.isAcceptableOrUnknown(data['bio']!, _bioMeta));
    } else if (isInserting) {
      context.missing(_bioMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('website')) {
      context.handle(_websiteMeta,
          website.isAcceptableOrUnknown(data['website']!, _websiteMeta));
    } else if (isInserting) {
      context.missing(_websiteMeta);
    }
    if (data.containsKey('privacy_policy')) {
      context.handle(
          _privacyPolicyMeta,
          privacyPolicy.isAcceptableOrUnknown(
              data['privacy_policy']!, _privacyPolicyMeta));
    } else if (isInserting) {
      context.missing(_privacyPolicyMeta);
    }
    if (data.containsKey('terms_and_conditions')) {
      context.handle(
          _termsAndConditionsMeta,
          termsAndConditions.isAcceptableOrUnknown(
              data['terms_and_conditions']!, _termsAndConditionsMeta));
    } else if (isInserting) {
      context.missing(_termsAndConditionsMeta);
    }
    if (data.containsKey('user_type')) {
      context.handle(_userTypeMeta,
          userType.isAcceptableOrUnknown(data['user_type']!, _userTypeMeta));
    } else if (isInserting) {
      context.missing(_userTypeMeta);
    }
    if (data.containsKey('liked_apps')) {
      context.handle(_likedAppsMeta,
          likedApps.isAcceptableOrUnknown(data['liked_apps']!, _likedAppsMeta));
    } else if (isInserting) {
      context.missing(_likedAppsMeta);
    }
    if (data.containsKey('owned_apps')) {
      context.handle(_ownedAppsMeta,
          ownedApps.isAcceptableOrUnknown(data['owned_apps']!, _ownedAppsMeta));
    } else if (isInserting) {
      context.missing(_ownedAppsMeta);
    }
    if (data.containsKey('reviewed_apps')) {
      context.handle(
          _reviewedAppsMeta,
          reviewedApps.isAcceptableOrUnknown(
              data['reviewed_apps']!, _reviewedAppsMeta));
    } else if (isInserting) {
      context.missing(_reviewedAppsMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    if (data.containsKey('reputation')) {
      context.handle(
          _reputationMeta,
          reputation.isAcceptableOrUnknown(
              data['reputation']!, _reputationMeta));
    } else if (isInserting) {
      context.missing(_reputationMeta);
    }
    if (data.containsKey('strikes')) {
      context.handle(_strikesMeta,
          strikes.isAcceptableOrUnknown(data['strikes']!, _strikesMeta));
    } else if (isInserting) {
      context.missing(_strikesMeta);
    }
    if (data.containsKey('joined_at')) {
      context.handle(_joinedAtMeta,
          joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta));
    } else if (isInserting) {
      context.missing(_joinedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableData(
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      userLoginEmail: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}user_login_email'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url'])!,
      bio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bio'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      website: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}website'])!,
      privacyPolicy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}privacy_policy'])!,
      termsAndConditions: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}terms_and_conditions'])!,
      userType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_type'])!,
      likedApps: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}liked_apps'])!,
      ownedApps: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owned_apps'])!,
      reviewedApps: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reviewed_apps'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      reputation: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reputation'])!,
      strikes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}strikes'])!,
      joinedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}joined_at'])!,
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  final String username;
  final String userLoginEmail;
  final String password;
  final String avatarUrl;
  final String bio;
  final String address;
  final String website;
  final String privacyPolicy;
  final String termsAndConditions;
  final String userType;
  final String likedApps;
  final String ownedApps;
  final String reviewedApps;
  final bool active;
  final int reputation;
  final int strikes;
  final DateTime joinedAt;
  const UserTableData(
      {required this.username,
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
      required this.joinedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['username'] = Variable<String>(username);
    map['user_login_email'] = Variable<String>(userLoginEmail);
    map['password'] = Variable<String>(password);
    map['avatar_url'] = Variable<String>(avatarUrl);
    map['bio'] = Variable<String>(bio);
    map['address'] = Variable<String>(address);
    map['website'] = Variable<String>(website);
    map['privacy_policy'] = Variable<String>(privacyPolicy);
    map['terms_and_conditions'] = Variable<String>(termsAndConditions);
    map['user_type'] = Variable<String>(userType);
    map['liked_apps'] = Variable<String>(likedApps);
    map['owned_apps'] = Variable<String>(ownedApps);
    map['reviewed_apps'] = Variable<String>(reviewedApps);
    map['active'] = Variable<bool>(active);
    map['reputation'] = Variable<int>(reputation);
    map['strikes'] = Variable<int>(strikes);
    map['joined_at'] = Variable<DateTime>(joinedAt);
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      username: Value(username),
      userLoginEmail: Value(userLoginEmail),
      password: Value(password),
      avatarUrl: Value(avatarUrl),
      bio: Value(bio),
      address: Value(address),
      website: Value(website),
      privacyPolicy: Value(privacyPolicy),
      termsAndConditions: Value(termsAndConditions),
      userType: Value(userType),
      likedApps: Value(likedApps),
      ownedApps: Value(ownedApps),
      reviewedApps: Value(reviewedApps),
      active: Value(active),
      reputation: Value(reputation),
      strikes: Value(strikes),
      joinedAt: Value(joinedAt),
    );
  }

  factory UserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      username: serializer.fromJson<String>(json['username']),
      userLoginEmail: serializer.fromJson<String>(json['userLoginEmail']),
      password: serializer.fromJson<String>(json['password']),
      avatarUrl: serializer.fromJson<String>(json['avatarUrl']),
      bio: serializer.fromJson<String>(json['bio']),
      address: serializer.fromJson<String>(json['address']),
      website: serializer.fromJson<String>(json['website']),
      privacyPolicy: serializer.fromJson<String>(json['privacyPolicy']),
      termsAndConditions:
          serializer.fromJson<String>(json['termsAndConditions']),
      userType: serializer.fromJson<String>(json['userType']),
      likedApps: serializer.fromJson<String>(json['likedApps']),
      ownedApps: serializer.fromJson<String>(json['ownedApps']),
      reviewedApps: serializer.fromJson<String>(json['reviewedApps']),
      active: serializer.fromJson<bool>(json['active']),
      reputation: serializer.fromJson<int>(json['reputation']),
      strikes: serializer.fromJson<int>(json['strikes']),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'username': serializer.toJson<String>(username),
      'userLoginEmail': serializer.toJson<String>(userLoginEmail),
      'password': serializer.toJson<String>(password),
      'avatarUrl': serializer.toJson<String>(avatarUrl),
      'bio': serializer.toJson<String>(bio),
      'address': serializer.toJson<String>(address),
      'website': serializer.toJson<String>(website),
      'privacyPolicy': serializer.toJson<String>(privacyPolicy),
      'termsAndConditions': serializer.toJson<String>(termsAndConditions),
      'userType': serializer.toJson<String>(userType),
      'likedApps': serializer.toJson<String>(likedApps),
      'ownedApps': serializer.toJson<String>(ownedApps),
      'reviewedApps': serializer.toJson<String>(reviewedApps),
      'active': serializer.toJson<bool>(active),
      'reputation': serializer.toJson<int>(reputation),
      'strikes': serializer.toJson<int>(strikes),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
    };
  }

  UserTableData copyWith(
          {String? username,
          String? userLoginEmail,
          String? password,
          String? avatarUrl,
          String? bio,
          String? address,
          String? website,
          String? privacyPolicy,
          String? termsAndConditions,
          String? userType,
          String? likedApps,
          String? ownedApps,
          String? reviewedApps,
          bool? active,
          int? reputation,
          int? strikes,
          DateTime? joinedAt}) =>
      UserTableData(
        username: username ?? this.username,
        userLoginEmail: userLoginEmail ?? this.userLoginEmail,
        password: password ?? this.password,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        bio: bio ?? this.bio,
        address: address ?? this.address,
        website: website ?? this.website,
        privacyPolicy: privacyPolicy ?? this.privacyPolicy,
        termsAndConditions: termsAndConditions ?? this.termsAndConditions,
        userType: userType ?? this.userType,
        likedApps: likedApps ?? this.likedApps,
        ownedApps: ownedApps ?? this.ownedApps,
        reviewedApps: reviewedApps ?? this.reviewedApps,
        active: active ?? this.active,
        reputation: reputation ?? this.reputation,
        strikes: strikes ?? this.strikes,
        joinedAt: joinedAt ?? this.joinedAt,
      );
  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('username: $username, ')
          ..write('userLoginEmail: $userLoginEmail, ')
          ..write('password: $password, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('bio: $bio, ')
          ..write('address: $address, ')
          ..write('website: $website, ')
          ..write('privacyPolicy: $privacyPolicy, ')
          ..write('termsAndConditions: $termsAndConditions, ')
          ..write('userType: $userType, ')
          ..write('likedApps: $likedApps, ')
          ..write('ownedApps: $ownedApps, ')
          ..write('reviewedApps: $reviewedApps, ')
          ..write('active: $active, ')
          ..write('reputation: $reputation, ')
          ..write('strikes: $strikes, ')
          ..write('joinedAt: $joinedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      username,
      userLoginEmail,
      password,
      avatarUrl,
      bio,
      address,
      website,
      privacyPolicy,
      termsAndConditions,
      userType,
      likedApps,
      ownedApps,
      reviewedApps,
      active,
      reputation,
      strikes,
      joinedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.username == this.username &&
          other.userLoginEmail == this.userLoginEmail &&
          other.password == this.password &&
          other.avatarUrl == this.avatarUrl &&
          other.bio == this.bio &&
          other.address == this.address &&
          other.website == this.website &&
          other.privacyPolicy == this.privacyPolicy &&
          other.termsAndConditions == this.termsAndConditions &&
          other.userType == this.userType &&
          other.likedApps == this.likedApps &&
          other.ownedApps == this.ownedApps &&
          other.reviewedApps == this.reviewedApps &&
          other.active == this.active &&
          other.reputation == this.reputation &&
          other.strikes == this.strikes &&
          other.joinedAt == this.joinedAt);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<String> username;
  final Value<String> userLoginEmail;
  final Value<String> password;
  final Value<String> avatarUrl;
  final Value<String> bio;
  final Value<String> address;
  final Value<String> website;
  final Value<String> privacyPolicy;
  final Value<String> termsAndConditions;
  final Value<String> userType;
  final Value<String> likedApps;
  final Value<String> ownedApps;
  final Value<String> reviewedApps;
  final Value<bool> active;
  final Value<int> reputation;
  final Value<int> strikes;
  final Value<DateTime> joinedAt;
  final Value<int> rowid;
  const UserTableCompanion({
    this.username = const Value.absent(),
    this.userLoginEmail = const Value.absent(),
    this.password = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.bio = const Value.absent(),
    this.address = const Value.absent(),
    this.website = const Value.absent(),
    this.privacyPolicy = const Value.absent(),
    this.termsAndConditions = const Value.absent(),
    this.userType = const Value.absent(),
    this.likedApps = const Value.absent(),
    this.ownedApps = const Value.absent(),
    this.reviewedApps = const Value.absent(),
    this.active = const Value.absent(),
    this.reputation = const Value.absent(),
    this.strikes = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserTableCompanion.insert({
    required String username,
    required String userLoginEmail,
    required String password,
    required String avatarUrl,
    required String bio,
    required String address,
    required String website,
    required String privacyPolicy,
    required String termsAndConditions,
    required String userType,
    required String likedApps,
    required String ownedApps,
    required String reviewedApps,
    required bool active,
    required int reputation,
    required int strikes,
    required DateTime joinedAt,
    this.rowid = const Value.absent(),
  })  : username = Value(username),
        userLoginEmail = Value(userLoginEmail),
        password = Value(password),
        avatarUrl = Value(avatarUrl),
        bio = Value(bio),
        address = Value(address),
        website = Value(website),
        privacyPolicy = Value(privacyPolicy),
        termsAndConditions = Value(termsAndConditions),
        userType = Value(userType),
        likedApps = Value(likedApps),
        ownedApps = Value(ownedApps),
        reviewedApps = Value(reviewedApps),
        active = Value(active),
        reputation = Value(reputation),
        strikes = Value(strikes),
        joinedAt = Value(joinedAt);
  static Insertable<UserTableData> custom({
    Expression<String>? username,
    Expression<String>? userLoginEmail,
    Expression<String>? password,
    Expression<String>? avatarUrl,
    Expression<String>? bio,
    Expression<String>? address,
    Expression<String>? website,
    Expression<String>? privacyPolicy,
    Expression<String>? termsAndConditions,
    Expression<String>? userType,
    Expression<String>? likedApps,
    Expression<String>? ownedApps,
    Expression<String>? reviewedApps,
    Expression<bool>? active,
    Expression<int>? reputation,
    Expression<int>? strikes,
    Expression<DateTime>? joinedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (username != null) 'username': username,
      if (userLoginEmail != null) 'user_login_email': userLoginEmail,
      if (password != null) 'password': password,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (bio != null) 'bio': bio,
      if (address != null) 'address': address,
      if (website != null) 'website': website,
      if (privacyPolicy != null) 'privacy_policy': privacyPolicy,
      if (termsAndConditions != null)
        'terms_and_conditions': termsAndConditions,
      if (userType != null) 'user_type': userType,
      if (likedApps != null) 'liked_apps': likedApps,
      if (ownedApps != null) 'owned_apps': ownedApps,
      if (reviewedApps != null) 'reviewed_apps': reviewedApps,
      if (active != null) 'active': active,
      if (reputation != null) 'reputation': reputation,
      if (strikes != null) 'strikes': strikes,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserTableCompanion copyWith(
      {Value<String>? username,
      Value<String>? userLoginEmail,
      Value<String>? password,
      Value<String>? avatarUrl,
      Value<String>? bio,
      Value<String>? address,
      Value<String>? website,
      Value<String>? privacyPolicy,
      Value<String>? termsAndConditions,
      Value<String>? userType,
      Value<String>? likedApps,
      Value<String>? ownedApps,
      Value<String>? reviewedApps,
      Value<bool>? active,
      Value<int>? reputation,
      Value<int>? strikes,
      Value<DateTime>? joinedAt,
      Value<int>? rowid}) {
    return UserTableCompanion(
      username: username ?? this.username,
      userLoginEmail: userLoginEmail ?? this.userLoginEmail,
      password: password ?? this.password,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      website: website ?? this.website,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      userType: userType ?? this.userType,
      likedApps: likedApps ?? this.likedApps,
      ownedApps: ownedApps ?? this.ownedApps,
      reviewedApps: reviewedApps ?? this.reviewedApps,
      active: active ?? this.active,
      reputation: reputation ?? this.reputation,
      strikes: strikes ?? this.strikes,
      joinedAt: joinedAt ?? this.joinedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (userLoginEmail.present) {
      map['user_login_email'] = Variable<String>(userLoginEmail.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (privacyPolicy.present) {
      map['privacy_policy'] = Variable<String>(privacyPolicy.value);
    }
    if (termsAndConditions.present) {
      map['terms_and_conditions'] = Variable<String>(termsAndConditions.value);
    }
    if (userType.present) {
      map['user_type'] = Variable<String>(userType.value);
    }
    if (likedApps.present) {
      map['liked_apps'] = Variable<String>(likedApps.value);
    }
    if (ownedApps.present) {
      map['owned_apps'] = Variable<String>(ownedApps.value);
    }
    if (reviewedApps.present) {
      map['reviewed_apps'] = Variable<String>(reviewedApps.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (reputation.present) {
      map['reputation'] = Variable<int>(reputation.value);
    }
    if (strikes.present) {
      map['strikes'] = Variable<int>(strikes.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('username: $username, ')
          ..write('userLoginEmail: $userLoginEmail, ')
          ..write('password: $password, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('bio: $bio, ')
          ..write('address: $address, ')
          ..write('website: $website, ')
          ..write('privacyPolicy: $privacyPolicy, ')
          ..write('termsAndConditions: $termsAndConditions, ')
          ..write('userType: $userType, ')
          ..write('likedApps: $likedApps, ')
          ..write('ownedApps: $ownedApps, ')
          ..write('reviewedApps: $reviewedApps, ')
          ..write('active: $active, ')
          ..write('reputation: $reputation, ')
          ..write('strikes: $strikes, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppTableTable extends AppTable
    with TableInfo<$AppTableTable, AppTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _appIDMeta = const VerificationMeta('appID');
  @override
  late final GeneratedColumn<String> appID = GeneratedColumn<String>(
      'app_i_d', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _maintainerMeta =
      const VerificationMeta('maintainer');
  @override
  late final GeneratedColumn<String> maintainer = GeneratedColumn<String>(
      'maintainer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _packageIDMeta =
      const VerificationMeta('packageID');
  @override
  late final GeneratedColumn<String> packageID = GeneratedColumn<String>(
      'package_i_d', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _verifiedMeta =
      const VerificationMeta('verified');
  @override
  late final GeneratedColumn<bool> verified = GeneratedColumn<bool>(
      'verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("verified" IN (0, 1))'));
  static const VerificationMeta _pagesMeta = const VerificationMeta('pages');
  @override
  late final GeneratedColumn<String> pages = GeneratedColumn<String>(
      'pages', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _headingsMeta =
      const VerificationMeta('headings');
  @override
  late final GeneratedColumn<String> headings = GeneratedColumn<String>(
      'headings', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shortDescriptionMeta =
      const VerificationMeta('shortDescription');
  @override
  late final GeneratedColumn<String> shortDescription = GeneratedColumn<String>(
      'short_description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bannerImageMeta =
      const VerificationMeta('bannerImage');
  @override
  late final GeneratedColumn<String> bannerImage = GeneratedColumn<String>(
      'banner_image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlsMeta =
      const VerificationMeta('imageUrls');
  @override
  late final GeneratedColumn<String> imageUrls = GeneratedColumn<String>(
      'image_urls', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _esrbRatingMeta =
      const VerificationMeta('esrbRating');
  @override
  late final GeneratedColumn<String> esrbRating = GeneratedColumn<String>(
      'esrb_rating', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pricingModelMeta =
      const VerificationMeta('pricingModel');
  @override
  late final GeneratedColumn<String> pricingModel = GeneratedColumn<String>(
      'pricing_model', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _inAppPurchaseModelMeta =
      const VerificationMeta('inAppPurchaseModel');
  @override
  late final GeneratedColumn<String> inAppPurchaseModel =
      GeneratedColumn<String>('in_app_purchase_model', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _forceLatestMeta =
      const VerificationMeta('forceLatest');
  @override
  late final GeneratedColumn<bool> forceLatest = GeneratedColumn<bool>(
      'force_latest', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("force_latest" IN (0, 1))'));
  static const VerificationMeta _systemRequirementsMeta =
      const VerificationMeta('systemRequirements');
  @override
  late final GeneratedColumn<String> systemRequirements =
      GeneratedColumn<String>('system_requirements', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _permissionsMeta =
      const VerificationMeta('permissions');
  @override
  late final GeneratedColumn<String> permissions = GeneratedColumn<String>(
      'permissions', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _supportedLanguagesMeta =
      const VerificationMeta('supportedLanguages');
  @override
  late final GeneratedColumn<String> supportedLanguages =
      GeneratedColumn<String>('supported_languages', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _supportedPlatformsMeta =
      const VerificationMeta('supportedPlatforms');
  @override
  late final GeneratedColumn<String> supportedPlatforms =
      GeneratedColumn<String>('supported_platforms', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeSourceMeta =
      const VerificationMeta('codeSource');
  @override
  late final GeneratedColumn<String> codeSource = GeneratedColumn<String>(
      'code_source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _homepageMeta =
      const VerificationMeta('homepage');
  @override
  late final GeneratedColumn<String> homepage = GeneratedColumn<String>(
      'homepage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _supportEmailMeta =
      const VerificationMeta('supportEmail');
  @override
  late final GeneratedColumn<String> supportEmail = GeneratedColumn<String>(
      'support_email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _licenseMeta =
      const VerificationMeta('license');
  @override
  late final GeneratedColumn<String> license = GeneratedColumn<String>(
      'license', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linksMeta = const VerificationMeta('links');
  @override
  late final GeneratedColumn<String> links = GeneratedColumn<String>(
      'links', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _publishedOnMeta =
      const VerificationMeta('publishedOn');
  @override
  late final GeneratedColumn<DateTime> publishedOn = GeneratedColumn<DateTime>(
      'published_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedOnMeta =
      const VerificationMeta('updatedOn');
  @override
  late final GeneratedColumn<DateTime> updatedOn = GeneratedColumn<DateTime>(
      'updated_on', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        appID,
        maintainer,
        packageID,
        name,
        verified,
        pages,
        headings,
        shortDescription,
        description,
        tags,
        icon,
        bannerImage,
        imageUrls,
        category,
        esrbRating,
        pricingModel,
        inAppPurchaseModel,
        forceLatest,
        systemRequirements,
        permissions,
        supportedLanguages,
        supportedPlatforms,
        codeSource,
        homepage,
        supportEmail,
        license,
        links,
        publishedOn,
        updatedOn
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_table';
  @override
  VerificationContext validateIntegrity(Insertable<AppTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('app_i_d')) {
      context.handle(_appIDMeta,
          appID.isAcceptableOrUnknown(data['app_i_d']!, _appIDMeta));
    } else if (isInserting) {
      context.missing(_appIDMeta);
    }
    if (data.containsKey('maintainer')) {
      context.handle(
          _maintainerMeta,
          maintainer.isAcceptableOrUnknown(
              data['maintainer']!, _maintainerMeta));
    } else if (isInserting) {
      context.missing(_maintainerMeta);
    }
    if (data.containsKey('package_i_d')) {
      context.handle(
          _packageIDMeta,
          packageID.isAcceptableOrUnknown(
              data['package_i_d']!, _packageIDMeta));
    } else if (isInserting) {
      context.missing(_packageIDMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('verified')) {
      context.handle(_verifiedMeta,
          verified.isAcceptableOrUnknown(data['verified']!, _verifiedMeta));
    } else if (isInserting) {
      context.missing(_verifiedMeta);
    }
    if (data.containsKey('pages')) {
      context.handle(
          _pagesMeta, pages.isAcceptableOrUnknown(data['pages']!, _pagesMeta));
    } else if (isInserting) {
      context.missing(_pagesMeta);
    }
    if (data.containsKey('headings')) {
      context.handle(_headingsMeta,
          headings.isAcceptableOrUnknown(data['headings']!, _headingsMeta));
    } else if (isInserting) {
      context.missing(_headingsMeta);
    }
    if (data.containsKey('short_description')) {
      context.handle(
          _shortDescriptionMeta,
          shortDescription.isAcceptableOrUnknown(
              data['short_description']!, _shortDescriptionMeta));
    } else if (isInserting) {
      context.missing(_shortDescriptionMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('banner_image')) {
      context.handle(
          _bannerImageMeta,
          bannerImage.isAcceptableOrUnknown(
              data['banner_image']!, _bannerImageMeta));
    } else if (isInserting) {
      context.missing(_bannerImageMeta);
    }
    if (data.containsKey('image_urls')) {
      context.handle(_imageUrlsMeta,
          imageUrls.isAcceptableOrUnknown(data['image_urls']!, _imageUrlsMeta));
    } else if (isInserting) {
      context.missing(_imageUrlsMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('esrb_rating')) {
      context.handle(
          _esrbRatingMeta,
          esrbRating.isAcceptableOrUnknown(
              data['esrb_rating']!, _esrbRatingMeta));
    } else if (isInserting) {
      context.missing(_esrbRatingMeta);
    }
    if (data.containsKey('pricing_model')) {
      context.handle(
          _pricingModelMeta,
          pricingModel.isAcceptableOrUnknown(
              data['pricing_model']!, _pricingModelMeta));
    } else if (isInserting) {
      context.missing(_pricingModelMeta);
    }
    if (data.containsKey('in_app_purchase_model')) {
      context.handle(
          _inAppPurchaseModelMeta,
          inAppPurchaseModel.isAcceptableOrUnknown(
              data['in_app_purchase_model']!, _inAppPurchaseModelMeta));
    } else if (isInserting) {
      context.missing(_inAppPurchaseModelMeta);
    }
    if (data.containsKey('force_latest')) {
      context.handle(
          _forceLatestMeta,
          forceLatest.isAcceptableOrUnknown(
              data['force_latest']!, _forceLatestMeta));
    } else if (isInserting) {
      context.missing(_forceLatestMeta);
    }
    if (data.containsKey('system_requirements')) {
      context.handle(
          _systemRequirementsMeta,
          systemRequirements.isAcceptableOrUnknown(
              data['system_requirements']!, _systemRequirementsMeta));
    } else if (isInserting) {
      context.missing(_systemRequirementsMeta);
    }
    if (data.containsKey('permissions')) {
      context.handle(
          _permissionsMeta,
          permissions.isAcceptableOrUnknown(
              data['permissions']!, _permissionsMeta));
    } else if (isInserting) {
      context.missing(_permissionsMeta);
    }
    if (data.containsKey('supported_languages')) {
      context.handle(
          _supportedLanguagesMeta,
          supportedLanguages.isAcceptableOrUnknown(
              data['supported_languages']!, _supportedLanguagesMeta));
    } else if (isInserting) {
      context.missing(_supportedLanguagesMeta);
    }
    if (data.containsKey('supported_platforms')) {
      context.handle(
          _supportedPlatformsMeta,
          supportedPlatforms.isAcceptableOrUnknown(
              data['supported_platforms']!, _supportedPlatformsMeta));
    } else if (isInserting) {
      context.missing(_supportedPlatformsMeta);
    }
    if (data.containsKey('code_source')) {
      context.handle(
          _codeSourceMeta,
          codeSource.isAcceptableOrUnknown(
              data['code_source']!, _codeSourceMeta));
    } else if (isInserting) {
      context.missing(_codeSourceMeta);
    }
    if (data.containsKey('homepage')) {
      context.handle(_homepageMeta,
          homepage.isAcceptableOrUnknown(data['homepage']!, _homepageMeta));
    } else if (isInserting) {
      context.missing(_homepageMeta);
    }
    if (data.containsKey('support_email')) {
      context.handle(
          _supportEmailMeta,
          supportEmail.isAcceptableOrUnknown(
              data['support_email']!, _supportEmailMeta));
    } else if (isInserting) {
      context.missing(_supportEmailMeta);
    }
    if (data.containsKey('license')) {
      context.handle(_licenseMeta,
          license.isAcceptableOrUnknown(data['license']!, _licenseMeta));
    } else if (isInserting) {
      context.missing(_licenseMeta);
    }
    if (data.containsKey('links')) {
      context.handle(
          _linksMeta, links.isAcceptableOrUnknown(data['links']!, _linksMeta));
    } else if (isInserting) {
      context.missing(_linksMeta);
    }
    if (data.containsKey('published_on')) {
      context.handle(
          _publishedOnMeta,
          publishedOn.isAcceptableOrUnknown(
              data['published_on']!, _publishedOnMeta));
    } else if (isInserting) {
      context.missing(_publishedOnMeta);
    }
    if (data.containsKey('updated_on')) {
      context.handle(_updatedOnMeta,
          updatedOn.isAcceptableOrUnknown(data['updated_on']!, _updatedOnMeta));
    } else if (isInserting) {
      context.missing(_updatedOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AppTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppTableData(
      appID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_i_d'])!,
      maintainer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}maintainer'])!,
      packageID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}package_i_d'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      verified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}verified'])!,
      pages: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pages'])!,
      headings: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}headings'])!,
      shortDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}short_description'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      bannerImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}banner_image'])!,
      imageUrls: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_urls'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      esrbRating: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}esrb_rating'])!,
      pricingModel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pricing_model'])!,
      inAppPurchaseModel: attachedDatabase.typeMapping.read(DriftSqlType.string,
          data['${effectivePrefix}in_app_purchase_model'])!,
      forceLatest: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}force_latest'])!,
      systemRequirements: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}system_requirements'])!,
      permissions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}permissions'])!,
      supportedLanguages: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}supported_languages'])!,
      supportedPlatforms: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}supported_platforms'])!,
      codeSource: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code_source'])!,
      homepage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}homepage'])!,
      supportEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}support_email'])!,
      license: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}license'])!,
      links: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}links'])!,
      publishedOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_on'])!,
      updatedOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_on'])!,
    );
  }

  @override
  $AppTableTable createAlias(String alias) {
    return $AppTableTable(attachedDatabase, alias);
  }
}

class AppTableData extends DataClass implements Insertable<AppTableData> {
  final String appID;
  final String maintainer;
  final String packageID;
  final String name;
  final bool verified;
  final String pages;
  final String headings;
  final String shortDescription;
  final String description;
  final String tags;
  final String icon;
  final String bannerImage;
  final String imageUrls;
  final String category;
  final String esrbRating;
  final String pricingModel;
  final String inAppPurchaseModel;
  final bool forceLatest;
  final String systemRequirements;
  final String permissions;
  final String supportedLanguages;
  final String supportedPlatforms;
  final String codeSource;
  final String homepage;
  final String supportEmail;
  final String license;
  final String links;
  final DateTime publishedOn;
  final DateTime updatedOn;
  const AppTableData(
      {required this.appID,
      required this.maintainer,
      required this.packageID,
      required this.name,
      required this.verified,
      required this.pages,
      required this.headings,
      required this.shortDescription,
      required this.description,
      required this.tags,
      required this.icon,
      required this.bannerImage,
      required this.imageUrls,
      required this.category,
      required this.esrbRating,
      required this.pricingModel,
      required this.inAppPurchaseModel,
      required this.forceLatest,
      required this.systemRequirements,
      required this.permissions,
      required this.supportedLanguages,
      required this.supportedPlatforms,
      required this.codeSource,
      required this.homepage,
      required this.supportEmail,
      required this.license,
      required this.links,
      required this.publishedOn,
      required this.updatedOn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['app_i_d'] = Variable<String>(appID);
    map['maintainer'] = Variable<String>(maintainer);
    map['package_i_d'] = Variable<String>(packageID);
    map['name'] = Variable<String>(name);
    map['verified'] = Variable<bool>(verified);
    map['pages'] = Variable<String>(pages);
    map['headings'] = Variable<String>(headings);
    map['short_description'] = Variable<String>(shortDescription);
    map['description'] = Variable<String>(description);
    map['tags'] = Variable<String>(tags);
    map['icon'] = Variable<String>(icon);
    map['banner_image'] = Variable<String>(bannerImage);
    map['image_urls'] = Variable<String>(imageUrls);
    map['category'] = Variable<String>(category);
    map['esrb_rating'] = Variable<String>(esrbRating);
    map['pricing_model'] = Variable<String>(pricingModel);
    map['in_app_purchase_model'] = Variable<String>(inAppPurchaseModel);
    map['force_latest'] = Variable<bool>(forceLatest);
    map['system_requirements'] = Variable<String>(systemRequirements);
    map['permissions'] = Variable<String>(permissions);
    map['supported_languages'] = Variable<String>(supportedLanguages);
    map['supported_platforms'] = Variable<String>(supportedPlatforms);
    map['code_source'] = Variable<String>(codeSource);
    map['homepage'] = Variable<String>(homepage);
    map['support_email'] = Variable<String>(supportEmail);
    map['license'] = Variable<String>(license);
    map['links'] = Variable<String>(links);
    map['published_on'] = Variable<DateTime>(publishedOn);
    map['updated_on'] = Variable<DateTime>(updatedOn);
    return map;
  }

  AppTableCompanion toCompanion(bool nullToAbsent) {
    return AppTableCompanion(
      appID: Value(appID),
      maintainer: Value(maintainer),
      packageID: Value(packageID),
      name: Value(name),
      verified: Value(verified),
      pages: Value(pages),
      headings: Value(headings),
      shortDescription: Value(shortDescription),
      description: Value(description),
      tags: Value(tags),
      icon: Value(icon),
      bannerImage: Value(bannerImage),
      imageUrls: Value(imageUrls),
      category: Value(category),
      esrbRating: Value(esrbRating),
      pricingModel: Value(pricingModel),
      inAppPurchaseModel: Value(inAppPurchaseModel),
      forceLatest: Value(forceLatest),
      systemRequirements: Value(systemRequirements),
      permissions: Value(permissions),
      supportedLanguages: Value(supportedLanguages),
      supportedPlatforms: Value(supportedPlatforms),
      codeSource: Value(codeSource),
      homepage: Value(homepage),
      supportEmail: Value(supportEmail),
      license: Value(license),
      links: Value(links),
      publishedOn: Value(publishedOn),
      updatedOn: Value(updatedOn),
    );
  }

  factory AppTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppTableData(
      appID: serializer.fromJson<String>(json['appID']),
      maintainer: serializer.fromJson<String>(json['maintainer']),
      packageID: serializer.fromJson<String>(json['packageID']),
      name: serializer.fromJson<String>(json['name']),
      verified: serializer.fromJson<bool>(json['verified']),
      pages: serializer.fromJson<String>(json['pages']),
      headings: serializer.fromJson<String>(json['headings']),
      shortDescription: serializer.fromJson<String>(json['shortDescription']),
      description: serializer.fromJson<String>(json['description']),
      tags: serializer.fromJson<String>(json['tags']),
      icon: serializer.fromJson<String>(json['icon']),
      bannerImage: serializer.fromJson<String>(json['bannerImage']),
      imageUrls: serializer.fromJson<String>(json['imageUrls']),
      category: serializer.fromJson<String>(json['category']),
      esrbRating: serializer.fromJson<String>(json['esrbRating']),
      pricingModel: serializer.fromJson<String>(json['pricingModel']),
      inAppPurchaseModel:
          serializer.fromJson<String>(json['inAppPurchaseModel']),
      forceLatest: serializer.fromJson<bool>(json['forceLatest']),
      systemRequirements:
          serializer.fromJson<String>(json['systemRequirements']),
      permissions: serializer.fromJson<String>(json['permissions']),
      supportedLanguages:
          serializer.fromJson<String>(json['supportedLanguages']),
      supportedPlatforms:
          serializer.fromJson<String>(json['supportedPlatforms']),
      codeSource: serializer.fromJson<String>(json['codeSource']),
      homepage: serializer.fromJson<String>(json['homepage']),
      supportEmail: serializer.fromJson<String>(json['supportEmail']),
      license: serializer.fromJson<String>(json['license']),
      links: serializer.fromJson<String>(json['links']),
      publishedOn: serializer.fromJson<DateTime>(json['publishedOn']),
      updatedOn: serializer.fromJson<DateTime>(json['updatedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'appID': serializer.toJson<String>(appID),
      'maintainer': serializer.toJson<String>(maintainer),
      'packageID': serializer.toJson<String>(packageID),
      'name': serializer.toJson<String>(name),
      'verified': serializer.toJson<bool>(verified),
      'pages': serializer.toJson<String>(pages),
      'headings': serializer.toJson<String>(headings),
      'shortDescription': serializer.toJson<String>(shortDescription),
      'description': serializer.toJson<String>(description),
      'tags': serializer.toJson<String>(tags),
      'icon': serializer.toJson<String>(icon),
      'bannerImage': serializer.toJson<String>(bannerImage),
      'imageUrls': serializer.toJson<String>(imageUrls),
      'category': serializer.toJson<String>(category),
      'esrbRating': serializer.toJson<String>(esrbRating),
      'pricingModel': serializer.toJson<String>(pricingModel),
      'inAppPurchaseModel': serializer.toJson<String>(inAppPurchaseModel),
      'forceLatest': serializer.toJson<bool>(forceLatest),
      'systemRequirements': serializer.toJson<String>(systemRequirements),
      'permissions': serializer.toJson<String>(permissions),
      'supportedLanguages': serializer.toJson<String>(supportedLanguages),
      'supportedPlatforms': serializer.toJson<String>(supportedPlatforms),
      'codeSource': serializer.toJson<String>(codeSource),
      'homepage': serializer.toJson<String>(homepage),
      'supportEmail': serializer.toJson<String>(supportEmail),
      'license': serializer.toJson<String>(license),
      'links': serializer.toJson<String>(links),
      'publishedOn': serializer.toJson<DateTime>(publishedOn),
      'updatedOn': serializer.toJson<DateTime>(updatedOn),
    };
  }

  AppTableData copyWith(
          {String? appID,
          String? maintainer,
          String? packageID,
          String? name,
          bool? verified,
          String? pages,
          String? headings,
          String? shortDescription,
          String? description,
          String? tags,
          String? icon,
          String? bannerImage,
          String? imageUrls,
          String? category,
          String? esrbRating,
          String? pricingModel,
          String? inAppPurchaseModel,
          bool? forceLatest,
          String? systemRequirements,
          String? permissions,
          String? supportedLanguages,
          String? supportedPlatforms,
          String? codeSource,
          String? homepage,
          String? supportEmail,
          String? license,
          String? links,
          DateTime? publishedOn,
          DateTime? updatedOn}) =>
      AppTableData(
        appID: appID ?? this.appID,
        maintainer: maintainer ?? this.maintainer,
        packageID: packageID ?? this.packageID,
        name: name ?? this.name,
        verified: verified ?? this.verified,
        pages: pages ?? this.pages,
        headings: headings ?? this.headings,
        shortDescription: shortDescription ?? this.shortDescription,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        icon: icon ?? this.icon,
        bannerImage: bannerImage ?? this.bannerImage,
        imageUrls: imageUrls ?? this.imageUrls,
        category: category ?? this.category,
        esrbRating: esrbRating ?? this.esrbRating,
        pricingModel: pricingModel ?? this.pricingModel,
        inAppPurchaseModel: inAppPurchaseModel ?? this.inAppPurchaseModel,
        forceLatest: forceLatest ?? this.forceLatest,
        systemRequirements: systemRequirements ?? this.systemRequirements,
        permissions: permissions ?? this.permissions,
        supportedLanguages: supportedLanguages ?? this.supportedLanguages,
        supportedPlatforms: supportedPlatforms ?? this.supportedPlatforms,
        codeSource: codeSource ?? this.codeSource,
        homepage: homepage ?? this.homepage,
        supportEmail: supportEmail ?? this.supportEmail,
        license: license ?? this.license,
        links: links ?? this.links,
        publishedOn: publishedOn ?? this.publishedOn,
        updatedOn: updatedOn ?? this.updatedOn,
      );
  @override
  String toString() {
    return (StringBuffer('AppTableData(')
          ..write('appID: $appID, ')
          ..write('maintainer: $maintainer, ')
          ..write('packageID: $packageID, ')
          ..write('name: $name, ')
          ..write('verified: $verified, ')
          ..write('pages: $pages, ')
          ..write('headings: $headings, ')
          ..write('shortDescription: $shortDescription, ')
          ..write('description: $description, ')
          ..write('tags: $tags, ')
          ..write('icon: $icon, ')
          ..write('bannerImage: $bannerImage, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('category: $category, ')
          ..write('esrbRating: $esrbRating, ')
          ..write('pricingModel: $pricingModel, ')
          ..write('inAppPurchaseModel: $inAppPurchaseModel, ')
          ..write('forceLatest: $forceLatest, ')
          ..write('systemRequirements: $systemRequirements, ')
          ..write('permissions: $permissions, ')
          ..write('supportedLanguages: $supportedLanguages, ')
          ..write('supportedPlatforms: $supportedPlatforms, ')
          ..write('codeSource: $codeSource, ')
          ..write('homepage: $homepage, ')
          ..write('supportEmail: $supportEmail, ')
          ..write('license: $license, ')
          ..write('links: $links, ')
          ..write('publishedOn: $publishedOn, ')
          ..write('updatedOn: $updatedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        appID,
        maintainer,
        packageID,
        name,
        verified,
        pages,
        headings,
        shortDescription,
        description,
        tags,
        icon,
        bannerImage,
        imageUrls,
        category,
        esrbRating,
        pricingModel,
        inAppPurchaseModel,
        forceLatest,
        systemRequirements,
        permissions,
        supportedLanguages,
        supportedPlatforms,
        codeSource,
        homepage,
        supportEmail,
        license,
        links,
        publishedOn,
        updatedOn
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppTableData &&
          other.appID == this.appID &&
          other.maintainer == this.maintainer &&
          other.packageID == this.packageID &&
          other.name == this.name &&
          other.verified == this.verified &&
          other.pages == this.pages &&
          other.headings == this.headings &&
          other.shortDescription == this.shortDescription &&
          other.description == this.description &&
          other.tags == this.tags &&
          other.icon == this.icon &&
          other.bannerImage == this.bannerImage &&
          other.imageUrls == this.imageUrls &&
          other.category == this.category &&
          other.esrbRating == this.esrbRating &&
          other.pricingModel == this.pricingModel &&
          other.inAppPurchaseModel == this.inAppPurchaseModel &&
          other.forceLatest == this.forceLatest &&
          other.systemRequirements == this.systemRequirements &&
          other.permissions == this.permissions &&
          other.supportedLanguages == this.supportedLanguages &&
          other.supportedPlatforms == this.supportedPlatforms &&
          other.codeSource == this.codeSource &&
          other.homepage == this.homepage &&
          other.supportEmail == this.supportEmail &&
          other.license == this.license &&
          other.links == this.links &&
          other.publishedOn == this.publishedOn &&
          other.updatedOn == this.updatedOn);
}

class AppTableCompanion extends UpdateCompanion<AppTableData> {
  final Value<String> appID;
  final Value<String> maintainer;
  final Value<String> packageID;
  final Value<String> name;
  final Value<bool> verified;
  final Value<String> pages;
  final Value<String> headings;
  final Value<String> shortDescription;
  final Value<String> description;
  final Value<String> tags;
  final Value<String> icon;
  final Value<String> bannerImage;
  final Value<String> imageUrls;
  final Value<String> category;
  final Value<String> esrbRating;
  final Value<String> pricingModel;
  final Value<String> inAppPurchaseModel;
  final Value<bool> forceLatest;
  final Value<String> systemRequirements;
  final Value<String> permissions;
  final Value<String> supportedLanguages;
  final Value<String> supportedPlatforms;
  final Value<String> codeSource;
  final Value<String> homepage;
  final Value<String> supportEmail;
  final Value<String> license;
  final Value<String> links;
  final Value<DateTime> publishedOn;
  final Value<DateTime> updatedOn;
  final Value<int> rowid;
  const AppTableCompanion({
    this.appID = const Value.absent(),
    this.maintainer = const Value.absent(),
    this.packageID = const Value.absent(),
    this.name = const Value.absent(),
    this.verified = const Value.absent(),
    this.pages = const Value.absent(),
    this.headings = const Value.absent(),
    this.shortDescription = const Value.absent(),
    this.description = const Value.absent(),
    this.tags = const Value.absent(),
    this.icon = const Value.absent(),
    this.bannerImage = const Value.absent(),
    this.imageUrls = const Value.absent(),
    this.category = const Value.absent(),
    this.esrbRating = const Value.absent(),
    this.pricingModel = const Value.absent(),
    this.inAppPurchaseModel = const Value.absent(),
    this.forceLatest = const Value.absent(),
    this.systemRequirements = const Value.absent(),
    this.permissions = const Value.absent(),
    this.supportedLanguages = const Value.absent(),
    this.supportedPlatforms = const Value.absent(),
    this.codeSource = const Value.absent(),
    this.homepage = const Value.absent(),
    this.supportEmail = const Value.absent(),
    this.license = const Value.absent(),
    this.links = const Value.absent(),
    this.publishedOn = const Value.absent(),
    this.updatedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppTableCompanion.insert({
    required String appID,
    required String maintainer,
    required String packageID,
    required String name,
    required bool verified,
    required String pages,
    required String headings,
    required String shortDescription,
    required String description,
    required String tags,
    required String icon,
    required String bannerImage,
    required String imageUrls,
    required String category,
    required String esrbRating,
    required String pricingModel,
    required String inAppPurchaseModel,
    required bool forceLatest,
    required String systemRequirements,
    required String permissions,
    required String supportedLanguages,
    required String supportedPlatforms,
    required String codeSource,
    required String homepage,
    required String supportEmail,
    required String license,
    required String links,
    required DateTime publishedOn,
    required DateTime updatedOn,
    this.rowid = const Value.absent(),
  })  : appID = Value(appID),
        maintainer = Value(maintainer),
        packageID = Value(packageID),
        name = Value(name),
        verified = Value(verified),
        pages = Value(pages),
        headings = Value(headings),
        shortDescription = Value(shortDescription),
        description = Value(description),
        tags = Value(tags),
        icon = Value(icon),
        bannerImage = Value(bannerImage),
        imageUrls = Value(imageUrls),
        category = Value(category),
        esrbRating = Value(esrbRating),
        pricingModel = Value(pricingModel),
        inAppPurchaseModel = Value(inAppPurchaseModel),
        forceLatest = Value(forceLatest),
        systemRequirements = Value(systemRequirements),
        permissions = Value(permissions),
        supportedLanguages = Value(supportedLanguages),
        supportedPlatforms = Value(supportedPlatforms),
        codeSource = Value(codeSource),
        homepage = Value(homepage),
        supportEmail = Value(supportEmail),
        license = Value(license),
        links = Value(links),
        publishedOn = Value(publishedOn),
        updatedOn = Value(updatedOn);
  static Insertable<AppTableData> custom({
    Expression<String>? appID,
    Expression<String>? maintainer,
    Expression<String>? packageID,
    Expression<String>? name,
    Expression<bool>? verified,
    Expression<String>? pages,
    Expression<String>? headings,
    Expression<String>? shortDescription,
    Expression<String>? description,
    Expression<String>? tags,
    Expression<String>? icon,
    Expression<String>? bannerImage,
    Expression<String>? imageUrls,
    Expression<String>? category,
    Expression<String>? esrbRating,
    Expression<String>? pricingModel,
    Expression<String>? inAppPurchaseModel,
    Expression<bool>? forceLatest,
    Expression<String>? systemRequirements,
    Expression<String>? permissions,
    Expression<String>? supportedLanguages,
    Expression<String>? supportedPlatforms,
    Expression<String>? codeSource,
    Expression<String>? homepage,
    Expression<String>? supportEmail,
    Expression<String>? license,
    Expression<String>? links,
    Expression<DateTime>? publishedOn,
    Expression<DateTime>? updatedOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (appID != null) 'app_i_d': appID,
      if (maintainer != null) 'maintainer': maintainer,
      if (packageID != null) 'package_i_d': packageID,
      if (name != null) 'name': name,
      if (verified != null) 'verified': verified,
      if (pages != null) 'pages': pages,
      if (headings != null) 'headings': headings,
      if (shortDescription != null) 'short_description': shortDescription,
      if (description != null) 'description': description,
      if (tags != null) 'tags': tags,
      if (icon != null) 'icon': icon,
      if (bannerImage != null) 'banner_image': bannerImage,
      if (imageUrls != null) 'image_urls': imageUrls,
      if (category != null) 'category': category,
      if (esrbRating != null) 'esrb_rating': esrbRating,
      if (pricingModel != null) 'pricing_model': pricingModel,
      if (inAppPurchaseModel != null)
        'in_app_purchase_model': inAppPurchaseModel,
      if (forceLatest != null) 'force_latest': forceLatest,
      if (systemRequirements != null) 'system_requirements': systemRequirements,
      if (permissions != null) 'permissions': permissions,
      if (supportedLanguages != null) 'supported_languages': supportedLanguages,
      if (supportedPlatforms != null) 'supported_platforms': supportedPlatforms,
      if (codeSource != null) 'code_source': codeSource,
      if (homepage != null) 'homepage': homepage,
      if (supportEmail != null) 'support_email': supportEmail,
      if (license != null) 'license': license,
      if (links != null) 'links': links,
      if (publishedOn != null) 'published_on': publishedOn,
      if (updatedOn != null) 'updated_on': updatedOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppTableCompanion copyWith(
      {Value<String>? appID,
      Value<String>? maintainer,
      Value<String>? packageID,
      Value<String>? name,
      Value<bool>? verified,
      Value<String>? pages,
      Value<String>? headings,
      Value<String>? shortDescription,
      Value<String>? description,
      Value<String>? tags,
      Value<String>? icon,
      Value<String>? bannerImage,
      Value<String>? imageUrls,
      Value<String>? category,
      Value<String>? esrbRating,
      Value<String>? pricingModel,
      Value<String>? inAppPurchaseModel,
      Value<bool>? forceLatest,
      Value<String>? systemRequirements,
      Value<String>? permissions,
      Value<String>? supportedLanguages,
      Value<String>? supportedPlatforms,
      Value<String>? codeSource,
      Value<String>? homepage,
      Value<String>? supportEmail,
      Value<String>? license,
      Value<String>? links,
      Value<DateTime>? publishedOn,
      Value<DateTime>? updatedOn,
      Value<int>? rowid}) {
    return AppTableCompanion(
      appID: appID ?? this.appID,
      maintainer: maintainer ?? this.maintainer,
      packageID: packageID ?? this.packageID,
      name: name ?? this.name,
      verified: verified ?? this.verified,
      pages: pages ?? this.pages,
      headings: headings ?? this.headings,
      shortDescription: shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      icon: icon ?? this.icon,
      bannerImage: bannerImage ?? this.bannerImage,
      imageUrls: imageUrls ?? this.imageUrls,
      category: category ?? this.category,
      esrbRating: esrbRating ?? this.esrbRating,
      pricingModel: pricingModel ?? this.pricingModel,
      inAppPurchaseModel: inAppPurchaseModel ?? this.inAppPurchaseModel,
      forceLatest: forceLatest ?? this.forceLatest,
      systemRequirements: systemRequirements ?? this.systemRequirements,
      permissions: permissions ?? this.permissions,
      supportedLanguages: supportedLanguages ?? this.supportedLanguages,
      supportedPlatforms: supportedPlatforms ?? this.supportedPlatforms,
      codeSource: codeSource ?? this.codeSource,
      homepage: homepage ?? this.homepage,
      supportEmail: supportEmail ?? this.supportEmail,
      license: license ?? this.license,
      links: links ?? this.links,
      publishedOn: publishedOn ?? this.publishedOn,
      updatedOn: updatedOn ?? this.updatedOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (appID.present) {
      map['app_i_d'] = Variable<String>(appID.value);
    }
    if (maintainer.present) {
      map['maintainer'] = Variable<String>(maintainer.value);
    }
    if (packageID.present) {
      map['package_i_d'] = Variable<String>(packageID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (verified.present) {
      map['verified'] = Variable<bool>(verified.value);
    }
    if (pages.present) {
      map['pages'] = Variable<String>(pages.value);
    }
    if (headings.present) {
      map['headings'] = Variable<String>(headings.value);
    }
    if (shortDescription.present) {
      map['short_description'] = Variable<String>(shortDescription.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (bannerImage.present) {
      map['banner_image'] = Variable<String>(bannerImage.value);
    }
    if (imageUrls.present) {
      map['image_urls'] = Variable<String>(imageUrls.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (esrbRating.present) {
      map['esrb_rating'] = Variable<String>(esrbRating.value);
    }
    if (pricingModel.present) {
      map['pricing_model'] = Variable<String>(pricingModel.value);
    }
    if (inAppPurchaseModel.present) {
      map['in_app_purchase_model'] = Variable<String>(inAppPurchaseModel.value);
    }
    if (forceLatest.present) {
      map['force_latest'] = Variable<bool>(forceLatest.value);
    }
    if (systemRequirements.present) {
      map['system_requirements'] = Variable<String>(systemRequirements.value);
    }
    if (permissions.present) {
      map['permissions'] = Variable<String>(permissions.value);
    }
    if (supportedLanguages.present) {
      map['supported_languages'] = Variable<String>(supportedLanguages.value);
    }
    if (supportedPlatforms.present) {
      map['supported_platforms'] = Variable<String>(supportedPlatforms.value);
    }
    if (codeSource.present) {
      map['code_source'] = Variable<String>(codeSource.value);
    }
    if (homepage.present) {
      map['homepage'] = Variable<String>(homepage.value);
    }
    if (supportEmail.present) {
      map['support_email'] = Variable<String>(supportEmail.value);
    }
    if (license.present) {
      map['license'] = Variable<String>(license.value);
    }
    if (links.present) {
      map['links'] = Variable<String>(links.value);
    }
    if (publishedOn.present) {
      map['published_on'] = Variable<DateTime>(publishedOn.value);
    }
    if (updatedOn.present) {
      map['updated_on'] = Variable<DateTime>(updatedOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppTableCompanion(')
          ..write('appID: $appID, ')
          ..write('maintainer: $maintainer, ')
          ..write('packageID: $packageID, ')
          ..write('name: $name, ')
          ..write('verified: $verified, ')
          ..write('pages: $pages, ')
          ..write('headings: $headings, ')
          ..write('shortDescription: $shortDescription, ')
          ..write('description: $description, ')
          ..write('tags: $tags, ')
          ..write('icon: $icon, ')
          ..write('bannerImage: $bannerImage, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('category: $category, ')
          ..write('esrbRating: $esrbRating, ')
          ..write('pricingModel: $pricingModel, ')
          ..write('inAppPurchaseModel: $inAppPurchaseModel, ')
          ..write('forceLatest: $forceLatest, ')
          ..write('systemRequirements: $systemRequirements, ')
          ..write('permissions: $permissions, ')
          ..write('supportedLanguages: $supportedLanguages, ')
          ..write('supportedPlatforms: $supportedPlatforms, ')
          ..write('codeSource: $codeSource, ')
          ..write('homepage: $homepage, ')
          ..write('supportEmail: $supportEmail, ')
          ..write('license: $license, ')
          ..write('links: $links, ')
          ..write('publishedOn: $publishedOn, ')
          ..write('updatedOn: $updatedOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppReviewTableTable extends AppReviewTable
    with TableInfo<$AppReviewTableTable, AppReviewTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppReviewTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _appIDMeta = const VerificationMeta('appID');
  @override
  late final GeneratedColumn<String> appID = GeneratedColumn<String>(
      'app_i_d', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _reviewsMeta =
      const VerificationMeta('reviews');
  @override
  late final GeneratedColumn<String> reviews = GeneratedColumn<String>(
      'reviews', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [appID, reviews];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_review_table';
  @override
  VerificationContext validateIntegrity(Insertable<AppReviewTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('app_i_d')) {
      context.handle(_appIDMeta,
          appID.isAcceptableOrUnknown(data['app_i_d']!, _appIDMeta));
    } else if (isInserting) {
      context.missing(_appIDMeta);
    }
    if (data.containsKey('reviews')) {
      context.handle(_reviewsMeta,
          reviews.isAcceptableOrUnknown(data['reviews']!, _reviewsMeta));
    } else if (isInserting) {
      context.missing(_reviewsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AppReviewTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppReviewTableData(
      appID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_i_d'])!,
      reviews: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reviews'])!,
    );
  }

  @override
  $AppReviewTableTable createAlias(String alias) {
    return $AppReviewTableTable(attachedDatabase, alias);
  }
}

class AppReviewTableData extends DataClass
    implements Insertable<AppReviewTableData> {
  final String appID;
  final String reviews;
  const AppReviewTableData({required this.appID, required this.reviews});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['app_i_d'] = Variable<String>(appID);
    map['reviews'] = Variable<String>(reviews);
    return map;
  }

  AppReviewTableCompanion toCompanion(bool nullToAbsent) {
    return AppReviewTableCompanion(
      appID: Value(appID),
      reviews: Value(reviews),
    );
  }

  factory AppReviewTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppReviewTableData(
      appID: serializer.fromJson<String>(json['appID']),
      reviews: serializer.fromJson<String>(json['reviews']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'appID': serializer.toJson<String>(appID),
      'reviews': serializer.toJson<String>(reviews),
    };
  }

  AppReviewTableData copyWith({String? appID, String? reviews}) =>
      AppReviewTableData(
        appID: appID ?? this.appID,
        reviews: reviews ?? this.reviews,
      );
  @override
  String toString() {
    return (StringBuffer('AppReviewTableData(')
          ..write('appID: $appID, ')
          ..write('reviews: $reviews')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(appID, reviews);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppReviewTableData &&
          other.appID == this.appID &&
          other.reviews == this.reviews);
}

class AppReviewTableCompanion extends UpdateCompanion<AppReviewTableData> {
  final Value<String> appID;
  final Value<String> reviews;
  final Value<int> rowid;
  const AppReviewTableCompanion({
    this.appID = const Value.absent(),
    this.reviews = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppReviewTableCompanion.insert({
    required String appID,
    required String reviews,
    this.rowid = const Value.absent(),
  })  : appID = Value(appID),
        reviews = Value(reviews);
  static Insertable<AppReviewTableData> custom({
    Expression<String>? appID,
    Expression<String>? reviews,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (appID != null) 'app_i_d': appID,
      if (reviews != null) 'reviews': reviews,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppReviewTableCompanion copyWith(
      {Value<String>? appID, Value<String>? reviews, Value<int>? rowid}) {
    return AppReviewTableCompanion(
      appID: appID ?? this.appID,
      reviews: reviews ?? this.reviews,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (appID.present) {
      map['app_i_d'] = Variable<String>(appID.value);
    }
    if (reviews.present) {
      map['reviews'] = Variable<String>(reviews.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppReviewTableCompanion(')
          ..write('appID: $appID, ')
          ..write('reviews: $reviews, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$FusionDatabase extends GeneratedDatabase {
  _$FusionDatabase(QueryExecutor e) : super(e);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $AppTableTable appTable = $AppTableTable(this);
  late final $AppReviewTableTable appReviewTable = $AppReviewTableTable(this);
  Selectable<UserTableData> _getUsers() {
    return customSelect('SELECT * FROM user_table', variables: [], readsFrom: {
      userTable,
    }).asyncMap(userTable.mapFromRow);
  }

  Selectable<UserTableData> _getUserByUsername(String var1) {
    return customSelect('SELECT * FROM user_table WHERE username = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          userTable,
        }).asyncMap(userTable.mapFromRow);
  }

  Selectable<UserTableData> _getUserByEmail(String var1) {
    return customSelect('SELECT * FROM user_table WHERE user_login_email = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          userTable,
        }).asyncMap(userTable.mapFromRow);
  }

  Future<int> _deleteUserByUsername(String var1) {
    return customUpdate(
      'DELETE FROM user_table WHERE username = ?1',
      variables: [Variable<String>(var1)],
      updates: {userTable},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<AppTableData> _getApps() {
    return customSelect('SELECT * FROM app_table', variables: [], readsFrom: {
      appTable,
    }).asyncMap(appTable.mapFromRow);
  }

  Selectable<AppTableData> _getAppsByMaintainer(String var1) {
    return customSelect(
        'SELECT * FROM app_table WHERE maintainer = ?1 ORDER BY updated_on DESC',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          appTable,
        }).asyncMap(appTable.mapFromRow);
  }

  Selectable<AppTableData> _getAppsByPages(String var1) {
    return customSelect(
        'SELECT * FROM app_table WHERE pages LIKE ?1 ORDER BY updated_on DESC',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          appTable,
        }).asyncMap(appTable.mapFromRow);
  }

  Selectable<AppTableData> _getApp(String var1) {
    return customSelect('SELECT * FROM app_table WHERE app_i_d = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          appTable,
        }).asyncMap(appTable.mapFromRow);
  }

  Future<int> _deleteAppByAppID(String var1) {
    return customUpdate(
      'DELETE FROM app_table WHERE app_i_d = ?1',
      variables: [Variable<String>(var1)],
      updates: {appTable},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<AppReviewTableData> _getAppReviews(String var1) {
    return customSelect('SELECT * FROM app_review_table WHERE app_i_d = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          appReviewTable,
        }).asyncMap(appReviewTable.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userTable, appTable, appReviewTable];
}
