import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                thickness: 1,
                color: Color(0xFF656565),
                endIndent: 15,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'أو التسجيل عن طريق',
                style: TextStyle(
                  color: Color(0xFF656565),
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                color: Color(0xFF656565),
                indent: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/google.png', width: 50),
            const SizedBox(width: 5),
            Image.asset('assets/images/facebook.png', width: 50),
          ],
        ),
      ],
    );
  }
}
