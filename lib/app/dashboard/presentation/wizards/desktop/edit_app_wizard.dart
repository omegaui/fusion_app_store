import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/dashboard/domain/models/version_data.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/app/dashboard/presentation/wizards/desktop/widgets/add_image_button.dart';
import 'package:fusion_app_store/app/dashboard/presentation/wizards/desktop/widgets/add_version_button.dart';
import 'package:fusion_app_store/app/dashboard/presentation/wizards/desktop/widgets/icon_container.dart';
import 'package:fusion_app_store/app/dashboard/presentation/wizards/desktop/widgets/image_tile.dart';
import 'package:fusion_app_store/app/dashboard/presentation/wizards/desktop/widgets/upload_bundle_button.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_category.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/esrb_rating.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/in_app_purchase_model.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/permissions.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/pricing_model.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/system_requirements.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/version.dart';
import 'package:fusion_app_store/config/app_animations.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/constants/extras.dart';
import 'package:fusion_app_store/core/cloud_storage/resources.dart';
import 'package:fusion_app_store/core/cloud_storage/storage.dart';
import 'package:fusion_app_store/core/global/message_box.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EditAppWizard extends StatefulWidget {
  const EditAppWizard({
    super.key,
    required this.controller,
    required this.state,
    required this.initialAppEntity,
  });

  final DashboardPageInitializedState state;
  final DashboardPageController controller;
  final AppEntity initialAppEntity;

  @override
  State<EditAppWizard> createState() => _EditAppWizardState();

  static Future<void> open(
    DashboardPageController controller,
    DashboardPageInitializedState state,
    AppEntity initialAppEntity,
  ) async {
    await Get.dialog(
      EditAppWizard(
        controller: controller,
        state: state,
        initialAppEntity: initialAppEntity,
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
    );
  }
}

class _EditAppWizardState extends State<EditAppWizard> {
  late AppEntity appEntity;

  late TextEditingController packageIDController = TextEditingController(
      text: appEntity.packageID.isEmpty ? null : appEntity.packageID);
  late TextEditingController nameController =
      TextEditingController(text: appEntity.name);
  late TextEditingController descriptionController =
      TextEditingController(text: appEntity.shortDescription);

  Future<bool> Function() onValidate = () async {
    return true;
  };

  bool loaded = false;

  bool start = false;
  bool uploading = false;
  String message = "";

  int currentPage = 0;
  ImageProvider? activeImageProvider;
  PlatformType currentlyEditedPlatformType = PlatformType.windows;
  PlatformType currentlyEditedSystemRequirementPlatformType =
      PlatformType.windows;

  // form keys
  final basicDetailsFormKey = GlobalKey<FormState>();
  final pricingDetailsFormKey = GlobalKey<FormState>();
  final permissionDetailsFormKey = GlobalKey<FormState>();
  final systemRequirementDetailsFormKey = GlobalKey<FormState>();
  final descriptionFormKey = GlobalKey<FormState>();
  final socialDetailsFormKey = GlobalKey<FormState>();

  // data variables
  Uint8List appIconBytes = Resources.fusionAppIconBytes;
  List<Uint8List> appImagesBytes = [];
  PricingType pricingType = PricingType.free;
  TextEditingController priceController = TextEditingController(text: "15");
  TextEditingController minimumInAppPurchaseController =
      TextEditingController(text: "0");
  TextEditingController maximumInAppPurchaseController =
      TextEditingController(text: "157");
  TextEditingController permissionSearchController = TextEditingController();
  List<Permission> permissions = [];
  List<SupportedPlatform> supportedPlatforms = [];
  Map<String, VersionData> versionBundleMap = {};
  List<SystemRequirements> systemRequirements = [];

