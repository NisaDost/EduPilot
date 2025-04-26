import 'package:edupilot/screens/auth/welcome_screen.dart';
import 'package:edupilot/screens/main/main_screen.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: AppColors.backgroundAccent,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 4, // How soft the shodow is
                      offset: Offset(0, 4), // Horizontal & Vertical offset
                    ),
                  ],
                  color: AppColors.primaryColor
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                        color: AppColors.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 4, // How soft the shodow is
                            offset: Offset(0, 4), // Horizontal & Vertical offset
                          ),
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 54),
                        child: Image.asset('assets/img/logo/logo_horizontal.png', height: 48),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: XLargeText('Giriş Yap', AppColors.backgroundColor),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12, top: 96, right: 12, bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: AppColors.backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Text side
                      Expanded(
                        child: CenterAlignedText('Seni tekrardan aramızda görmek ne güzel!', AppColors.textColor),
                      ),
                      const SizedBox(width: 12), // spacing between text and image
                      // Image side
                      Image.asset(
                        'assets/img/mascots/demo_mascot.png',
                        height: 100, // set size as needed
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: AppColors.backgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // email
                    MediumBodyText('E-Posta Adresin:', AppColors.textColor),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(217, 217, 217, 1),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.black.withValues(alpha: 0.25),
                            width: 1
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.dangerColor, // your custom error color
                            width: 1.5,
                          ),
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Lütfen e-posta adresinizi giriniz.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
      
                    // şifre
                    MediumBodyText('Parolan:', AppColors.textColor),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(217, 217, 217, 1),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.black.withValues(alpha: 0.25),
                            width: 1
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.dangerColor, // your custom error color
                            width: 1.5,
                          ),
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Lütfen şifrenizi giriniz.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
                    }, 
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryAccent,
                      padding: EdgeInsets.symmetric(horizontal: 54, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    child: XLargeText('Geri', AppColors.backgroundColor)
                  ),
                  FilledButton(
                    onPressed: () async {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      if (_formKey.currentState!.validate()) {
                        // Perform login action here
                        try {
                          // await FirestoreService().login(email, password);
                          // If login is successful, navigate to the main screen
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                        } catch (e) {
                          // Handle login error here
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Giriş başarısız: $e')));
                        }
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 54, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: XLargeText('Giriş', AppColors.backgroundColor),
                  )

                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}