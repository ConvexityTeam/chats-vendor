import 'package:CHATS_Vendor/core/constants/view_state.dart';
import 'package:flutter/material.dart';

class BaseProviderModel extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;
  ViewState get getState => _state;

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setErrorState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
