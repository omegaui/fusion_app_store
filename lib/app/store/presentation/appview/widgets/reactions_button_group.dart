import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_review_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/reactions.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/reaction_button.dart';

class ReactionsButtonGroup extends StatefulWidget {
  const ReactionsButtonGroup({
    super.key,
    this.initialReaction,
    required this.appReviewEntity,
    required this.onPressed,
  });

  final AppReviewEntity appReviewEntity;
  final Reaction? initialReaction;
  final void Function(Reaction reaction) onPressed;

  @override
  State<ReactionsButtonGroup> createState() => _ReactionsButtonGroupState();
}

class _ReactionsButtonGroupState extends State<ReactionsButtonGroup> {
  Reaction? activeReaction;
  Map<Reaction, String> aggregate = {
    Reaction.poor: "",
    Reaction.bad: "",
    Reaction.fine: "",
    Reaction.good: "",
    Reaction.reallyGood: "",
  };

  @override
  Widget build(BuildContext context) {
    activeReaction = widget.initialReaction;
    int poor = 0;
    int bad = 0;
    int fine = 0;
    int good = 0;
    int reallyGood = 0;
    for (final review in widget.appReviewEntity.reviews) {
      switch (review.reaction) {
        case Reaction.poor:
          poor++;
          break;
        case Reaction.bad:
          bad++;
          break;
        case Reaction.fine:
          fine++;
          break;
        case Reaction.good:
          good++;
          break;
        case Reaction.reallyGood:
          reallyGood++;
          break;
      }
    }

    aggregate = {
      Reaction.poor: poor == 0 ? "" : poor.toString(),
      Reaction.bad: bad == 0 ? "" : bad.toString(),
      Reaction.fine: fine == 0 ? "" : fine.toString(),
      Reaction.good: good == 0 ? "" : good.toString(),
      Reaction.reallyGood: reallyGood == 0 ? "" : reallyGood.toString(),
    };
    return SizedBox(
      height: 70,
      child: Wrap(
        spacing: 5,
        children: [
          ...Reaction.values.map(
            (e) => ReactionButton(
              reaction: e,
              active: activeReaction == e,
              bottomText: aggregate[e]!.toString(),
              onPressed: () {
                if (widget.initialReaction == null) {
                  setState(() {
                    activeReaction = e;
                  });
                  widget.onPressed(e);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
