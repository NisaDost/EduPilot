import 'package:edupilot/screens/auth/register/register_screen_1.dart';
import 'package:edupilot/screens/auth/register/register_screen_3.dart';
import 'package:edupilot/screens/auth/register/widgets/register_info_pop_up.dart';
import 'package:edupilot/screens/auth/register/widgets/register_loadout.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();

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
                title: '2: Kullanıcı Bilgiler',
                infoButtonOnPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => RegisterInfoPopUp(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoRow(
                            text: 'Bu alana kullanıcı bilgilerinizi giriniz.',
                          ),
                          const SizedBox(height: 8),
                          InfoRow(
                            text: 'Avatarını daha sonradan değiştirebilirsin. Merak etme!'
                          ),
                          const SizedBox(height: 8),
                          InfoRow(
                            leading: StyledText('*', AppColors.dangerColor),
                            text: 'ile işaretli alanların doldurulması zorunludur.'
                          ),
                        ],
                      )
                    ),
                  );
                },
                pageNumber: 2,
              ),
              // content

              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen1()));
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen3()));
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
            ]
          )
        )
      )
    );
  }
}