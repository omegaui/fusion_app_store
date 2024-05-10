import 'dart:math';

import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/esrb_rating.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/permissions.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/version.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/cache_storage/cache.dart';
import 'package:fusion_app_store/core/cloud_storage/global.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';
import 'package:fusion_app_store/core/cloud_storage/refs.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

Widget buildImageList(List<String> images, double spacing, {iconSize}) {
  return Wrap(
    spacing: spacing,
    children: images
        .map(
          (e) => Image.asset(
            e,
            width: iconSize ?? 70,
            height: iconSize ?? 70,
            filterQuality: FilterQuality.high,
          ),
        )
        .toList(),
  );
}

Widget createText(String text,
    {List<String>? boldWords, required double fontSize}) {
  List<Text> texts = [];
  final words = text.split(' ');
  String sep = ' ';
  for (int i = 0; i < words.length; i++) {
    if (i == words.length - 1) {
      sep = '';
    }
    if ((boldWords?.contains(words[i]) ?? false)) {
      texts.add(Text(
        words[i] + sep,
        style:
            HomePageTheme.fontSize(fontSize).makeBold().withColor(Colors.blue),
      ));
    } else {
      texts.add(Text(
        words[i] + sep,
        style: HomePageTheme.fontSize(fontSize),
      ));
    }
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: texts,
  );
}

void gotoErrorPage(message, stackTrace) {
  Get.find<RouteService>().navigateTo(
      page: RouteService.errorPage, arguments: [message, stackTrace]);
}

bool isValidUsername(String username) {
  // Check if the username is in lowercase
  if (username != username.toLowerCase()) {
    return false;
  }

  // Check if no symbols are allowed
  if (username.contains(RegExp(r'[^\w]'))) {
    return false;
  }

  // Check if no spaces are allowed
  if (username.contains(RegExp(r'\s'))) {
    return false;
  }

  // Check if only lowercase letters and digits are allowed
  if (!RegExp(r'^[a-z0-9]+$').hasMatch(username)) {
    return false;
  }

  // If all conditions are met, the username is valid
  return true;
}

bool isValidPassword(String password) {
  // Check if it contains lowercase and uppercase letters
  if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])').hasMatch(password)) {
    return false;
  }

  // Check if it contains at least one digit
  if (!RegExp(r'^(?=.*\d)').hasMatch(password)) {
    return false;
  }

  // Check if it contains at least one symbol
  if (!RegExp(r'^(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-])').hasMatch(password)) {
    return false;
  }

  // Check if no spaces are allowed
  if (password.contains(RegExp(r'\s'))) {
    return false;
  }

  // If all conditions are met, the password is valid
  return true;
}

String encrypt(String text) {
  return BCrypt.hashpw(text, BCrypt.gensalt());
}

String getRandomBio() {
  List<String> bios = [
    "Tech enthusiast | Coffee addict ☕",
    "Coding and coffee fuel my day.",
    "Chef in training | Foodie for life.",
    "Optimist with a passion for smiles.",
    "Jazz lover | Night sky admirer.",
    "Bookworm and proud of it.",
    "Chasing fitness goals every day.",
    "Simplicity is the ultimate sophistication.",
    "Explorer of both virtual and real worlds.",
    "Minimalist in a world of noise."
  ];

  Random random = Random();
  int index = random.nextInt(bios.length);

  return bios[index];
}

String greet() {
  var now = DateTime.now();
  if (now.hour >= 3 && now.hour < 12) {
    return "Good Morning";
  } else if (now.hour >= 12 && now.hour < 17) {
    return "Good Afternoon";
  } else if (now.hour >= 17 && now.hour < 20) {
    return "Good Evening";
  } else {
    return "Hi";
  }
}

String getEsrbRatingIcon(EsrbRating rating) {
  switch (rating) {
    case EsrbRating.pending:
      return AppIcons.pending;
    case EsrbRating.mature:
      return AppIcons.mature;
    case EsrbRating.teen:
      return AppIcons.teen;
    case EsrbRating.adultsOnly:
      return AppIcons.adultsOnly;
    case EsrbRating.everyone:
      return AppIcons.everyone;
    case EsrbRating.everyone10plus:
      return AppIcons.everyone10plus;
  }
}

