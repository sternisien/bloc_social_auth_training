class NavState {
  late int _currentIndex;

  NavState({required int currentIndex}) {
    _currentIndex = currentIndex;
  }

  int getCurrentIndex() {
    return _currentIndex;
  }
}
