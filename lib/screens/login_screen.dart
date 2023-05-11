import 'package:eon_asset_scanner/models/connection_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database_api.dart';
import '../core/providers.dart';
import '../core/utils.dart';
import '../models/user_model.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static final TextEditingController usernameController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    usernameController.clear();
    passwordController.clear();

    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('User Login'),
                const SizedBox(
                  height: 20,
                ),
                usernameField(),
                const SizedBox(
                  height: 20,
                ),
                passwordField(context, ref),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await authenticate(context, ref);
                    },
                    child: const Text('Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget usernameField() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Username: '),
        const SizedBox(
          width: 30,
        ),
        SizedBox(
          width: 150,
          child: TextField(
            autofocus: true,
            controller: usernameController,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordField(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Password: '),
        const SizedBox(
          width: 30,
        ),
        SizedBox(
          width: 150,
          child: TextField(
            onSubmitted: (value) async {
              await authenticate(context, ref);
            },
            decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.all(8)),
            obscureText: false,
            controller: passwordController,
          ),
        ),
      ],
    );
  }

  Future<void> authenticate(BuildContext context, WidgetRef ref) async {
    EasyLoading.show();

    ConnectionSettings settings = ConnectionSettings(
      host: '192.168.1.32',
      port: 3306,
      user: 'admin',
      password: 'admin',
      database: 'eon',
    );

    ref.read(sqlSettingsProvider.notifier).state = settings;

    String username = usernameController.text.trim();
    String passwordHash = hashPassword(passwordController.text.trim());

    User? user;

    try {
      user = await DatabaseAPI(settings).authenticateUser(username, passwordHash);
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError(e.toString());
    }

    if (user == null) {
      //EasyLoading.showError('user does not exist');
      return;
    }

    ref.read(userProvider.notifier).state = user;

    await EasyLoading.dismiss();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, 'home');
  }
}