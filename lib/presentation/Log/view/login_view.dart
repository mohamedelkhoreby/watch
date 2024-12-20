import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:watch/app/app_prefs.dart';
import 'package:watch/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../app/dependency_injection.dart';
import '../../resources/string_manager.dart';
import '../../resources/value_manager.dart';
import '../view_model/login_viewmodel.dart';
import '../../routes/route_manager.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
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
        backgroundColor: Colors.white,
        body: Consumer<LoginViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.state.getScreenWidget(
              context,
              _ContentWidget(),
              () => viewModel.login(),
            );
          },
        ),
      ),
    );
  }
}

class _ContentWidget extends StatefulWidget {
  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  bool switchLanguage = false;
  bool _obscurePassword = false;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<LoginViewModel>(context, listen: false);

    usernameController.addListener(() {
      viewModel.setUserName(usernameController.text);
    });
    passwordController.addListener(() {
      viewModel.setPassword(passwordController.text);
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppValue.v16),
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppValue.s400),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Switch(value: switchLanguage, onChanged: changeLanguage)
                  ],
                ),
                Text(
                  AppStrings.usernameText.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppValue.v20),
                _buildUserNameField(context),
                const SizedBox(height: AppValue.v20),
                _buildPasswordField(context),
                const SizedBox(height: AppValue.v20),
                Text(AppStrings.passwordInfo.tr()),
                const SizedBox(height: AppValue.v20),
                _buildLoginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserNameField(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        errorText:
            viewModel.isUserNameValid ? null : AppStrings.usernameError.tr(),
        border: const OutlineInputBorder(),
        labelText: AppStrings.usernameText.tr(),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    return TextFormField(
      controller: passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        errorText:
            viewModel.isPasswordValid ? null : AppStrings.passwordError.tr(),
        labelText: AppStrings.passwoerdText.tr(),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    return ElevatedButton(
      onPressed:
          viewModel.isLoginButtonEnabled ? () => viewModel.login() : null,
      child: Text(AppStrings.loginBtn.tr()),
    );
  }

  changeLanguage(bool value) {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }
}
