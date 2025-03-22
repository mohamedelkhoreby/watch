import 'package:flutter/material.dart';
import '../../../app/function.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isUserNameValid = true;
  bool _isPasswordValid = true;
  bool _isLoginButtonEnabled = false;
  bool _isPasswordObscured = true;
  FlowState _state = ContentState();
  VoidCallback? onLoginSuccess;

  FlowState get state => _state;
  bool get isLoginButtonEnabled => _isLoginButtonEnabled;
  bool get isUserNameValid => _isUserNameValid;
  bool get isPasswordValid => _isPasswordValid;
  bool get isPasswordObscured => _isPasswordObscured;

  void setUserName(String userName) {
    _isUserNameValid = userName.isNotEmpty;
    _validateInputs();
  }

  void setPassword(String password) {
    _isPasswordValid = passwordValid(password);
    _validateInputs();
  }

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  Future<void> login() async {
    _state =
        LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (_isUserNameValid && _isPasswordValid) {
      _state = ContentState();
      notifyListeners();
      if (onLoginSuccess != null) {
        onLoginSuccess!();
      }
    } else {
      _state = ErrorState(StateRendererType.popupErrorState,
          "Login failed. Please check your credentials.");
      notifyListeners();
    }
  }

  Future<void> changeLanguage() async {
    _state =
        LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _state = ContentState();
    notifyListeners();
  }

  void _validateInputs() {
    _isLoginButtonEnabled = _isUserNameValid && _isPasswordValid;
    notifyListeners();
  }
}