  @override
  void initState() {
    super.initState();
    appEntity = AppEntity.clone(widget.initialAppEntity);
    Future(() async {
      // loading app icon
      Future<void> loadAppIcon() async {
        appIconBytes = (await Storage.getData(path: appEntity.icon))!;
      }

      // loading app images
      Future<void> loadAppImage(url) async {
        appImagesBytes.add((await Storage.getData(path: url))!);
      }

      final futures = <Future>[];
      futures.add(loadAppIcon());
      for (final imageUrl in appEntity.imageUrls) {
        futures.add(loadAppImage(imageUrl));
      }

      // loading all at once
      await Future.wait(futures);

      // preloading first image
      if (appImagesBytes.isNotEmpty) {
        final bytes = appImagesBytes.first;
        activeImageProvider = MemoryImage(Uint8List.fromList(bytes));
      }

      // putting pricing model
      if (appEntity.pricingModel.type == PricingType.free) {
        priceController.text = "0";
      } else {
        pricingType = PricingType.paid;
        priceController.text = appEntity.pricingModel.price.toString();

        // putting in-app purchase model
        minimumInAppPurchaseController.text =
            appEntity.inAppPurchaseModel.min.toString();
        maximumInAppPurchaseController.text =
            appEntity.inAppPurchaseModel.max.toString();
      }

      // putting permissions
      permissions.addAll(appEntity.permissions.permissions);

      // putting supported platforms
      supportedPlatforms.addAll(appEntity.supportedPlatforms);
      systemRequirements.addAll(appEntity.systemRequirements);

      // putting bundle map
      for (final platform in supportedPlatforms) {
        for (final version in platform.versions) {
          versionBundleMap[version.name] =
              VersionData(name: version.name, bytes: Uint8List.fromList([0]))
                ..isUploaded = true;
        }
      }

      // refreshing UI
      loaded = true;
      rebuild();
    });
  }

