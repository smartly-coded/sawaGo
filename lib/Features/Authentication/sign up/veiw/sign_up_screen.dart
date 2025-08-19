import 'package:flutter/material.dart';
import 'package:sawago/Core/Utils/Validation.dart';
import 'package:sawago/Features/Authentication/controller/auth_controller.dart';
import 'package:sawago/Features/Authentication/login/veiw/buttons_google_facebook.dart';
import 'package:sawago/Features/Authentication/login/veiw/customTextField.dart';
import 'package:sawago/Features/Authentication/model/User_Model.dart' as AppUser;

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;

  double _responsiveHeight(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  double _responsiveWidth(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 20 : _responsiveWidth(10, context),
              vertical: isLandscape ? 10 : _responsiveHeight(2, context),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          height:
                              isLandscape ? 20 : _responsiveHeight(5, context)),
                      Center(
                        child: Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF01301B),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          "مرحباً، أهلاً بعودتك لقد افتقدناك",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            color: const Color(0xFF656565),
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              isLandscape ? 15 : _responsiveHeight(3, context)),
                      CustomTextField(
                        controller: _emailController,
                        label: 'البريد الإلكتروني',
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(
                          height:
                              isLandscape ? 15 : _responsiveHeight(2, context)),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'كلمة المرور',
                        isPassword: _obscurePassword,
                        validator: Validators.validatePassword,
                      ),
                      SizedBox(
                          height:
                              isLandscape ? 15 : _responsiveHeight(2, context)),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        label: 'تأكيد كلمة المرور',
                        isPassword: _obscureConfirmPassword,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'كلمة المرور غير متطابقة';
                          }
                          return Validators.validatePassword(value);
                        },
                      ),
                      SizedBox(
                          height:
                              isLandscape ? 20 : _responsiveHeight(3, context)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF01301B),
                          padding: EdgeInsets.symmetric(
                            vertical: isSmallScreen ? 15 : 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            AppUser.User user = AppUser.User(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );

                            final _authController = AuthController();

                            await _authController.signup(user, context);
                          }
                        },
                        child: Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              isLandscape ? 20 : _responsiveHeight(3, context)),
                      const SocialLoginButtons(),
                      SizedBox(
                          height:
                              isLandscape ? 15 : _responsiveHeight(2, context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                color: const Color(0xFF01301B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'لديك حساب؟',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              color: const Color(0xFF656565),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height:
                              isLandscape ? 10 : _responsiveHeight(2, context)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
