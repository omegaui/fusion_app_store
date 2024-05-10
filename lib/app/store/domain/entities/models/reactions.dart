import 'package:get/get.dart';

import '../../../../../config/app_icons.dart';

enum Reaction {
  poor,
  bad,
  fine,
  good,
  reallyGood,
}

String getReactionIcon(Reaction reaction) {
  switch (reaction) {
    case Reaction.poor:
      return AppIcons.poor;
    case Reaction.bad:
      return AppIcons.bad;
    case Reaction.fine:
      return AppIcons.fine;
    case Reaction.good:
      return AppIcons.good;
    case Reaction.reallyGood:
      return AppIcons.reallyGood;
  }
}

String parseReaction(Reaction reaction) {
  switch (reaction) {
    case Reaction.poor:
    case Reaction.bad:
    case Reaction.fine:
    case Reaction.good:
      return reaction.name.capitalize!;
    case Reaction.reallyGood:
      return "Really Good";
  }
}
