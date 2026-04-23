import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "../../../auth/presentation/providers/auth_provider.dart";
import "../../../../core/routes/app_router.dart";

class AuthSettings extends StatefulWidget {
  const AuthSettings({super.key});

  @override
  State<AuthSettings> createState() => _AuthSettingsState();
}

class _AuthSettingsState extends State<AuthSettings> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await auth.logout();
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, AppRouter.login);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text(
          "Logout",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
