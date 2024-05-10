enum EsrbRating {
  pending,
  mature,
  teen,
  adultsOnly,
  everyone,
  everyone10plus,
}

String parseEsrbRating(EsrbRating rating) {
  switch (rating) {
    case EsrbRating.pending:
      return "Rating is Pending";
    case EsrbRating.mature:
      return "Rated for Mature Age Group";
    case EsrbRating.teen:
      return "Rated for Teenagers";
    case EsrbRating.adultsOnly:
      return "Rated for Adults Only (18+)";
    case EsrbRating.everyone:
      return "Rated for Everyone";
    case EsrbRating.everyone10plus:
      return "Rated for Everyone (10+)";
  }
}
