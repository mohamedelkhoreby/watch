import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../resources/string_manager.dart';
import '../../../resources/value_manager.dart';
import '../../view_model/login_viewmodel.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool switchLanguage = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<LoginViewModel>();
      usernameController.addListener(() {
        viewModel.setUserName(usernameController.text);
      });
      passwordController.addListener(() {
        viewModel.setPassword(passwordController.text);
      });
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
                
                Text(
                  AppStrings.usernameText.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppValue.v20),
                _buildUserNameField(),
                const SizedBox(height: AppValue.v20),
                _buildPasswordField(),
                const SizedBox(height: AppValue.v20),
                Text(AppStrings.passwordInfo.tr()),
                const SizedBox(height: AppValue.v20),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserNameField() {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
            errorText: viewModel.isUserNameValid
                ? null
                : AppStrings.usernameError.tr(),
            border: const OutlineInputBorder(),
            labelText: AppStrings.usernameText.tr(),
          ),
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return TextFormField(
          controller: passwordController,
          obscureText: viewModel.isPasswordObscured,
          decoration: InputDecoration(
            errorText: viewModel.isPasswordValid
                ? null
                : AppStrings.passwordError.tr(),
            labelText: AppStrings.passwoerdText.tr(),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                viewModel.isPasswordObscured
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () => viewModel.togglePasswordVisibility(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return ElevatedButton(
          onPressed:
              viewModel.isLoginButtonEnabled ? () => viewModel.login() : null,
          child: Text(AppStrings.loginBtn.tr()),
        );
      },
    );
  }

 
}
