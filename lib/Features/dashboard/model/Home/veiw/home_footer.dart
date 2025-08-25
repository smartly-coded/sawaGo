import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: const Color.fromRGBO(0, 41, 54, 0.1),
      padding: EdgeInsets.symmetric(
        vertical: screenWidth < 600 ? 20 : 40,
        horizontal: screenWidth < 600 ? 16 : 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Image.asset(
            "assets/images/splash_logo.png",
            width: screenWidth < 600 ? 140 : 200,
            height: 30,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 16),

        
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "حسن تجربة سفرك مع تطبيق SawaGO",
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(85, 85, 85, 1)),
              ),
              SizedBox(height: 6),
              Text(
                "جميع مسارات رحلات مشاركة الرحلات",
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(85, 85, 85, 1)),
              ),
              SizedBox(height: 6),
              Text(
                "جميع وجهات رحلات مشاركة الرحلات",
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(85, 85, 85, 1)),
              ),
              SizedBox(height: 6),
              Text(
                "جميع خطوط الحافلات",
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(85, 85, 85, 1)),
              ),
              SizedBox(height: 6),
              Text(
                "جميع وجهات الحافلات",
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(85, 85, 85, 1)),
              ),
            ],
          ),

          const SizedBox(height: 20),

         
          screenWidth < 400
              ? Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: _socialIcons(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _socialIcons(),
                ),

          const SizedBox(height: 16),

          
          const Center(
            child: Text(
              "استمتع بأمتع الرحلات مع تطبيق SawaGO!",
              style:
                  TextStyle(fontSize: 14, color: Color.fromRGBO(85, 85, 85, 1)),
            ),
          ),
        ],
      ),
    );
  }

 
  List<Widget> _socialIcons() {
    const iconColor = Color(0xFF02C35E);
    return [
      const Icon(FontAwesomeIcons.youtube, color: iconColor, size: 22),
      const Icon(FontAwesomeIcons.whatsapp, color: iconColor, size: 22),
      const Icon(FontAwesomeIcons.envelope, color: iconColor, size: 22),
      const Icon(FontAwesomeIcons.facebook, color: iconColor, size: 22),
      const Icon(FontAwesomeIcons.instagram, color: iconColor, size: 22),
    ].map((icon) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: IconButton(onPressed: () {}, icon: icon),
      );
    }).toList();
  }
}
