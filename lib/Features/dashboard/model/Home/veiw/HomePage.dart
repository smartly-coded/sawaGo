import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sawago/Core/Theme/app_colors.dart';
import 'package:sawago/Features/dashboard/model/Home/model/featureContainers_Model.dart';
import 'package:sawago/Features/dashboard/model/Home/veiw/app_drawer.dart';
import 'package:sawago/Features/dashboard/model/Home/veiw/booking_form.dart';
import 'package:sawago/Features/dashboard/model/Home/veiw/feature_container.dart';
import 'package:sawago/Features/dashboard/model/Home/veiw/home_footer.dart';
import 'package:sawago/Features/dashboard/model/Home/veiw/popular_trips_slider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    final unitSize = isSmallScreen ? screenWidth / 40 : screenWidth / 50;
    final paddingUnit = unitSize * 1.0;
    final marginUnit = unitSize * 1.5;
    final fontSizeUnit = unitSize * 1.2;

    final List<FeatureModel> features = [
      FeatureModel(
        title: "الرحلات التي تختارها مقابل القليل من المال",
        description:
            "أينما كنت ترغب في الذهاب ، سواء عن طريق الحافلة أو كركاب ، ستجد الرحلة المثالية بسعر معقول في مجموعة واسعة من الوجهات والطرق.",
        icon: "assets/icons/Vector.png",
      ),
      FeatureModel(
        title: " السفر بثقة",
        description:
            "نأخذ الوقت الكافي للتعرف على جميع أعضائنا وشركاء الحافلات. كيف؟ نحن نتحقق من المراجعات والملفات الشخصية ومستندات الهوية حتى تعرف من الذي تركب معه.",
        icon: "assets/icons/Group.png",
      ),
      FeatureModel(
        title: " التمرير ، انقر ، اضغط واذهب!",
        description:
            "إن حجز رحلة لم يكن أسهل! بفضل تطبيقنا المباشر والمتطور ، يمكنك حجز رحلة بالقرب منك في دقائق فقط.",
        icon: "assets/icons/Vector (1).png",
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const AppDrawer(),
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: const IconThemeData(color: AppColors.primary),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: paddingUnit * 3),
              child: Image.asset(
                "assets/images/logo.png",
                height: unitSize * 3.5,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            Column(
              children: [
                Container(
                  height: screenHeight * 0.6,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/homebackground.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingUnit * 4,
                      vertical: screenHeight * 0.06,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "رحلاتك المفضلة\nبتكلفة قليلة",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeUnit * 3.0,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: unitSize * 1.5),
                        Text(
                          "استمتع برحلة مميزة مع SawaGO\nبأقل التكاليف الممكنة",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: fontSizeUnit * 1.5,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: unitSize * 3),
                        const RequestButton(),
                        SizedBox(height: unitSize * 3),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.25
                        : screenHeight * 0.15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginUnit * 2),
                  padding: EdgeInsets.all(paddingUnit * 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(unitSize * 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "سلامتك أولويتنا",
                        style: TextStyle(
                          fontSize: fontSizeUnit * 1.8,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF01301B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: unitSize * 2),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: fontSizeUnit * 1.3,
                            height: 1.5,
                            color: Colors.grey.shade800,
                          ),
                          children: const [
                            TextSpan(
                              text:
                                  "في SawaGO، نحن ملتزمون بإنشاء مجتمع موثوق به في جميع أنحاء العالم.",
                            ),
                            TextSpan(
                              text:
                                  " تفضل بزيارة صفحة الثقة والسلامة الخاصة بنا للتعرف على الإجراءات المختلفة التي يمكن أن تساعدك على الشعور بالأمان في رحلتك القادمة.",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: unitSize * 2.5),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: EdgeInsets.symmetric(
                            horizontal: paddingUnit * 4,
                            vertical: unitSize * 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(unitSize * 1.5),
                          ),
                        ),
                        child: Text(
                          "اكتشف المزيد",
                          style: TextStyle(
                            fontSize: fontSizeUnit * 1.3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  "ميزاتنا",
                  style: TextStyle(
                    fontSize: fontSizeUnit * 2.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF01301B),
                  ),
                ),
                SizedBox(height: unitSize * 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingUnit * 4),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: features.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: unitSize * 2),
                        child: FeatureContainer(feature: features[index]),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Container(
                    height: screenHeight * 0.6,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Color(0xFFE6F9EF)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: paddingUnit * 4),
                            child: Text(
                              "الى أين ترغب الذهاب؟",
                              style: TextStyle(
                                fontSize: fontSizeUnit * 2.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF01301B),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: paddingUnit * 2,
                                horizontal: paddingUnit * 4),
                            child: Text(
                              "يمكنك حجز رحلة بسهولة وأمان، مع اختيار الوقت والمكان الذي يناسبك لنقوم بنقلك إلى وجهتك بكل راحة وموثوقية\nلا تتردد و قم بحجز رحلتك القادمة الآن؟",
                              style: TextStyle(
                                fontSize: fontSizeUnit * 1.4,
                                height: 1.6,
                                color: const Color(0xFF555555),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: paddingUnit * 3,
                              right: paddingUnit * 4,
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                  horizontal: paddingUnit * 3,
                                  vertical: paddingUnit * 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(unitSize * 2),
                                ),
                              ),
                              child: Text(
                                "اكشف المزيد من الرحلات",
                                style: TextStyle(
                                  fontSize: fontSizeUnit * 1.3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: paddingUnit * 2),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Container(
                                    padding: EdgeInsets.all(paddingUnit * 2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: const Row(
                                      children: [
                                        Text("حمص"),
                                        Icon(Icons.arrow_forward),
                                        Text("دمشق"),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ])),
                SizedBox(height: screenHeight * 0.04),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    "assets/images/unsplash_iqYUO67mRxg.png",
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.08),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    "assets/images/unsplash_jvIrjrQKCng.png",
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/images/unsplash_1B_EoGyXGs8.png",
                                width: MediaQuery.of(context).size.width * 0.55,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    height: screenHeight * 0.3,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: paddingUnit * 4,
                            ),
                            child: Text(
                              "القيادة والحفظ",
                              style: TextStyle(
                                fontSize: fontSizeUnit * 2.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF01301B),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: paddingUnit * 2,
                                horizontal: paddingUnit * 4),
                            child: Text(
                              "اشترك كسائق و وفر تكاليف السفر من خلال الانضمام لفريقنا يستغرق إنشاء عرضك الأول دقائق فقط. هل أنت مستعد ؟",
                              style: TextStyle(
                                fontSize: fontSizeUnit * 1.4,
                                height: 1.6,
                                color: const Color(0xFF555555),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              right: paddingUnit * 4,
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                  horizontal: paddingUnit * 3,
                                  vertical: paddingUnit * 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(unitSize * 2),
                                ),
                              ),
                              child: Text(
                                "اضغط للاشتراك",
                                style: TextStyle(
                                  fontSize: fontSizeUnit * 1.3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ])),
                Container(
                  width: double.infinity,
                  color: const Color.fromARGB(255, 193, 237, 235),
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth < 600 ? 12 : 24,
                    horizontal: screenWidth < 600 ? 8 : 32,
                  ),
                  child: Container(
                    width: screenWidth * (screenWidth < 600 ? 0.9 : 0.6),
                    margin: const EdgeInsets.all(12),
                    padding: EdgeInsets.all(screenWidth < 600 ? 16 : 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "السفر معقول مع حافلة SawaGo",
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 24 : 30,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(1, 48, 27, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "معنا، ستجد ركوب الحافلات بأسعار معقولة لوجهاتك المفضلة. احجز تذكرة مع حافلة SawaGO الآن في بضع دقائق",
                          style: TextStyle(
                            fontSize: screenWidth < 600 ? 18 : 24,
                            color: const Color.fromRGBO(85, 85, 85, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: screenWidth < 600
                              ? double.infinity
                              : screenWidth * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(2, 195, 94, 1),
                              padding: EdgeInsets.symmetric(
                                vertical: screenWidth < 600 ? 14 : 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "ابحث عن حافلتك الآن مع SawaGO",
                              style: TextStyle(
                                fontSize: screenWidth < 600 ? 18 : 24,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "أشهر رحلاتنا",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(1, 48, 27, 1)),
                  ),
                ),
                const PopularTripsSlider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        "تحسين تجربة السفر الخاصة بك مع تطبيق SawaGO",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(1, 48, 27, 1)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "جميع السائقين والذاكرات في مكان واحد، ومعلومات محدثة ومميزات حصرية",
                        style: TextStyle(
                            fontSize: 18, color: Color.fromRGBO(85, 85, 85, 1)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/apple_store.png",
                              height: 40),
                          const SizedBox(width: 12),
                          Image.asset("assets/images/googleplay.png",
                              height: 40),
                        ],
                      )
                    ],
                  ),
                ),
                const AppFooter(),
              ],
            ),
            Positioned(
              top: screenHeight * 0.40,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingUnit * 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(unitSize * 2),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(unitSize * 2),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(paddingUnit * 2),
                        child: const BookingForm(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class RequestButton extends StatelessWidget {
  const RequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final unitSize = isSmallScreen ? screenWidth / 40 : screenWidth / 50;

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: EdgeInsets.symmetric(
          horizontal: unitSize * 4,
          vertical: unitSize * 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(unitSize * 1.5),
        ),
      ),
      child: Text(
        "اطلب رحلتك الآن",
        style: TextStyle(
          fontSize: unitSize * 1.6,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
