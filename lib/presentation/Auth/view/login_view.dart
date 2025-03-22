import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'package:watch/presentation/Auth/view/widget/login_form.dart';
import 'package:watch/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../app/app_prefs.dart';
import '../../../app/dependency_injection.dart';
import '../../routes/route_manager.dart';
import '../view_model/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  bool switchLanguage = false;

  changeLanguage(bool value) {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = LoginViewModel();
        viewModel.onLoginSuccess = () {
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        };
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                Switch(value: switchLanguage, onChanged: changeLanguage),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.state.getScreenWidget(
              context,
              const ContentWidget(),
              () => viewModel.login(),
            );
          },
        ),
      ),
    );
  }
}
