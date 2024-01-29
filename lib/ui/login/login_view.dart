import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/auth_provider.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/utils/app_asset.dart';
import 'package:responsible_development/utils/app_storage.dart';
import 'package:responsible_development/widgets/buttons/button_primary.dart';
import 'package:responsible_development/widgets/inputs/input_password.dart';
import 'package:responsible_development/widgets/inputs/input_primary.dart';
import 'package:responsible_development/widgets/others/footer_default.dart';
import 'package:responsible_development/widgets/others/vertical_space.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static String routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    final username = await AppStorage.read(key: 'username');
    if (username.isNotEmpty) {
      usernameController.text = username;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return Scaffold(
              backgroundColor: utilityProvider.isDarkTheme ||
                      MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                  ? Colors.black
                  : Colors.white,
              bottomNavigationBar: const FooterDefault(),
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAsset.logo('logo-anj.png'), height: 65),
                        const VerticalSpace(height: 4),
                        Text('Responsible Development',
                            style: textStyle.titleSmall),
                        const VerticalSpace(height: 24),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              InputPrimary(
                                controller: usernameController,
                                hintText: 'Nama Pengguna',
                                validatorText:
                                    'Nama Pengguna tidak boleh kosong',
                                preffixIcon: Icons.person,
                              ),
                              InputPassword(
                                controller: passwordController,
                                hintText: 'Kata Sandi',
                                validatorText: 'Kata Sandi tidak boleh kosong',
                                preffixIcon: Icons.key,
                              ),
                            ],
                          ),
                        ),
                        const VerticalSpace(height: 12),
                        ButtonPrimary(
                          label: 'Login',
                          onPressed: () {
                            authProvider.login(
                              context,
                              usernameController: usernameController,
                              passwordController: passwordController,
                            );
                          },
                        ),
                        VerticalSpace(
                          height: MediaQuery.of(context).viewInsets.bottom / 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
