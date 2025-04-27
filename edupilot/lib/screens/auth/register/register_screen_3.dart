import 'package:edupilot/screens/auth/login/login_screen.dart';
import 'package:edupilot/screens/auth/register/register_screen_2.dart';
import 'package:edupilot/screens/auth/register/widgets/fav_lesson_pop_up.dart';
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
    required this.password,
    required this.phoneNumber,
    required this.avatarPath,
  });

  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String avatarPath;

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? _selectedGrade;
  final List<String> _favLessonIds = [];
  final TextEditingController _institutionController = TextEditingController();
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
                    title: '3: Okul ve Danışman Bilgiler',
                    infoButtonOnPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => RegisterInfoPopUp(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoRow(text: 'Bu alana okul ve danışman bilgilerinizi giriniz.'),
                              const SizedBox(height: 8),
                              InfoRow(text: 'Merak etme, okulunu ve danışmanını daha sonra ekleyebilirsin!'),
                              const SizedBox(height: 8),
                              InfoRow(text: 'Danışman bilgisi girmek zorunlu değil ancak danışman eklemek istersen her iki alanı da doldurman gerek!'),
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
                    pageNumber: 3,
                  ),
                  const SizedBox(height: 16),

                  _buildContainer([
                    _buildLabelWithAsterisk('Sınıfın:'),
                    DropdownButtonFormField<int>(
                      value: _selectedGrade,
                      decoration: _inputDecoration(),
                      hint: const Text("Sınıf seçiniz"),
                      items: List.generate(12, (index) => index + 1)
                          .map((grade) => DropdownMenuItem(
                                value: grade,
                                child: Text('$grade. Sınıf'),
                              ))
                          .toList(),
                      validator: (value) => value == null ? 'Lütfen bir sınıf seçiniz.' : null,
                      onChanged: (value) => setState(() => _selectedGrade = value),
                    ),
                    const SizedBox(height: 24),
                    _buildLabel('Okulunun İsmi:'),
                    TextFormField(
                      controller: _institutionController,
                      decoration: _inputDecoration(),
                    ),
                  ]),

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

                  _buildContainer([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LargeText('Favori Derslerini Seç', AppColors.textColor),
                        const SizedBox(height: 8),
                        XSmallBodyText('Seçtiğin dersler hızlı erişimde görüntülenecek', AppColors.titleColor),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: FilledButton(
                        onPressed: () async {
                          if (_selectedGrade == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('"Dersleri Gör" butonunu kullanmadan önce sınıf seçmeniz gerekiyor.'),
                                showCloseIcon: true,
                                duration: Duration(milliseconds: 1750),
                                backgroundColor: AppColors.dangerColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                              ),
                            );
                            return;
                          }
                          await showDialog<String>(
                            context: context,
                            builder: (context) => FavLessonPopUp(selectedGrade: _selectedGrade!),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: LargeText('Dersleri Gör', AppColors.backgroundColor),
                      ),
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
                                  )));
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

                              final supervisorName = _supervisorController.text.trim().isNotEmpty ? _supervisorController.text : null;
                              final supervisorCode = _supervisorCodeController.text.trim().isNotEmpty ? int.tryParse(_supervisorCodeController.text) : null;

                              StudentsApiHandler().registerStudent(
                                widget.firstName,
                                widget.middleName,
                                widget.lastName,
                                _selectedGrade!,
                                widget.email,
                                widget.password,
                                widget.phoneNumber,
                                widget.avatarPath,
                                _favLessonIds,
                                supervisorName,
                                supervisorCode,
                                ).then((response) {
                                  if (response.status == 201) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Kayıt işlemi başarılı!'),
                                        showCloseIcon: true,
                                        duration: Duration(milliseconds: 1750),
                                        backgroundColor: AppColors.successColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                                      ),
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                                      (route) => false,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Kayıt işlemi başarısız!'),
                                        showCloseIcon: true,
                                        duration: Duration(milliseconds: 1750),
                                        backgroundColor: AppColors.dangerColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                                      ),
                                    );
                                  }
                                });
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: XLargeText('Kayıt Ol', AppColors.backgroundColor),
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

  Widget _buildLabelWithAsterisk(String text) => Row(children: [
        LargeText(text, AppColors.textColor),
        const SizedBox(width: 4),
        LargeText('*', AppColors.dangerColor),
      ]);

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
