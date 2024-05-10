class ErrorEvent {}

class ErrorIdentificationEvent extends ErrorEvent {}

class ErrorIdentifiedEvent extends ErrorEvent {
  String message;
  String stackTrace;

  ErrorIdentifiedEvent(this.message, this.stackTrace);
}

class ErrorState {}

class ErrorIdentificationState extends ErrorState {}

class ErrorIdentifiedState extends ErrorState {
  late String message;
  late String stackTrace;

  ErrorIdentifiedState.fromEvent(ErrorIdentifiedEvent event) {
    message = event.message;
    stackTrace = event.stackTrace;
  }
}
