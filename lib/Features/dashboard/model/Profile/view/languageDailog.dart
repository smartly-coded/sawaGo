import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Laguagedailog extends StatefulWidget {
  const Laguagedailog({super.key});

  @override
  State<Laguagedailog> createState() => _LaguagedailogState();
}

class _LaguagedailogState extends State<Laguagedailog> {
  String? languagesOption;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _customRadio(
                title: Row(
                  children: [
                    Image.asset("assets/images/ar_flag.png",
                        width: 24, height: 24),
                    const SizedBox(width: 8),
                    const Text("العربية"),
                  ],
                ),
                value: "العربية",
              ),
              const SizedBox(height: 20),
              _customRadio(
                title: Row(
                  children: [
                    Image.asset("assets/images/en_flag.png",
                        width: 24, height: 24),
                    const SizedBox(width: 8),
                    const Text("English"),
                  ],
                ),
                value: "English",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204F38),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.6,
                    50,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  if (languagesOption == "العربية") {
                    context.setLocale(const Locale('ar', 'EG'));
                  } else {
                    context.setLocale(const Locale('en', 'US'));
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  "Apply",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _customRadio({required Widget title, required String value}) {
    final isSelected = languagesOption == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          languagesOption = value;
        });
      },
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF204F38),
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, size: 16, color: Color(0xFF204F38))
                : null,
          ),
          const SizedBox(width: 10),
          title,
        ],
      ),
    );
  }
}