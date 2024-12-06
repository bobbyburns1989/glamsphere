import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/shake_screen.dart';
import 'providers/response_provider.dart';
import 'utils/theme.dart';

void main() {
  runApp(const GlamSphereApp());
}

class GlamSphereApp extends StatelessWidget {
  const GlamSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResponseProvider(),
      child: MaterialApp(
        title: 'GlamSphere',
        theme: AppTheme.glamTheme,
        debugShowCheckedModeBanner: false,
        home: const ShakeScreen(),
      ),
    );
  }
}