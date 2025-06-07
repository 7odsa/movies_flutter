import 'package:flutter/material.dart';
import 'package:movies_flutter/generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(S.of(context).login)));
  }
}
