import 'package:fusion_app_store/app/store/domain/entities/models/app_category.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/esrb_rating.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/in_app_purchase_model.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/permissions.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/pricing_model.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/system_requirements.dart';
import 'package:fusion_app_store/core/cloud_storage/capabilities.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';

class AppEntity {
  final String appID;
  final String maintainer;
  final String packageID; // done
  final Set<String> pages; // implicit
  final Set<String> headings; // implicit
  final String name; // done
  final bool verified; // done
  final String shortDescription; // done
  final List<String> description; // done
  final List<String> tags; // pending
  final String icon; // done
  final String bannerImage; // pending
  final List<String> imageUrls; // done
  final AppCategory category; // done
  final EsrbRating esrbRating; // done
  final PricingModel pricingModel; // done
  final InAppPurchaseModel inAppPurchaseModel; // done
  final bool forceLatest; // pending
  final List<SystemRequirements> systemRequirements; // requirements
  final Permissions permissions; // done
  final List<String> supportedLanguages; // pending
  final List<SupportedPlatform> supportedPlatforms; // done
  final String codeSource; // pending
  final String homepage; // done
  final String supportEmail;
  final String license; // pending
  final List<String> links; // pending
  final DateTime publishedOn;
  final DateTime updatedOn;

  String get storageBucketPath => "$maintainer/$packageID";

  bool get isFree => pricingModel.type == PricingType.free;
  bool get isPaid => pricingModel.type == PricingType.paid;

  AppEntity({
    required this.appID,
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
    required this.updatedOn,
  });

  AppEntity.clone(
    AppEntity source, {
    String? maintainer,
    String? packageID,
    String? name,
    bool? verified,
    Set<String>? pages,
    Set<String>? headings,
    String? shortDescription,
    List<String>? description,
    List<String>? tags,
    String? icon,
    String? bannerImage,
    List<String>? imageUrls,
    AppCategory? category,
    EsrbRating? esrbRating,
    PricingModel? pricingModel,
    InAppPurchaseModel? inAppPurchaseModel,
    bool? forceLatest,
    List<SystemRequirements>? systemRequirements,
    Permissions? permissions,
    List<String>? supportedLanguages,
    List<SupportedPlatform>? supportedPlatforms,
    String? codeSource,
    String? homepage,
    String? supportEmail,
    String? license,
    List<String>? links,
    DateTime? publishedOn,
    DateTime? updatedOn,
  })  : appID =
            "${maintainer ?? source.maintainer}@${packageID ?? source.packageID}",
        maintainer = maintainer ?? source.maintainer,
        packageID = packageID ?? source.packageID,
        name = name ?? source.name,
        verified = verified ?? source.verified,
        pages = pages ?? source.pages,
        headings = headings ?? source.headings,
        shortDescription = shortDescription ?? source.shortDescription,
        description = description ?? source.description,
        tags = tags ?? source.tags,
        icon = icon ?? source.icon,
        bannerImage = bannerImage ?? source.bannerImage,
        imageUrls = imageUrls ?? source.imageUrls,
        category = category ?? source.category,
        esrbRating = esrbRating ?? source.esrbRating,
        pricingModel = pricingModel ?? source.pricingModel,
        inAppPurchaseModel = inAppPurchaseModel ?? source.inAppPurchaseModel,
        forceLatest = forceLatest ?? source.forceLatest,
        systemRequirements = systemRequirements ?? source.systemRequirements,
        permissions = permissions ?? source.permissions,
        supportedLanguages = supportedLanguages ?? source.supportedLanguages,
        supportedPlatforms = supportedPlatforms ?? source.supportedPlatforms,
        codeSource = codeSource ?? source.codeSource,
        homepage = homepage ?? source.homepage,
        supportEmail = supportEmail ?? source.supportEmail,
        license = license ?? source.license,
        links = links ?? source.links,
        publishedOn = publishedOn ?? source.publishedOn,
        updatedOn = updatedOn ?? source.updatedOn;

