import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../widgets/glam_sphere_widget.dart';
import '../providers/response_provider.dart';

class ShakeScreen extends StatelessWidget {
  const ShakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.purple.withOpacity(0.2),
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  kIsWeb 
                    ? 'Click the sphere to reveal your fortune! ✨' 
                    : 'Shake your device or press SPACE! ✨',
                  style: TextStyle(
                    color: Colors.pink[100],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GlamSphereWidget(
                onResponseGenerated: (response) {
                  Provider.of<ResponseProvider>(context, listen: false)
                      .setResponse(response);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}