IconData getPermissionIcon(PermissionType type) {
  switch (type) {
    case PermissionType.location:
      return Icons.location_on_rounded;
    case PermissionType.storage:
      return Icons.storage_rounded;
    case PermissionType.media:
      return Icons.music_note_rounded;
    case PermissionType.network:
      return Icons.network_cell_rounded;
    case PermissionType.internet:
      return Icons.wifi_rounded;
    case PermissionType.wifi:
      return Icons.wifi_rounded;
    case PermissionType.microphone:
      return Icons.multitrack_audio_rounded;
    case PermissionType.camera:
      return Icons.camera_rounded;
    case PermissionType.contacts:
      return Icons.contacts_rounded;
    case PermissionType.calendar:
      return Icons.calendar_month_rounded;
    case PermissionType.photos:
      return Icons.photo_rounded;
    case PermissionType.sms:
      return Icons.sms_rounded;
    case PermissionType.bluetooth:
      return Icons.bluetooth_connected_rounded;
    case PermissionType.notification:
      return Icons.notifications_rounded;
  }
}

Version getLatestVersion(AppEntity appEntity) {
  final platforms = appEntity.supportedPlatforms;
  final versions = platforms
      .map((e) =>
          e.versions.firstWhereOrNull((element) => element.latest) ??
          e.versions[0])
      .toList();
  final latest =
      versions.firstWhereOrNull((element) => element.latest) ?? versions[0];
  return latest;
}

String getPlatformIcon(PlatformType type) {
  switch (type) {
    case PlatformType.windows:
      return AppIcons.windows;
    case PlatformType.macos:
      return AppIcons.mac;
    case PlatformType.linux:
      return AppIcons.linux;
    case PlatformType.android:
      return AppIcons.android;
    case PlatformType.web:
      return AppIcons.web;
  }
}

Future<void> cacheDominantColor(key, url) async {
  final palette = await PaletteGenerator.fromImageProvider(
    NetworkImage(url),
    maximumColorCount: 10,
  );
  if (palette.dominantColor != null) {
    final primaryColor = palette.dominantColor!.color;
    AppCache.put(
      key: key,
      value: primaryColor,
    );
  }
}

Future<void> preloadImage({required String url}) async {
  await preloadImages(urls: [url]);
}

Future<void> preloadImages({required List<String> urls}) async {
  final futures = <Future>[];
  for (final url in urls) {
    futures.add(precacheImage(NetworkImage(url), Get.context!));
  }
  await Future.wait(futures);
}

String toText(Address address) {
  StringBuffer text = StringBuffer();

  if (address.streetNumber != null) {
    text.write('${address.streetNumber}, ');
  }

  if (address.streetAddress != null) {
    text.write('${address.streetAddress}, ');
  }

  if (address.city != null) {
    text.write('${address.city}, ');
  }

  if (address.region != null) {
    text.write('${address.region}, ');
  }

  if (address.countryName != null) {
    text.write('${address.countryName}, ');
  }

  if (address.postal != null) {
    text.write('${address.postal}, ');
  }

  final result = text.toString();
  return result.substring(0, result.length - 2);
}

bool isUserProfileComplete(UserEntity userEntity) {
  return userEntity.website.isNotEmpty &&
      userEntity.address.isNotEmpty &&
      userEntity.privacyPolicy.isNotEmpty &&
      userEntity.termsAndConditions.isNotEmpty;
}

Future<bool> checkUserSubscription() async {
  final db = Get.find<FusionDatabase>();
  final user = (await db.getUserByEmail(GlobalFirebaseUtils.getCurrentUserLoginEmail()))!;
  final userDoc = await Refs.premiumUsers.where(StorageKeys.username, isEqualTo: user.username).get();
  if(userDoc.docs.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
