import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_button.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class AddSupervisorPopUp extends StatefulWidget {
  const AddSupervisorPopUp({super.key, required this.onSave});

  final Future<void> Function() onSave;

  @override
  State<AddSupervisorPopUp> createState() => _AddSupervisorPopUpState();
}

class _AddSupervisorPopUpState extends State<AddSupervisorPopUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false;
  String? error;

  Future<void> _submit() async {
    final name = nameController.text.trim();
    final code = int.tryParse(codeController.text.trim());

    if (name.isEmpty || code == null) {
      setState(() => error = 'Lütfen tüm alanları doğru şekilde doldurun.');
      return;
    }

    setState(() {
      error = null;
      isLoading = true;
    });

    try {
      final success = await StudentsApiHandler().addSupervisor(name, code);
      if (success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Danışman başarıyla eklendi.'),
              backgroundColor: AppColors.successColor,
            ),
          );
          await widget.onSave();
          Navigator.of(context).pop();
        }
      } else {
        setState(() => error = 'Danışman bulunamadı.');
      }
    } catch (_) {
      setState(() => error = 'Danışman eklenirken hata oluştu.');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MediumBodyText('Danışman Ekle', AppColors.titleColor),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Danışman adı:'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: codeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Danışman kodu:'),
              ),
              const SizedBox(height: 16),
              if (error != null)
                Text(error!, style: TextStyle(color: AppColors.dangerColor)),
                const SizedBox(height: 12),
                isLoading
                  ? CircularProgressIndicator()
                  : StyledButton(
                      onPressed: _submit,
                      child: SmallBodyText('Kaydet', AppColors.backgroundColor),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