  Widget _getPage() {
    if (currentPage == 0) {
      return _startPage();
    } else if (currentPage == 1) {
      return _imagesPage();
    } else if (currentPage == 2) {
      return _pricingPage();
    } else if (currentPage == 3) {
      return _permissionsPage();
    } else if (currentPage == 4) {
      return _platformPage();
    } else if (currentPage == 5) {
      return _systemRequirementsPage();
    } else if (currentPage == 6) {
      return _descriptionPage();
    }
    return _socialPage();
  }

  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  void rebuildPostFrame(String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          this.message = message;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          child: start
              ? _uploadView()
              : Container(
                  width: 800,
                  height: 500,
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 48,
                      ),
                    ],
                  ),
                  child: !loaded
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircularProgressIndicator(
                                color: Colors.pink,
                              ),
                              const Gap(10),
                              Text(
                                "Fetching App",
                                style: AppTheme.fontSize(16).makeMedium(),
                              ),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: ClipRect(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(-1, 0),
                                          end: const Offset(0, 0),
                                        ).animate(animation),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: _getPage(),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Wrap(
                                  spacing: 10,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        if (await onValidate()) {
                                          if (currentPage > 0) {
                                            currentPage--;
                                            rebuild();
                                          }
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: currentPage == 0
                                            ? Colors.grey
                                            : Colors.blue,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      child: Text(
                                        'Previous',
                                        style: AppTheme.fontSize(14)
                                            .makeMedium()
                                            .withColor(Colors.white),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (currentPage == 7) {
                                          start = true;
                                          rebuild();
                                          startUpload();
                                        } else if (await onValidate()) {
                                          if (currentPage < 7) {
                                            currentPage++;
                                            rebuild();
                                          }
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: currentPage == 7
                                            ? Colors.green
                                            : Colors.blue,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      child: Text(
                                        currentPage == 7 ? 'Save' : 'Next',
                                        style: AppTheme.fontSize(14)
                                            .makeMedium()
                                            .withColor(Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Wrap(
                                  spacing: 10,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: Get.back,
                                      icon: Icon(
                                        Icons.arrow_back_sharp,
                                        color: AppTheme.foreground,
                                      ),
                                    ),
                                    Text(
                                      'Edit App',
                                      style: AppTheme.fontSize(16).makeMedium(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
        ),
      ),
    );
  }

  void startUpload() async {
    // clearing old configs
    appEntity.imageUrls.clear();
    appEntity.supportedPlatforms.clear();
    appEntity.systemRequirements.clear();

    // we'll start by uploading the app icon
    rebuildPostFrame("Uploading App Icon ...");

    final iconStorageInfo = Storage.toIconStorage(appEntity);

    await Storage.uploadBytes(
        bytes: appIconBytes, storageInfo: iconStorageInfo);

    appEntity = AppEntity.clone(
      appEntity,
      icon: await Storage.getDownloadUrl(path: iconStorageInfo.path),
    );

    // next, we'll upload the images
    for (int i = 0; i < appImagesBytes.length; i++) {
      rebuildPostFrame(
          "Uploading App Images (${i + 1} / ${appImagesBytes.length})");

      final imageBytes = appImagesBytes[i];
      final imageStorage = Storage.toImageStorage(
        appEntity,
        "image-$i.png",
      );

      await Storage.uploadBytes(bytes: imageBytes, storageInfo: imageStorage);

      appEntity.imageUrls.add(
        await Storage.getDownloadUrl(path: imageStorage.path),
      );
    }

    // next, we'll upload the bundles
    for (final platform in supportedPlatforms) {
      for (final version in platform.versions) {
        final data = versionBundleMap[version.name];
        if (data != null && !data.isUploaded) {
          rebuildPostFrame(
              "Uploading ${platform.type.name.capitalize!} bundle: ${data.name}");

          final bundleStorage =
              Storage.toBundleStorage(appEntity, platform.type, data.name);

          version.bundleUrl = bundleStorage.path;

          await Storage.uploadBytes(
              bytes: data.bytes, storageInfo: bundleStorage);
        }
      }
    }

    appEntity.supportedPlatforms.addAll(supportedPlatforms);

    // now, let's set the other fields
    rebuildPostFrame("Editing App");
    appEntity.systemRequirements.addAll(systemRequirements);
    appEntity = AppEntity.clone(
      appEntity,
      permissions: Permissions(permissions: permissions),
    );
    appEntity = AppEntity.clone(
      appEntity,
      pricingModel: PricingModel(
        type: pricingType,
        price: double.parse(priceController.text),
      ),
    );
    appEntity = AppEntity.clone(
      appEntity,
      inAppPurchaseModel: InAppPurchaseModel(
        min: double.parse(minimumInAppPurchaseController.text),
        max: double.parse(maximumInAppPurchaseController.text),
      ),
      updatedOn: DateTime.now(),
    );
    widget.controller.uploadApp(appEntity);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pop(context);
      },
    );
  }

  Widget _uploadView() {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 48,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.pink,
            ),
            const Gap(10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTheme.fontSize(16).makeMedium(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _startPage() {
    onValidate = () async {
      appEntity = AppEntity.clone(
        appEntity,
        packageID: packageIDController.text,
        name: nameController.text,
        shortDescription: descriptionController.text,
      );
      return basicDetailsFormKey.currentState!.validate();
    };
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
      ),
      child: Form(
        key: basicDetailsFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 20,
                          ),
                          const Gap(6),
                          Text(
                            'App Icon',
                            style: AppTheme.fontSize(20).makeBold(),
                          ),
                        ],
                      ),
                      const Gap(10),
                      IconContainer(
                        bytes: appIconBytes,
                        onChanged: (bytes) {
                          appIconBytes = bytes;
                          rebuild();
                        },
                      ),
                    ],
                  ),
                  const Gap(10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 20,
                          ),
                          const Gap(6),
                          Text(
                            'Package ID',
                            style: AppTheme.fontSize(20).makeBold(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: SizedBox(
                          width: 300,
                          child: Tooltip(
                            message: "You cannot change the package ID",
                            child: _textField(
                              controller: packageIDController,
                              hintText: 'e.g: shopping-app',
                              enabled: false,
                              style: AppTheme.fontSize(16).makeMedium(),
                              validator: (value) {
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 20,
                          ),
                          const Gap(6),
                          Text(
                            'Your App\'s Name',
                            style: AppTheme.fontSize(20).makeBold(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: SizedBox(
                          width: 300,
                          child: _textField(
                            controller: nameController,
                            hintText: 'e.g: Shopping App',
                            style: AppTheme.fontSize(16).makeMedium(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 20,
                  ),
                  const Gap(6),
                  Text(
                    'Short Description',
                    style: AppTheme.fontSize(20).makeBold(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: SizedBox(
                  width: 700,
                  child: _textField(
                    controller: descriptionController,
                    hintText:
                        'e.g: An engaging shopping application for fashion influencers.',
                    style: AppTheme.fontSize(16).makeMedium(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 20,
                  ),
                  const Gap(6),
                  Text(
                    'Category',
                    style: AppTheme.fontSize(20).makeBold(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 26.0, top: 10),
                child: SizedBox(
                  width: 700,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...AppCategory.values.map((e) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              appEntity =
                                  AppEntity.clone(appEntity, category: e);
                            });
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: appEntity.category == e
                                    ? Colors.blue
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                parseAppCategory(e),
                                style: AppTheme.fontSize(14)
                                    .makeMedium()
                                    .withColor(appEntity.category == e
                                        ? Colors.white
                                        : AppTheme.foreground),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagesPage() {
    onValidate = () async {
      return true;
    };
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          if (appImagesBytes.isEmpty) ...[
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    AppAnimations.uploadImages,
                    width: 400,
                  ),
                  Text(
                    'Upload a banner image for your app\nand add some screenshots to showcase',
                    textAlign: TextAlign.center,
                    style: AppTheme.fontSize(14)
                        .makeMedium()
                        .withColor(Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
          if (appImagesBytes.isNotEmpty) ...[
            if (activeImageProvider == null) ...[
              const Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.pink,
                  )),
                ),
              ),
            ],
            if (activeImageProvider != null) ...[
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          body: InteractiveViewer(
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 16,
                                    )
                                  ],
                                ),
                                child: Image(
                                  image: activeImageProvider!,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ));
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SizedBox(
                      height: 300,
                      child: Image(
                        image: activeImageProvider!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 400,
                height: 85,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 10,
                    runAlignment: WrapAlignment.center,
                    children: [
                      ...appImagesBytes.map((e) {
                        return ImageTile(
                          bytes: e,
                          onPressed: (image) {
                            activeImageProvider = image;
                            rebuild();
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // AddBannerButton(
                //   onChanged: (url) {},
                //   controller: widget.controller,
                // ),
                // const Gap(20),
                AddImageButton(
                  onAdded: (files) {
                    _refreshImage(files);
                    rebuild();
                  },
                  controller: widget.controller,
                  state: widget.state,
                  packageID: appEntity.packageID,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _refreshImage(List<PlatformFile> files) {
    Future(
      () async {
        for (final file in files) {
          final bytes = file.bytes;
          activeImageProvider = MemoryImage(Uint8List.fromList(bytes!));
          appImagesBytes.add(bytes);
        }
        rebuild();
      },
    );
  }

  Widget _pricingPage() {
    onValidate = () async {
      return pricingDetailsFormKey.currentState!.validate();
    };
    return Form(
      key: pricingDetailsFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 20,
                ),
                const Gap(6),
                Text(
                  'Pricing',
                  style: AppTheme.fontSize(20).makeBold(),
                ),
                const Gap(10),
                Wrap(
                  spacing: 10,
                  children: PricingType.values.map(
                    (e) {
                      return GestureDetector(
                        onTap: () {
                          pricingType = e;
                          rebuild();
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color:
                                  pricingType == e ? Colors.blue : Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${e.name.capitalize}',
                              style: AppTheme.fontSize(16)
                                  .makeMedium()
                                  .withColor(Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
            const Gap(10),
            if (pricingType == PricingType.free) ...[
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  "Your app will be shown as a free app on the store,\nIf your app contains in app pricing plans please mark it as a paid app instead.",
                  style: AppTheme.fontSize(14).makeMedium(),
                ),
              ),
            ],
            if (pricingType == PricingType.paid) ...[
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  "Your app should have its own payment processing,\nFusion does not provides any payment procedure for any paid app.",
                  style: AppTheme.fontSize(14).makeMedium(),
                ),
              ),
              const Gap(10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 20,
                  ),
                  const Gap(6),
                  Text(
                    'Specify the price amount in (\$)',
                    style: AppTheme.fontSize(20).makeBold(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  "For apps with subscription plans, you can leave this field empty.",
                  style: AppTheme.fontSize(14).makeMedium(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: _textField(
                  controller: priceController,
                  validator: (value) {
                    if (num.tryParse(value ?? "NA") == null) {
                      return "* Requires a number";
                    }
                    return null;
                  },
                  prefixText: "\$ ",
                  style: AppTheme.fontSize(16).makeMedium(),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 20,
                  ),
                  const Gap(6),
                  Text(
                    'Specify the in app purchases amount in (\$)',
                    style: AppTheme.fontSize(20).makeBold(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: SizedBox(
                  width: 200,
                  child: _textField(
                    controller: minimumInAppPurchaseController,
                    validator: (value) {
                      if (num.tryParse(value ?? "NA") == null) {
                        return "* Requires a number";
                      }
                      return null;
                    },
                    prefixText: "\$ ",
                    labelText: "Minimum",
                    style: AppTheme.fontSize(16).makeMedium(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: SizedBox(
                  width: 200,
                  child: _textField(
                    controller: maximumInAppPurchaseController,
                    validator: (value) {
                      if (num.tryParse(value ?? "NA") == null) {
                        return "* Requires a number";
                      }
                      return null;
                    },
                    prefixText: "\$ ",
                    labelText: "Maximum",
                    style: AppTheme.fontSize(16).makeMedium(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  "Leave these field empty, if your app does not have any in app purchases.",
                  style: AppTheme.fontSize(14).makeMedium(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _permissionsPage() {
    onValidate = () async {
      return permissionDetailsFormKey.currentState!.validate();
    };
    return Form(
      key: permissionDetailsFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 20,
                ),
                const Gap(6),
                Text(
                  'App Permissions',
                  style: AppTheme.fontSize(20).makeBold(),
                ),
                const Gap(10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26.0),
              child: Text(
                "Fill in the permissions required by your app to run.",
                style: AppTheme.fontSize(14).makeMedium(),
              ),
            ),
            const Gap(10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 20,
                ),
                const Gap(6),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: Autocomplete<PermissionType>(
                    optionsBuilder: (textEditingValue) {
                      return PermissionType.values
                          .where((e) => e.name
                              .isCaseInsensitiveContains(textEditingValue.text))
                          .toList();
                    },
                    displayStringForOption: (option) {
                      return option.name.capitalize!;
                    },
                    fieldViewBuilder: (
                      context,
                      textEditingController,
                      focusNode,
                      onFieldSubmitted,
                    ) {
                      return _textField(
                        focusNode: focusNode,
                        controller: textEditingController,
                        style: AppTheme.fontSize(14).makeMedium(),
                        validator: (value) {
                          return null;
                        },
                        hintText: "Search and add Permissions ...",
                        onFieldSubmitted: (value) => onFieldSubmitted(),
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          color: Colors.white,
                          child: Container(
                            width: 300,
                            height: 200,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.2),
                                  blurRadius: 16,
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () =>
                                      onSelected(options.elementAt(index)),
                                  title: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        getPermissionIcon(
                                            options.elementAt(index)),
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      const Gap(6),
                                      Text(
                                        options
                                            .elementAt(index)
                                            .name
                                            .capitalize!,
                                        style: AppTheme.fontSize(13)
                                            .makeMedium()
                                            .withColor(Colors.white),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    onSelected: (option) {
                      if (permissions.any((e) => e.type == option)) {
                        return;
                      }
                      permissions
                          .add(Permission(type: option, description: []));
                      rebuild();
                    },
                  ),
                ),
              ],
            ),
            const Gap(10),
            Expanded(
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                      ),
                      Wrap(
                        children: [
                          ...permissions.map((e) => _permissionCard(e))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _permissionCard(Permission permission) {
    final controller =
        TextEditingController(text: permission.description.join('\n'));
    controller.addListener(() {
      permission.description = controller.text.split('\n');
    });
    return Container(
      width: 210,
      height: 120,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                getPermissionIcon(permission.type),
                size: 20,
              ),
              const Gap(6),
              Text(
                permission.type.name.capitalize!,
                style: AppTheme.fontSize(14).makeMedium(),
              ),
            ],
          ),
          const Gap(6),
          SizedBox(
            width: 200,
            height: 50,
            child: _textField(
              style: AppTheme.fontSize(12).makeMedium(),
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "*Required";
                }
                return null;
              },
              hintText: "Description",
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _platformPage() {
    final supportedPlatform =
        supportedPlatforms.where((e) => currentlyEditedPlatformType == e.type);
    final doesAppSupportsPlatform = supportedPlatform.isNotEmpty;
    final versions = <Version>[];
    if (doesAppSupportsPlatform) {
      versions.addAll(supportedPlatform.first.versions);
    }
    onValidate = () async {
      if (supportedPlatforms.isEmpty) {
        showMessage(
            title: "Platform Data is missing",
            description: "Please add at least one platform.");
      }
      return supportedPlatforms.isNotEmpty;
    };
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 50,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 20,
                    ),
                    const Gap(6),
                    Text(
                      'Target Platforms',
                      style: AppTheme.fontSize(20).makeBold(),
                    ),
                  ],
                ),
                const Gap(10),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...PlatformType.values.map(
                              (e) {
                                return GestureDetector(
                                  onTap: () {
                                    currentlyEditedPlatformType = e;
                                    rebuild();
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      curve: Curves.easeIn,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: currentlyEditedPlatformType == e
                                            ? Colors.amber.shade100
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox.square(
                                            dimension: 32,
                                            child: Image.asset(
                                              getPlatformIcon(e),
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                            e.name.capitalize!,
                                            style: AppTheme.fontSize(14)
                                                .makeMedium(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                        thickness: 2,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            if (!doesAppSupportsPlatform) ...[
                              Lottie.asset(
                                AppAnimations.space,
                                width: 200,
                              ),
                              const Gap(20),
                              Text(
                                "Use the (+) button to \ncreate a version for ${currentlyEditedPlatformType.name.capitalize}.",
                                textAlign: TextAlign.center,
                                style: AppTheme.fontSize(13).makeMedium(),
                              ),
                            ],
                            if (doesAppSupportsPlatform) ...[
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      ...versions.map(
                                        (e) => _versionCard(e),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AddVersionButton(
              onPressed: () async {
                final version = await _versionDialog(
                    version: Version(
                  name: "",
                  enabled: true,
                  latest: true,
                  stable: true,
                  beta: false,
                  bundleUrl: "",
                  downloadSize: "",
                ));
                if (version != null) {
                  if (doesAppSupportsPlatform) {
                    supportedPlatforms
                        .firstWhere(
                            (e) => e.type == currentlyEditedPlatformType)
                        .versions
                        .add(version);
                  } else {
                    supportedPlatforms.add(
                      SupportedPlatform(
                        type: currentlyEditedPlatformType,
                        os: [],
                        targetVersions: [],
                        dependencies: [],
                        versions: [version],
                      ),
                    );
                  }
                  rebuild();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Version?> _versionDialog({required Version version}) async {
    final versionNumberController = TextEditingController(text: version.name);
    versionNumberController.addListener(() {
      version = version.copyWith(name: versionNumberController.text);
    });
    final result = await Get.dialog<Version>(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: StatefulBuilder(builder: (context, setModalState) {
          void rebuild() {
            if (mounted) {
              setModalState(() {});
            }
          }

          return Center(
            child: Container(
              width: 400,
              height: 250,
              decoration: BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 48,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          IconButton(
                            onPressed: Get.back,
                            icon: Icon(
                              Icons.arrow_back_sharp,
                              color: AppTheme.foreground,
                            ),
                          ),
                          Text(
                            'Create Version',
                            style: AppTheme.fontSize(16).makeMedium(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (currentlyEditedPlatformType != PlatformType.web) ...[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: UploadBundleButton(
                          onPressed: () async {
                            if (version.name.isEmpty) {
                              showMessage(
                                title: "Bundle Upload",
                                description:
                                    "Please provide the version number.",
                                type: MessageBoxType.error,
                              );
                              return;
                            }
                            await Storage.pickFiles(
                              allowedExtensions:
                                  getPlatformExecutableExtensions(
                                type: currentlyEditedPlatformType,
                              ),
                              fileType: FileType.custom,
                              onDone: (files) {
                                if (files.isNotEmpty) {
                                  final file = files.first;
                                  versionBundleMap[version.name] = VersionData(
                                      name: file.name, bytes: file.bytes!);
                                  rebuild();
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  if (currentlyEditedPlatformType == PlatformType.web ||
                      versionBundleMap.containsKey(version.name)) ...[
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: TextButton(
                          onPressed: () async {
                            Get.back(result: version);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                currentPage == 0 ? Colors.grey : Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            'Save',
                            style: AppTheme.fontSize(14)
                                .makeMedium()
                                .withColor(Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(50),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Version: ",
                                style: AppTheme.fontSize(14).makeMedium(),
                              ),
                              const Gap(10),
                              SizedBox(
                                width: 200,
                                child: _textField(
                                  controller: versionNumberController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "*Required, e.g: 1.2.5";
                                    }
                                    return null;
                                  },
                                  hintText: "Version Number",
                                  style: AppTheme.fontSize(14).makeMedium(),
                                ),
                              ),
                            ],
                          ),
                          if (currentlyEditedPlatformType !=
                              PlatformType.web) ...[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Tag:",
                                  style: AppTheme.fontSize(14).makeMedium(),
                                ),
                                CupertinoCheckbox(
                                  value: version.latest,
                                  onChanged: (value) {
                                    version = version.copyWith(latest: value);
                                    rebuild();
                                  },
                                ),
                                const Gap(4),
                                Text(
                                  version.latest
                                      ? (version.stable
                                          ? "Latest"
                                          : "Pre-release")
                                      : "None",
                                  style: AppTheme.fontSize(14).makeMedium(),
                                ),
                              ],
                            ),
                          ],
                          if (currentlyEditedPlatformType !=
                              PlatformType.web) ...[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Status:",
                                  style: AppTheme.fontSize(14).makeMedium(),
                                ),
                                CupertinoCheckbox(
                                  value: version.stable,
                                  onChanged: (value) {
                                    version = version.copyWith(
                                        stable: value, beta: !value!);
                                    rebuild();
                                  },
                                ),
                                const Gap(4),
                                Text(
                                  "Stable",
                                  style: AppTheme.fontSize(14).makeMedium(),
                                ),
                                CupertinoCheckbox(
                                  value: !version.stable,
                                  onChanged: (value) {
                                    version = version.copyWith(
                                        stable: !value!, beta: value);
                                    rebuild();
                                  },
                                ),
                                const Gap(4),
                                Text(
                                  "Beta",
                                  style: AppTheme.fontSize(14).makeMedium(),
                                ),
                              ],
                            ),
                          ],
                          if (versionBundleMap.containsKey(version.name)) ...[
                            const Gap(10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Bundle Added Successfully",
                                  style: AppTheme.fontSize(14).makeBold(),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      barrierColor: Colors.transparent,
      barrierDismissible: false,
    );
    return result;
  }

  Widget _versionCard(Version version) {
    return Container(
      width: 210,
      height: 120,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                version.name,
                style: AppTheme.fontSize(14).makeMedium(),
              ),
              const Gap(10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final updatedVersion =
                            await _versionDialog(version: version);
                        if (updatedVersion != null) {
                          final currentPlatform = supportedPlatforms.firstWhere(
                              (e) => e.type == currentlyEditedPlatformType);
                          int index = currentPlatform.versions.indexOf(version);
                          currentPlatform.versions.removeAt(index);
                          currentPlatform.versions
                              .insert(index, updatedVersion);
                          final originalNumber = version.name;
                          final currentNumber = updatedVersion.name;
                          final data = versionBundleMap[originalNumber];
                          if (data != null) {
                            versionBundleMap[currentNumber] = data;
                            versionBundleMap.remove(originalNumber);
                          }
                          rebuild();
                        }
                      },
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const Gap(6),
                    IconButton(
                      onPressed: () {
                        final currentPlatform = supportedPlatforms.firstWhere(
                            (e) => e.type == currentlyEditedPlatformType);
                        currentPlatform.versions.remove(version);
                        rebuild();
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Colors.red.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (version.latest) ...[
                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue.shade300, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      version.stable ? "latest" : "pre-release",
                      style: AppTheme.fontSize(13).makeMedium(),
                    ),
                  ),
                ),
              ],
              Container(
                margin: const EdgeInsets.all(8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: version.stable
                      ? Colors.green.shade100
                      : Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: version.stable
                          ? Colors.green.shade300
                          : Colors.amber.shade300,
                      width: 2),
                ),
                child: Center(
                  child: Text(
                    version.stable ? "stable" : "beta",
                    style: AppTheme.fontSize(13).makeMedium(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _systemRequirementsPage() {
    onValidate = () async {
      return systemRequirementDetailsFormKey.currentState!.validate();
    };

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: systemRequirementDetailsFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 50,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.keyboard_arrow_right_outlined,
                        size: 20,
                      ),
                      const Gap(6),
                      Text(
                        'System Requirements',
                        style: AppTheme.fontSize(20).makeBold(),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 27.0),
                    child: Text(
                      "Provide the minimum and recommended system specs for your app.",
                      style: AppTheme.fontSize(14).makeMedium(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: systemRequirements
                        .map((e) => _requirementCard(requirements: e))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _requirementCard({required SystemRequirements requirements}) {
    final cpuController = TextEditingController(text: requirements.cpu);
    cpuController.addListener(() {
      requirements.cpu = cpuController.text;
    });
    final ramController = TextEditingController(text: requirements.ram);
    ramController.addListener(() {
      requirements.ram = ramController.text;
    });
    final architectureController =
        TextEditingController(text: requirements.architecture);
    architectureController.addListener(() {
      requirements.architecture = architectureController.text;
    });
    return Container(
      width: 300,
      height: 300,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            requirements.type.name.capitalize!,
            style: AppTheme.fontSize(16).makeBold(),
          ),
          const Gap(10),
          _textField(
            controller: cpuController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please provide cpu details.";
              }
              return null;
            },
            labelText: "CPU Details",
            hintText: "e.g. 1.8GHz Intel or AMD Processor",
            style: AppTheme.fontSize(14),
          ),
          _textField(
            controller: ramController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please provide RAM details.";
              }
              return null;
            },
            labelText: "RAM Details",
            hintText: "e.g. 8GB",
            style: AppTheme.fontSize(14),
          ),
          _textField(
            controller: architectureController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please provide Architecture details.";
              }
              return null;
            },
            labelText: "Architecture Details",
            hintText: "e.g. x86_64",
            style: AppTheme.fontSize(14),
          ),
        ],
      ),
    );
  }

  Widget _descriptionPage() {
    final descriptionController =
        TextEditingController(text: appEntity.description.join("\n"));
    descriptionController.addListener(() {
      appEntity.description.clear();
      appEntity.description.addAll(descriptionController.text.split("\n"));
    });

    onValidate = () async {
      return descriptionFormKey.currentState!.validate();
    };
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: descriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 20,
                ),
                const Gap(6),
                Text(
                  'App Description',
                  style: AppTheme.fontSize(20).makeBold(),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                child: _textField(
                  controller: descriptionController,
                  maxLines: 1000,
                  style: AppTheme.fontSize(13).makeMedium(),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 100) {
                      return "*Please Provide a description of your app at least 100 chars long.";
                    }
                    return null;
                  },
                  hintText:
                      "Write a good description of your app to attract users ...",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialPage() {
    final homePageController = TextEditingController(text: appEntity.homepage);
    homePageController.addListener(() {
      appEntity = AppEntity.clone(appEntity, homepage: homePageController.text);
    });
    onValidate = () async {
      return socialDetailsFormKey.currentState!.validate();
    };
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: socialDetailsFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 20,
                ),
                const Gap(6),
                Text(
                  'ESRB Rating',
                  style: AppTheme.fontSize(20).makeBold(),
                ),
              ],
            ),
            const Gap(10),
            Wrap(
              spacing: 10,
              children: [
                ...EsrbRating.values.map(
                  (e) => GestureDetector(
                    onTap: () {
                      appEntity = AppEntity.clone(appEntity, esrbRating: e);
                      rebuild();
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                        message: e.name.capitalize!,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeIn,
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: appEntity.esrbRating == e
                                ? Colors.blue.shade100
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: appEntity.esrbRating == e
                                  ? Colors.blue.shade300
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Image.asset(
                              getEsrbRatingIcon(e),
                              width: 48,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 20,
                ),
                const Gap(6),
                Text(
                  'Home Page or Author/App Website',
                  style: AppTheme.fontSize(20).makeBold(),
                ),
              ],
            ),
            _textField(
              controller: homePageController,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    Uri.tryParse(value) == null) {
                  return "*Please provide a valid url.";
                }
                return null;
              },
              hintText: "https://${appEntity.packageID}.io",
              style: AppTheme.fontSize(14).makeMedium(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    String? hintText,
    String? labelText,
    String? prefixText,
    String? errorText,
    TextStyle? style,
    required FormFieldValidator<String> validator,
    void Function(String?)? onFieldSubmitted,
    FocusNode? focusNode,
    int? maxLines,
    bool enabled = true,
  }) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      style: style,
      validator: validator,
      maxLines: maxLines,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        prefixText: prefixText,
        hintText: hintText,
        labelText: labelText,
        labelStyle: AppTheme.fontSize(14).makeMedium(),
        errorStyle: AppTheme.fontSize(13).makeMedium().withColor(Colors.red),
        errorText: errorText,
      ),
    );
  }
}