  static AppEntity empty({
    required String maintainer,
    required String packageID,
  }) {
    return AppEntity(
      appID: "$maintainer@$packageID",
      maintainer: maintainer,
      packageID: packageID,
      name: "",
      verified: false,
      pages: {},
      headings: {},
      shortDescription: "",
      description: [],
      tags: [],
      icon: "",
      bannerImage: "",
      imageUrls: [],
      category: AppCategory.utility,
      esrbRating: EsrbRating.pending,
      pricingModel: PricingModel.empty,
      inAppPurchaseModel: InAppPurchaseModel.empty,
      forceLatest: false,
      systemRequirements: [],
      permissions: Permissions.empty,
      supportedLanguages: [],
      supportedPlatforms: [],
      codeSource: "",
      homepage: "",
      supportEmail: "",
      license: "",
      links: [],
      publishedOn: DateTime.now(),
      updatedOn: DateTime.now(),
    );
  }

  void attachToPage(String page) {
    pages.add(page);
  }

  void attachToAllPages(List<String> pages) {
    this.pages.addAll(pages);
  }

  void attachToHeadings(String heading) {
    if (heading.isEmpty) {
      heading = 'Others';
    }
    headings.add(heading);
  }

  void attachToAllHeadings(List<String> headings) {
    if (headings.isEmpty) {
      headings = ['Others'];
    }
    this.headings.addAll(headings);
  }

  factory AppEntity.fromMap(Map<String, dynamic> map) {
    final maintainer = map[StorageKeys.maintainer];
    final packageID = map[StorageKeys.packageID];
    final name = map[StorageKeys.name];
    final verified = map[StorageKeys.verified] ?? false;
    final pages = Set<String>.from(map[StorageKeys.pages] ?? <String>[]);
    final headings =
        Set<String>.from(map[StorageKeys.headings] ?? <String>['Others']);
    final shortDescription = map[StorageKeys.shortDescription];
    final description = List<String>.from(map[StorageKeys.description]);
    final tags = List<String>.from(map[StorageKeys.tags]);
    final icon = map[StorageKeys.icon];
    final bannerImage = map[StorageKeys.bannerImage];
    final imageUrls = List<String>.from(map[StorageKeys.imageUrls]);
    final category = AppCategory.values.byName(map[StorageKeys.category]);
    final esrbRating = EsrbRating.values.byName(map[StorageKeys.esrbRating]);
    final pricingModel = PricingModel.fromMap(map[StorageKeys.pricingModel]);
    final inAppPurchaseModel =
        InAppPurchaseModel.fromMap(map[StorageKeys.inAppPurchaseModel]);
    final forceLatest = map[StorageKeys.forceLatest];
    final systemRequirements = List<SystemRequirements>.from(
        map[StorageKeys.systemRequirements]
            ?.map((x) => SystemRequirements.fromMap(x)));
    final permissions = Permissions.fromMap(map);
    final supportedLanguages =
        List<String>.from(map[StorageKeys.supportedLanguages]);
    final supportedPlatforms = List<SupportedPlatform>.from(
        map[StorageKeys.supportedPlatforms]
            ?.map((x) => SupportedPlatform.fromMap(x)));
    final codeSource = map[StorageKeys.codeSource];
    final homepage = map[StorageKeys.homepage];
    final supportEmail = map[StorageKeys.supportEmail];
    final license = map[StorageKeys.license];
    final links = List<String>.from(map[StorageKeys.links]);
    final publishedOn = DateTime.fromMillisecondsSinceEpoch(
        map[StorageKeys.publishedOn] ?? DateTime.now().millisecondsSinceEpoch);
    final updatedOn = DateTime.fromMillisecondsSinceEpoch(
        map[StorageKeys.updatedOn] ?? DateTime.now().millisecondsSinceEpoch);

    return AppEntity(
      appID: "$maintainer@$packageID",
      maintainer: maintainer,
      packageID: packageID,
      name: name,
      verified: verified,
      pages: pages,
      headings: headings,
      shortDescription: shortDescription,
      description: description,
      tags: tags,
      icon: icon,
      bannerImage: bannerImage,
      imageUrls: imageUrls,
      category: category,
      esrbRating: esrbRating,
      pricingModel: pricingModel,
      inAppPurchaseModel: inAppPurchaseModel,
      forceLatest: forceLatest,
      systemRequirements: systemRequirements,
      permissions: permissions,
      supportedLanguages: supportedLanguages,
      supportedPlatforms: supportedPlatforms,
      codeSource: codeSource,
      homepage: homepage,
      supportEmail: supportEmail,
      license: license,
      links: links,
      publishedOn: publishedOn,
      updatedOn: updatedOn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.appID: appID,
      StorageKeys.maintainer: maintainer,
      StorageKeys.packageID: packageID,
      StorageKeys.name: name,
      StorageKeys.verified: verified,
      StorageKeys.pages: pages,
      StorageKeys.headings: headings,
      StorageKeys.shortDescription: shortDescription,
      StorageKeys.description: description,
      StorageKeys.tags: tags,
      StorageKeys.icon: icon,
      StorageKeys.bannerImage: bannerImage,
      StorageKeys.imageUrls: imageUrls,
      StorageKeys.category: category.name,
      StorageKeys.esrbRating: esrbRating.name,
      StorageKeys.pricingModel: pricingModel.toMap(),
      StorageKeys.inAppPurchaseModel: inAppPurchaseModel.toMap(),
      StorageKeys.forceLatest: forceLatest,
      StorageKeys.systemRequirements:
          systemRequirements.map((req) => req.toMap()).toList(),
      ...permissions.toMap(),
      StorageKeys.supportedLanguages: supportedLanguages,
      StorageKeys.supportedPlatforms:
          supportedPlatforms.map((platform) => platform.toMap()).toList(),
      StorageKeys.codeSource: codeSource,
      StorageKeys.homepage: homepage,
      StorageKeys.supportEmail: supportEmail,
      StorageKeys.license: license,
      StorageKeys.links: links,
      StorageKeys.publishedOn: publishedOn.millisecondsSinceEpoch,
      StorageKeys.updatedOn: updatedOn.millisecondsSinceEpoch,
    }.searchable();
  }

