import 'package:flutter/material.dart';
import 'package:sawago/Features/dashboard/model/Profile/view/languageDailog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            width: 120,
            height: 120,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFFFDFDFD),
              child: Icon(
                Icons.person_2_outlined,
                size: 60,
                color: Color.fromARGB(255, 180, 181, 181),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'مرحبا بك في SawaGO',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF204F38),
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  title: "الملف الشخصي",
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.flight_takeoff,
                  title: "رحلاتي",
                  onTap: () {
                    Navigator.pushNamed(context, '/trips');
                  },
                ),
                _buildDrawerItem(context,
                    icon: Icons.flight_takeoff,
                    title: "تتبع الرحلة ",
                     onTap: () {
                  Navigator.pushNamed(context, '/tracking_trip');
                }),
                _buildDrawerItem(context,
                    icon: Icons.flight_takeoff, title: "المحفظة ",
                     onTap: () {
                  Navigator.pushNamed(context, '/wallet');
                }),
                _buildDrawerItem(
                  context,
                  icon: Icons.language,
                  title: "اللغة ",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const Laguagedailog(),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info_outline,
                  title: "من نحن",
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFFDEDFDF),
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: screenWidth * 0.6,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 245, 247, 246),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: const Text(
                "تسجيل خروج",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF204F38),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF204F38)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF858D9A)),
      onTap: onTap,
    );
  }
}
