import 'package:edupilot/screens/supervisor/home/supervisor_home_screen.dart';
import 'package:edupilot/services/supervisors_api_handler.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class SupervisorLoginScreen extends StatefulWidget {
  const SupervisorLoginScreen({super.key});

  @override
  State<SupervisorLoginScreen> createState() => _SupervisorLoginScreenState();
}

class _SupervisorLoginScreenState extends State<SupervisorLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Header with stacked logo and title
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(75),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                      ),
                      child: Text(
                        'Giriş Sayfası',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.backgroundColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(75),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/img/logo/logo_horizontal.png',
                        height: 60,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildInputCard([
                        _buildTextField('E-Posta Adresin', '*', _emailController, keyboardType: TextInputType.emailAddress),
                        _buildTextField('Parolan', '*', _passwordController, obscureText: true),
                      ]),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            
                            if (_formKey.currentState!.validate()) {
                              try {
                                if (await SupervisorsApiHandler().loginSupervisor(email, password)) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Giriş başarılı!'), 
                                    backgroundColor: AppColors.successColor,
                                  ));
                                  await Future.delayed(const Duration(milliseconds: 500));
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context) => const SupervisorHomeScreen()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar
                                  (content: Text('Giriş başarısız!'),
                                    backgroundColor: AppColors.dangerColor,
                                  ));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Giriş başarısız: $e'),
                                  backgroundColor: AppColors.dangerColor
                                ));
                              }
                            }
                          },
                          child: Text(
                            'Giriş Yap',
                            style: TextStyle(color: AppColors.backgroundColor, fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(color: AppColors.backgroundAccent),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(75),
            blurRadius: 4,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: children.map((e) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: e)).toList(),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String requiredMark,
    TextEditingController controller, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
              fontSize: 16,
            ),
            children: [
              if (requiredMark == '*')
                TextSpan(
                  text: '*',
                  style: TextStyle(color: AppColors.dangerColor),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.backgroundAccent,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.backgroundAccent,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          validator: (value) {
            if (requiredMark == '*' && (value == null || value.isEmpty)) {
              return '$label zorunludur';
            }
            return null;
          },
        ),
      ],
    );
  }
}
