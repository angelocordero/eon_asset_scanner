import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../core/constants.dart';
import '../core/database_api.dart';
import '../core/utils.dart';
import '../models/connection_settings_model.dart';
import '../models/user_model.dart';
import 'connection_settings_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static final TextEditingController usernameController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.clear();
    passwordController.clear();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.settings),
        onPressed: () async {
          ConnectionSettings connectionSettings;

          try {
            connectionSettings = ConnectionSettings(
              databaseName: settingsBox.get('databaseName'),
              ip: settingsBox.get('ip'),
              port: settingsBox.get('port'),
              username: settingsBox.get('username'),
              password: settingsBox.get('password'),
            );
          } catch (e) {
            connectionSettings = ConnectionSettings.empty();
          }

          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ConnectionSettingsScreen(
                  localIPController: TextEditingController.fromValue(
                    TextEditingValue(text: connectionSettings.ip),
                  ),
                  portController: TextEditingController.fromValue(
                    TextEditingValue(text: connectionSettings.port.toString()),
                  ),
                  userController: TextEditingController.fromValue(
                    TextEditingValue(text: connectionSettings.username),
                  ),
                  passwordController: TextEditingController.fromValue(
                    TextEditingValue(text: connectionSettings.password),
                  ),
                  dbNameController: TextEditingController.fromValue(
                    TextEditingValue(text: connectionSettings.databaseName),
                  ),
                );
              },
            ),
          );
        },
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('U S E R   L O G I N'),
                const SizedBox(
                  height: 20,
                ),
                usernameField(),
                const SizedBox(
                  height: 20,
                ),
                passwordField(context),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await authenticate(context);
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

  Widget passwordField(BuildContext context) {
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
              await authenticate(context);
            },
            decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.all(8)),
            obscureText: true,
            controller: passwordController,
          ),
        ),
      ],
    );
  }

  Future<void> authenticate(BuildContext context) async {
    EasyLoading.show();

    String username = usernameController.text.trim();
    String passwordHash = hashPassword(passwordController.text.trim());

    User? user;

    try {
      globalConnectionSettings = ConnectionSettings(
        databaseName: settingsBox.get('databaseName'),
        ip: settingsBox.get('ip'),
        port: settingsBox.get('port'),
        username: settingsBox.get('username'),
        password: settingsBox.get('password'),
      );

      user = await DatabaseAPI.authenticateUser(username, passwordHash);
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError(e.toString());
    }

    if (user == null) {
      EasyLoading.showError('user does not exist');
      return;
    }

    await EasyLoading.dismiss();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, 'home');
  }
}
