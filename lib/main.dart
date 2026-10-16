import 'package:flutter/material.dart';
import 'screens/main_shell.dart';
import 'screens/login_screen.dart';
import 'services/api_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final user = await SessionService.load();
  runApp(KheloxApp(user: user));
}

class KheloxApp extends StatelessWidget {
  final UserModel? user;
  const KheloxApp({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khelox',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: user != null ? MainShell(user: user!) : const LoginScreen(),
    );
  }
}