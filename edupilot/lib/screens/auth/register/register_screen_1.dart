import 'package:edupilot/screens/auth/register/register_screen_2.dart';
import 'package:edupilot/screens/auth/register/widgets/register_info_pop_up.dart';
import 'package:edupilot/screens/auth/register/widgets/register_loadout.dart';
import 'package:edupilot/screens/auth/welcome_screen.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({super.key});

  @override
  State<RegisterScreen1> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: AppColors.backgroundAccent,
          child: Column(
            children: [
              RegisterLoadout(
                title: '1: Kişisel Bilgiler',
                infoButtonOnPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => RegisterInfoPopUp(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoRow(
                            text: 'Bu alana kişisel bilgilerinizi giriniz.',
                          ),
                          SizedBox(height: 8),
                          InfoRow(
                            leading: StyledText('*', AppColors.dangerColor),
                            text: 'ile işaretli alanların doldurulması zorunludur.'
                          ),
                        ],
                      )
        
                    ),
                  );
                },
                pageNumber: 1,
              ),
              const SizedBox(height: 16),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 4, // How soft the shodow is
                      offset: Offset(0, 4), // Horizontal & Vertical offset
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      // ad
                      Row(
                        children: [
                          StyledHeading('Adın', AppColors.textColor),
                          const SizedBox(height: 4),
                          StyledHeading('*', AppColors.dangerColor),
                        ],
                      ),
                      TextFormField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.text,
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
                            return 'Lütfen isminizi giriniz.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
        
                      // ikinci isim
                      Row(
                        children: [
                          StyledHeading('İkinci Adın', AppColors.textColor),
                        ],
                      ),
                      TextFormField(
                        controller: _middleNameController,
                        keyboardType: TextInputType.text,
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
                      ),
                      const SizedBox(height: 24),
        
                      // soyad
                      Row(
                        children: [
                          StyledHeading('Soydın', AppColors.textColor),
                          const SizedBox(height: 4),
                          StyledHeading('*', AppColors.dangerColor),
                        ],
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.text,
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
                            return 'Lütfen soyadınızı giriniz.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 36),
                child: Row(
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
                      child: StyledLargeTitle('Geri', AppColors.backgroundColor)
                    ),
                    FilledButton(
                      onPressed: () async {
                        // alttaki bilgiler sırayla 2. ve 3. register ekranına gönderilecek ve kayıt orda yapılacak.
                        // final firstName = _firstNameController.text.trim();
                        // final middleName = _middleNameController.text.trim();
                        // final lastName = _lastNameController.text.trim();

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen2()));
                          });
                        }
                      }, 
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 54, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: StyledLargeTitle('İleri', AppColors.backgroundColor)
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
