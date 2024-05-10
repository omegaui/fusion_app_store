import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_review_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_review.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/reactions.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_controller.dart';
import 'package:fusion_app_store/app/store/presentation/appview/states/appview_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/reaction_button.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/global/message_box.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Reaction selectedReaction = Reaction.fine;
final reviewDescriptionFocusNode = FocusNode();

class ReviewsBox extends StatefulWidget {
  const ReviewsBox({
    super.key,
    required this.publisher,
    required this.appReviewEntity,
    required this.controller,
    required this.appEntity,
    required this.usersWhoReviewed,
  });

  final UserEntity publisher;
  final AppEntity appEntity;
  final AppReviewEntity appReviewEntity;
  final AppViewPageController controller;
  final List<UserEntity> usersWhoReviewed;

  @override
  State<ReviewsBox> createState() => ReviewsBoxState();
}

class ReviewsBoxState extends State<ReviewsBox> {
  TextEditingController reviewDescriptionController = TextEditingController();

  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    final reviewed = widget.appReviewEntity.reviews
        .firstWhereOrNull((e) => e.username == widget.publisher.username);
    if (reviewed != null) {
      selectedReaction = reviewed.reaction;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasAlreadyReviewed = widget.appReviewEntity.reviews
        .any((e) => e.username == widget.publisher.username);
    return LimitedBox(
      maxHeight: 1020,
      child: Container(
        width: 980,
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 27),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [getBoxesShadow()],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reactions and Reviews",
              style: AppTheme.fontSize(16).makeBold().useSen(),
            ),
            _buildSumUp(),
            if (!hasAlreadyReviewed) ...[
              const Gap(10),
              _buildWriteReviewCard(),
            ],
            if (widget.appReviewEntity.reviews.isNotEmpty) ...[
              const Gap(10),
              Text(
                "Most Recent Reviews",
                style: AppTheme.fontSize(16).makeBold().useSen(),
              ),
              const Gap(10),
              Wrap(
                spacing: 10,
                children: widget.appReviewEntity.reviews
                    .take(3)
                    .map(
                      (e) => _ReviewTile(
                        review: e,
                        userEntity: widget.usersWhoReviewed
                            .firstWhere((x) => e.username == x.username),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWriteReviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.reviews,
                color: Color(0xFF676767),
              ),
              const Gap(4),
              Text(
                "Write a review about this app",
                style: AppTheme.fontSize(14).makeMedium().useSen(),
              ),
            ],
          ),
          const Gap(10),
          SizedBox(
            height: 70,
            child: Wrap(
              spacing: 5,
              children: [
                ...Reaction.values.map(
                  (e) => ReactionButton(
                    reaction: e,
                    bottomText: parseReaction(e),
                    active: selectedReaction == e,
                    onPressed: () {
                      setState(() {
                        selectedReaction = e;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Text(
            "Pick your reaction",
            style: AppTheme.fontSize(12).makeMedium().useSen(),
          ),
          LimitedBox(
            maxHeight: 120,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                focusNode: reviewDescriptionFocusNode,
                controller: reviewDescriptionController,
                maxLines: 4,
                style: AppTheme.fontSize(14).makeMedium().useSen(),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 50) {
                    return "*Requires at least 50 chars to post a review";
                  }
                  return "";
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintText:
                      "Write a description about your experience with this app (at least 50 chars long)",
                  hintStyle: AppTheme.fontSize(14)
                      .makeMedium()
                      .useSen()
                      .withColor(Colors.grey.shade600),
                ),
              ),
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  if (reviewDescriptionController.text.isEmpty) {
                    showMessage(
                      title: "Write some review",
                      description: "Cannot post an empty review",
                    );
                  } else {
                    widget.controller.reviewApp(
                      widget.appEntity,
                      AppReview(
                        username: widget.publisher.username,
                        when: DateTime.now(),
                        message: reviewDescriptionController.text,
                        reaction: selectedReaction,
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Post",
                    style: AppTheme.fontSize(14)
                        .makeMedium()
                        .withColor(Colors.white)
                        .useSen(),
                  ),
                ),
              ),
              const Gap(10),
              TextButton(
                onPressed: () {
                  reviewDescriptionController.clear();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Clear",
                    style: AppTheme.fontSize(14)
                        .makeMedium()
                        .withColor(Colors.white)
                        .useSen(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSumUp() {
    final reviews = widget.appReviewEntity.reviews;
    if (reviews.length <= 5) {
      return Text(
        "Not enough reviews to build a summary",
        style: AppTheme.fontSize(14).makeMedium().useSen(),
      );
    } else {
      return Text(
        "Summary",
        style: AppTheme.fontSize(14).makeMedium().useSen(),
      );
    }
  }
}

class _ReviewTile extends StatelessWidget {
  final AppReview review;
  final UserEntity userEntity;

  const _ReviewTile({
    required this.review,
    required this.userEntity,
  });

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 120,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFF0F0F0),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox.square(
                        dimension: 32,
                        child: Image.network(
                          userEntity.avatarUrl,
                        ),
                      ),
                      Text(
                        review.username,
                        style: AppTheme.fontSize(14).makeBold().useSen(),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Text(
                    review.message,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.fontSize(13).makeMedium().useSen(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                getReactionIcon(review.reaction),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
