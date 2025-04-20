import 'package:edupilot/screens/auth/register/register_screen_2.dart';
import 'package:edupilot/screens/auth/register/widgets/register_info_pop_up.dart';
import 'package:edupilot/screens/auth/register/widgets/register_loadout.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class RegisterScreen3 extends StatefulWidget {
  const RegisterScreen3({super.key});

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 

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
                title: '3: Okul ve Danışman Bilgiler',
                infoButtonOnPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => RegisterInfoPopUp(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoRow(text: 'Bu alana kullanıcı bilgilerinizi giriniz.'),
                          const SizedBox(height: 8),
                          InfoRow(text: 'Merak etme, okulunu ve danışmanlarını daha sonra ekleyebilirsin!'),
                          const SizedBox(height: 8),
                          InfoRow(
                            leading: XSmallBodyText('*', AppColors.dangerColor),
                            text: 'ile işaretli alanların doldurulması zorunludur.'
                          ),
                        ],
                      )
                    ),
                  );
                },
                pageNumber: 3,
              ),


              // Buttons
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen2()));
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primaryAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: XLargeText('Geri', AppColors.backgroundColor),
                    ),
                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const RegisterScreen3()));
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: XLargeText('Kaydol', AppColors.backgroundColor),
                    ),
                  ],
                ),
              ),
            ]
          )
        )
      )
    );
  }
}