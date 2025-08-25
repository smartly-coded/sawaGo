import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  List<String> cities = ["حمص", "دمشق", "حلب", "اللاذقية", "طرطوس"];
  List<String> filteredCities = [];

  @override
  void initState() {
    super.initState();
    filteredCities = cities;
  }

  void _filterSearch(String query) {
    setState(() {
      filteredCities =
          cities.where((city) => city.contains(query.trim())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: isTablet ? 60 : 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF02C35E)),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: _filterSearch,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "ابحث  ",
                    suffixIcon: Icon(Icons.search, color: Color(0xFF555555)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: filteredCities.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      filteredCities[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: const Text("سوريا",
                        style: TextStyle(color: Colors.grey)),
                    leading: const Icon(Icons.chevron_left,
                        color: Color(0xFF02C35E)),
                    onTap: () {
                      Navigator.pop(context, filteredCities[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
