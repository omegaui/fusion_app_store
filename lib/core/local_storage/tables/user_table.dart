import 'package:drift/drift.dart';

@DataClassName('UserTableData')
class UserTable extends Table {
  @override
  String? get tableName => "user_table";

  TextColumn get username => text().unique()();

  TextColumn get userLoginEmail => text()();

  TextColumn get password => text()();

  TextColumn get avatarUrl => text()();

  TextColumn get bio => text()();

  TextColumn get address => text()();

  TextColumn get website => text()();

  TextColumn get privacyPolicy => text()();

  TextColumn get termsAndConditions => text()();

  TextColumn get userType => text()();

  TextColumn get likedApps => text()();

  TextColumn get ownedApps => text()();

  TextColumn get reviewedApps => text()();

  BoolColumn get active => boolean()();

  IntColumn get reputation => integer()();

  IntColumn get strikes => integer()();

  DateTimeColumn get joinedAt => dateTime()();
}
