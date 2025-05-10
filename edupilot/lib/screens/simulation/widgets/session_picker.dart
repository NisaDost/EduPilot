import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class SessionPicker extends StatefulWidget {
  final Function(int) onSessionCountChanged;

  const SessionPicker({
    super.key,
    required this.onSessionCountChanged,
  });

  @override
  _SessionPickerState createState() => _SessionPickerState();
}

class _SessionPickerState extends State<SessionPicker> {
  late FixedExtentScrollController _wheelController;
  int _selectedSession = 1;

  @override
  void initState() {
    super.initState();
    _wheelController = FixedExtentScrollController(initialItem: _selectedSession - 1);
  }

  @override
  void dispose() {
    _wheelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.secondaryAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: MediumBodyText(
              'Kaç seans boyunca çalışmak istiyorsun?',
              AppColors.backgroundColor,
              maxLines: 2,
            ),
          ),
          Container(
            width: 70,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListWheelScrollView.useDelegate(
              controller: _wheelController,
              itemExtent: 40,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedSession = index + 1;
                });
                widget.onSessionCountChanged(index + 1);
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= 5) return null;
                  return Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