  static bool isAppConfigValid({required Map<String, dynamic> map}) {
    return map.containsKey(StorageKeys.maintainer) &&
        map.containsKey(StorageKeys.packageID) &&
        map.containsKey(StorageKeys.name) &&
        map.containsKey(StorageKeys.shortDescription) &&
        map.containsKey(StorageKeys.icon) &&
        map.containsKey(StorageKeys.bannerImage) &&
        map.containsKey(StorageKeys.imageUrls) &&
        map.containsKey(StorageKeys.category) &&
        map.containsKey(StorageKeys.esrbRating) &&
        map.containsKey(StorageKeys.pricingModel) &&
        map.containsKey(StorageKeys.inAppPurchaseModel) &&
        map.containsKey(StorageKeys.forceLatest) &&
        map.containsKey(StorageKeys.systemRequirements) &&
        map.containsKey(StorageKeys.permissions) &&
        map.containsKey(StorageKeys.supportedLanguages) &&
        map.containsKey(StorageKeys.supportedPlatforms) &&
        map.containsKey(StorageKeys.codeSource) &&
        map.containsKey(StorageKeys.homepage) &&
        map.containsKey(StorageKeys.supportEmail) &&
        map.containsKey(StorageKeys.license) &&
        map.containsKey(StorageKeys.links);
  }

  static List<String> getMissingKeysInMap({required Map<String, dynamic> map}) {
    final expectedKeys = [
      StorageKeys.maintainer,
      StorageKeys.packageID,
      StorageKeys.name,
      StorageKeys.shortDescription,
      StorageKeys.icon,
      StorageKeys.bannerImage,
      StorageKeys.imageUrls,
      StorageKeys.category,
      StorageKeys.esrbRating,
      StorageKeys.pricingModel,
      StorageKeys.inAppPurchaseModel,
      StorageKeys.forceLatest,
      StorageKeys.systemRequirements,
      StorageKeys.permissions,
      StorageKeys.supportedLanguages,
      StorageKeys.supportedPlatforms,
      StorageKeys.codeSource,
      StorageKeys.homepage,
      StorageKeys.supportEmail,
      StorageKeys.license,
      StorageKeys.links,
    ];

    final missingKeys =
        expectedKeys.where((key) => !map.containsKey(key)).toList();

    return missingKeys;
  }
}
