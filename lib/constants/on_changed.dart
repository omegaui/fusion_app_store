class ChangeListener {
  final void Function(dynamic value) listener;
  final bool disposeOnUse;
  bool _used = false;

  ChangeListener(this.listener, this.disposeOnUse);

  void notify(value) {
    if (_used && disposeOnUse) {
      return;
    }
    if (disposeOnUse) {
      _used = true;
    }
    listener(value);
  }
}
