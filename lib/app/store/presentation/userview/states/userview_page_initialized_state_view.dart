import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/presentation/store/widgets/store_app_card.dart';
import 'package:fusion_app_store/app/store/presentation/userview/userview_page_controller.dart';
import 'package:fusion_app_store/app/store/presentation/userview/userview_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/presentation/userview/widgets/follow_button.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class UserViewPageInitializedStateView extends StatefulWidget {
  const UserViewPageInitializedStateView({
    super.key,
    required this.controller,
    required this.state,
  });

  final UserViewPageController controller;
  final UserViewPageInitializedState state;

  @override
  State<UserViewPageInitializedStateView> createState() =>
      _UserViewPageInitializedStateViewState();
}

class _UserViewPageInitializedStateViewState
    extends State<UserViewPageInitializedStateView> {
  List<Color> gradientColors = [
    Colors.blue,
    Colors.indigo,
  ];

  void rebuild() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: MediaQuery.sizeOf(context).width),
            SizedBox(
              width: 1200,
              height: 460,
              child: Stack(
                children: [
                  Align(
                    child: Container(
                      width: 1200,
                      height: 320,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: gradientColors[0],
                                width: 4,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                            ),
                            child: Center(
                              child: Image.network(
                                widget.state.user.avatarUrl,
                                width: 120,
                              ),
                            ),
                          ),
                          const Gap(20),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "@${widget.state.user.username}",
                                style:
                                    AppTheme.fontSize(32).makeMedium().useSen(),
                              ),
                              Text(
                                widget.state.user.bio,
                                style:
                                    AppTheme.fontSize(16).makeMedium().useSen(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90.0, right: 20),
                      child: FollowButton(
                        color: gradientColors[0],
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 660),
                const Gap(10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    Text(
                      widget.state.user.address,
                      style: AppTheme.fontSize(15).makeMedium(),
                    ),
                  ],
                ),
                const Gap(10),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _genLine(0, "followers"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5),
                        child: VerticalDivider(
                          thickness: 2,
                          width: 5,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      _genLine(0, "following"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5),
                        child: VerticalDivider(
                          thickness: 2,
                          width: 5,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      _genLine(widget.state.apps.length, "apps published"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5),
                        child: VerticalDivider(
                          thickness: 2,
                          width: 5,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      _genLine(widget.state.apps.length, "reviewed apps"),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                if (widget.state.apps.isNotEmpty) ...[
                  const SizedBox(width: 1200),
                  const Gap(40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Explore Apps Published by",
                        style: AppTheme.fontSize(22).makeMedium(),
                      ),
                      Text(
                        " ${widget.state.user.username}",
                        style: AppTheme.fontSize(22).makeBold(),
                      ),
                    ],
                  ),
                  const Gap(20),
                  SizedBox(
                    width: 1400,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        children: [
                          ...widget.state.apps.map(
                            (e) => StoreAppCard(
                              app: e,
                              onPressed: () {
                                widget.controller.viewApp(e);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _genLine(data, description) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data.toString(),
          style: AppTheme.fontSize(18).makeBold().useSen(),
        ),
        Text(
          " $description",
          style: AppTheme.fontSize(14).makeMedium().useSen(),
        ),
      ],
    );
  }
}
