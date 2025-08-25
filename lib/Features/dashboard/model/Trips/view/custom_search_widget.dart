import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  final bool isTablet;
  final VoidCallback onTap;

  const CustomSearchWidget({
    super.key,
    required this.isTablet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 16 : 8,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 215, 213, 213),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                "بحث",
                style: TextStyle(
                  fontSize: isTablet ? 20 : 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF555555),
                ),
              ),
              const Spacer(),
              Icon(Icons.search,
                  size: isTablet ? 28 : 20, color: const Color(0xFF555555)),
            ],
          ),
        ),
      ),
    );
  }
}
