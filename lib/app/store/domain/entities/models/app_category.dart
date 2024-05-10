enum AppCategory {
  game,
  news,
  productivity,
  development,
  media,
  utility,
  social,
  personalization,
  ecommerce,
  sports,
  kids,
  education,
  system,
  travel,
  design,
}

String parseAppCategory(AppCategory category) {
  switch (category) {
    case AppCategory.game:
      return "Game";
    case AppCategory.news:
      return "News";
    case AppCategory.productivity:
      return "Productivity";
    case AppCategory.development:
      return "Development";
    case AppCategory.media:
      return "Media";
    case AppCategory.utility:
      return "Utility";
    case AppCategory.social:
      return "Social";
    case AppCategory.personalization:
      return "Personalization";
    case AppCategory.ecommerce:
      return "Ecommerce";
    case AppCategory.sports:
      return "Sports";
    case AppCategory.kids:
      return "Kids";
    case AppCategory.education:
      return "Education";
    case AppCategory.system:
      return "System";
    case AppCategory.travel:
      return "Travel";
    case AppCategory.design:
      return "Design";
  }
}
