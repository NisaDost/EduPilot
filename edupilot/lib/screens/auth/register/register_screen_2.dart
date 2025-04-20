import 'package:edupilot/screens/auth/register/register_screen_1.dart';
import 'package:edupilot/screens/auth/register/register_screen_3.dart';
import 'package:edupilot/screens/auth/register/widgets/change_avatar_pop_up.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedAvatarPath = 'assets/img/avatar/avatar1.png';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
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
                              InfoRow(text: 'Bu alana kullanıcı bilgilerinizi giriniz.'),
                              const SizedBox(height: 8),
                              InfoRow(text: 'Merak etme, avatarını daha sonra değiştirebilirsin!'),
                              const SizedBox(height: 8),
                              InfoRow(
                                leading: XSmallBodyText('*', AppColors.dangerColor),
                                text: 'ile işaretli alanların doldurulması zorunludur.',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    pageNumber: 2,
                  ),
                  const SizedBox(height: 16),

                  // Form Container
                  Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          // E-posta
                          Row(
                            children: [
                              LargeText('E-Posta Adresin:', AppColors.textColor),
                              const SizedBox(width: 4),
                              LargeText('*', AppColors.dangerColor),
                            ],
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _inputDecoration(),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Lütfen e-postanızı giriniz.';
                              }
                              if (!value.contains('@')) {
                                return 'Lütfen geçerli bir e-posta giriniz.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Şifre
                          Row(
                            children: [
                              LargeText('Parolan:', AppColors.textColor),
                              const SizedBox(width: 4),
                              LargeText('*', AppColors.dangerColor),
                            ],
                          ),
                          TextFormField(
                            controller: _password1Controller,
                            obscureText: true,
                            decoration: _inputDecoration(),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Lütfen bir şifre giriniz.';
                              }
                              if (value.length < 8) {
                                return 'Lütfen en az 8 haneli bir şifre giriniz.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Şifre (Tekrar)
                          Row(
                            children: [
                              LargeText('Parolan (Tekrar):', AppColors.textColor),
                              const SizedBox(width: 4),
                              LargeText('*', AppColors.dangerColor),
                            ],
                          ),
                          TextFormField(
                            controller: _password2Controller,
                            obscureText: true,
                            decoration: _inputDecoration(),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Lütfen şifrenizi tekrar giriniz.';
                              }
                              if (value.length < 8) {
                                return 'Lütfen en az 8 haneli bir şifre giriniz.';
                              }
                              if (value != _password1Controller.text) {
                                return 'Girdiğin şifreler uyuşmuyor!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Telefon Numarası
                          Row(
                            children: [
                              LargeText('Telefon Numaran:', AppColors.textColor),
                              const SizedBox(width: 4),
                              LargeText('*', AppColors.dangerColor),
                            ],
                          ),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: _inputDecoration(),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Lütfen telefon numaranızı giriniz.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LargeText('Bir Avatar Seç', AppColors.textColor),
                              const SizedBox(height: 8),
                              XSmallBodyText('Bunu daha sonra profilinden değiştirebilirsin', AppColors.titleColor),
                              const SizedBox(height: 12),
                              FilledButton(
                                onPressed: () async {
                                  final selectedPath = await showDialog<String>(
                                    context: context,
                                    builder: (context) => ChangeAvatarPopUp(),
                                  );
                                  if (selectedPath != null) {
                                    setState(() {
                                      _selectedAvatarPath = selectedPath;
                                    });
                                  }
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.secondaryColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: LargeText('Değiştir', AppColors.backgroundColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                              _selectedAvatarPath,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  // Buttons
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
                                    builder: (context) => const RegisterScreen1()));
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const RegisterScreen3()));
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: XLargeText('İleri', AppColors.backgroundColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromRGBO(217, 217, 217, 1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.black.withAlpha(64), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.dangerColor, width: 1.5),
      ),
    );
  }
}
