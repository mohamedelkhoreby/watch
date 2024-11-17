import 'package:flutter/material.dart';
import '../../../app/function.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isUserNameValid = true;
  bool _isPasswordValid = true;
  bool _isLoginButtonEnabled = false;
  FlowState _state = ContentState();
  VoidCallback? onLoginSuccess;

  FlowState get state => _state;
  bool get isLoginButtonEnabled => _isLoginButtonEnabled;
  bool get isUserNameValid => _isUserNameValid;
  bool get isPasswordValid => _isPasswordValid;

  void setUserName(String userName) {
    _isUserNameValid = userName.isNotEmpty;
    _validateInputs();
    notifyListeners();
  }

  void setPassword(String password) {
    _isPasswordValid = passwordValid(password);
    _validateInputs();
    notifyListeners();
  }

  Future<void> login() async {
    _state =
        LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    notifyListeners();

    await Future.delayed(
      const Duration(seconds: 4),
    );

    // Simulate successful login and trigger navigation callback
    _state = ContentState();
    notifyListeners();
    if (onLoginSuccess != null) {
      onLoginSuccess!(); // Trigger navigation callback if set
    }
  }

  Future<void> changeLanguage() async {
    // Show loading state
    _state =
        LoadingState(stateRendererType: StateRendererType.popupLoadingState);
    notifyListeners();

    // Simulate language change delay
    await Future.delayed(const Duration(milliseconds: 500));


    // Reset state to ContentState after loading
    _state = ContentState();
    notifyListeners();
  }

  void _validateInputs() {
    _isLoginButtonEnabled = _isUserNameValid && _isPasswordValid;
  }
}
