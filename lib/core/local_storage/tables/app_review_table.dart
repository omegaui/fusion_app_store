import 'package:drift/drift.dart';

@DataClassName("AppReviewTableData")
class AppReviewTable extends Table {
  @override
  String? get tableName => "app_review_table";

  TextColumn get appID => text().unique()();

  TextColumn get reviews => text()();
}
