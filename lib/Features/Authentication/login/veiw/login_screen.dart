import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Core/Utils/Validation.dart';
import 'package:sawago/Features/Authentication/controller/auth_controller.dart';
import 'package:sawago/Features/Authentication/controller/auth_state.dart';
import 'package:sawago/Features/Authentication/login/veiw/buttons_google_facebook.dart';
import 'package:sawago/Features/Authentication/login/veiw/customTextField.dart';
import 'package:sawago/Features/Authentication/model/User_Model.dart'
    as AppUser;
import 'package:sawago/Repo/auth_repository.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  double _responsiveHeight(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  double _responsiveWidth(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocProvider(
      create: (_) => AuthCubit(AuthRepository()), 
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  Navigator.of(context, rootNavigator: true).pop(); // close dialog لو مفتوح
                }

                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
                  );
                  Navigator.pushReplacementNamed(context, '/');
                }

                if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                final authCubit = context.read<AuthCubit>();
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        isSmallScreen ? 20 : _responsiveWidth(10, context),
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
                                height: isLandscape
                                    ? 20
                                    : _responsiveHeight(5, context)),
                            Center(
                              child: Text(
                                'تسجيل الدخول',
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
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF656565),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: isLandscape
                                    ? 15
                                    : _responsiveHeight(3, context)),
                            CustomTextField(
                              controller: _emailController,
                              label: 'البريد الإلكتروني',
                              keyboardType: TextInputType.emailAddress,
                              validator: Validators.validateEmail,
                            ),
                            SizedBox(
                                height: isLandscape
                                    ? 15
                                    : _responsiveHeight(2, context)),
                            CustomTextField(
                              controller: _passwordController,
                              label: 'كلمة المرور',
                              isPassword: _obscurePassword,
                              validator: Validators.validatePassword,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/forgetPassword');
                                },
                                child: Text(
                                  'هل نسيت كلمة المرور؟',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    color: const Color(0xFF01301B),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: isLandscape
                                    ? 15
                                    : _responsiveHeight(2, context)),
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final user = AppUser.UserModel(
                                    email: _emailController.text,
                                    password: _passwordController.text, 
                                  );
                                  authCubit.login(user); // ✅ استخدام الكيوبت
                                }
                              },
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16 : 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: isLandscape
                                    ? 20
                                    : _responsiveHeight(4, context)),
                            SocialLoginButtons(
                              onGoogleTap: () =>
                                  authCubit.signInWithGoogle(),
                              onFacebookTap: () =>
                                  authCubit.signInWithFacebook(),
                            ),
                            SizedBox(
                                height: isLandscape
                                    ? 15
                                    : _responsiveHeight(2, context)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/signup');
                                  },
                                  child: Text(
                                    'إنشاء حساب',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 14 : 16,
                                      color: const Color(0xFF01301B),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' ليس لديك حساب؟',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    color: const Color(0xFF656565),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: isLandscape
                                    ? 10
                                    : _responsiveHeight(2, context)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
