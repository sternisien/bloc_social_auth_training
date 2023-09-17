class OnTapItemNavbarEvent {
  late int _currentIndexTap;

  OnTapItemNavbarEvent({required int currentIndexTap}) {
    _currentIndexTap = currentIndexTap;
  }

  int getCurrentIndexTap() {
    return _currentIndexTap;
  }
}
