import 'package:edupilot/screens/auth/login/login_screen.dart';
import 'package:edupilot/screens/auth/register/register_screen_2.dart';
import 'package:edupilot/screens/auth/register/widgets/register_info_pop_up.dart';
import 'package:edupilot/screens/auth/register/widgets/register_loadout.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class RegisterScreen3 extends StatefulWidget {
  const RegisterScreen3({
    super.key,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.grade,
    required this.favLessonIds,
    required this.password,
    required this.phoneNumber,
    required this.avatarPath,
  });

  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final int grade;
  final List<String> favLessonIds;
  final String password;
  final String phoneNumber;
  final String avatarPath;

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _supervisorController = TextEditingController();
  final TextEditingController _supervisorCodeController = TextEditingController();

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
                    title: '3: Danışman Bilgileri',
                    infoButtonOnPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => RegisterInfoPopUp(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoRow(text: 'Bu alana danışman bilgilerinizi giriniz.'),
                              const SizedBox(height: 8),
                              InfoRow(text: 'Merak etme, şimdilik sadece bir danışman ekleyebilirsin ancak sonra profilinden daha fazla danışman girebilirsin!'),
                              const SizedBox(height: 8),
                              InfoRow(text: 'Danışman bilgisi girmek zorunlu değil ancak danışman eklemek istersen her iki alanı da doldurman gerek!'),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                    pageNumber: 3,
                  ),
                  const SizedBox(height: 16),
                  _buildContainer([
                    _buildLabel('Danışman İsmi:'),
                    TextFormField(
                      controller: _supervisorController,
                      decoration: _inputDecoration(),
                      validator: (value) {
                        final nameFilled = value != null && value.trim().isNotEmpty;
                        final codeFilled = _supervisorCodeController.text.trim().isNotEmpty;
                        if (nameFilled != codeFilled) {
                          return 'Danışman alanları birlikte doldurulmalıdır.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildLabel('Danışman Kodu:'),
                    TextFormField(
                      controller: _supervisorCodeController,
                      decoration: _inputDecoration(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final codeFilled = value != null && value.trim().isNotEmpty;
                        final nameFilled = _supervisorController.text.trim().isNotEmpty;
                        if (codeFilled != nameFilled) {
                          return 'Danışman alanları birlikte doldurulmalıdır.';
                        }
                        return null;
                      },
                    ),
                  ]),

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
                                  builder: (context) => const RegisterScreen2(
                                    firstName: '',
                                    middleName: '',
                                    lastName: '',
                                    grade: 0,
                                    favLessonIds: [],
                                  )));
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primaryAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: LargeText('Geri', AppColors.backgroundColor),
                        ),
                        FilledButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {

                              final supervisorName = _supervisorController.text.trim().isNotEmpty ? _supervisorController.text : null;
                              final supervisorCode = _supervisorCodeController.text.trim().isNotEmpty ? int.tryParse(_supervisorCodeController.text) : null;

                              try {
                                if (await StudentsApiHandler().registerStudent(
                                  widget.firstName,
                                  widget.middleName,
                                  widget.lastName,
                                  widget.grade,
                                  widget.email,
                                  widget.password,
                                  widget.phoneNumber,
                                  widget.avatarPath,
                                  widget.favLessonIds,
                                  supervisorName,
                                  supervisorCode,
                                )) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Kayıt başarılı!'), 
                                  backgroundColor: AppColors.successColor,
                                ));
                                await Future.delayed(const Duration(milliseconds: 500));
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                                } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar
                                (content: Text('Kayıt başarısız!'),
                                  backgroundColor: AppColors.dangerColor,
                                ));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Bir hata oluştu: $e'),
                                  backgroundColor: AppColors.dangerColor,
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar
                                (content: Text('Kayıt başarısız!'),
                                  backgroundColor: AppColors.dangerColor,
                                ));
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: LargeText('Kayıt Ol', AppColors.backgroundColor),
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

  Widget _buildLabel(String text) => Row(children: [LargeText(text, AppColors.textColor)]);

  Widget _buildContainer(List<Widget> children) => Container(
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
        child: Column(children: children),
      );

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
