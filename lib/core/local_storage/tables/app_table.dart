import 'package:drift/drift.dart';

@DataClassName("AppTableData")
class AppTable extends Table {
  @override
  String? get tableName => "app_table";

  TextColumn get appID => text().unique()();

  TextColumn get maintainer => text()();

  TextColumn get packageID => text()();

  TextColumn get name => text()();

  BoolColumn get verified => boolean()();

  TextColumn get pages => text()();

  TextColumn get headings => text()();

  TextColumn get shortDescription => text()();

  TextColumn get description => text()();

  TextColumn get tags => text()();

  TextColumn get icon => text()();

  TextColumn get bannerImage => text()();

  TextColumn get imageUrls => text()();

  TextColumn get category => text()();

  TextColumn get esrbRating => text()();

  TextColumn get pricingModel => text()();

  TextColumn get inAppPurchaseModel => text()();

  BoolColumn get forceLatest => boolean()();

  TextColumn get systemRequirements => text()();

  TextColumn get permissions => text()();

  TextColumn get supportedLanguages => text()();

  TextColumn get supportedPlatforms => text()();

  TextColumn get codeSource => text()();

  TextColumn get homepage => text()();

  TextColumn get supportEmail => text()();

  TextColumn get license => text()();

  TextColumn get links => text()();

  DateTimeColumn get publishedOn => dateTime()();

  DateTimeColumn get updatedOn => dateTime()();
}
