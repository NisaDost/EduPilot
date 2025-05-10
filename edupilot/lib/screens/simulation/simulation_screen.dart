import 'dart:async';
import 'package:edupilot/models/dtos/simulation_dto.dart';
import 'package:edupilot/screens/simulation/widgets/session_picker.dart';
import 'package:edupilot/screens/simulation/widgets/simulation_is_success_pop_up.dart';
import 'package:edupilot/services/simulations_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  SimulationDTO? _selectedSimulation;
  int _selectedSessionCount = 1;
  int _remainingSession = 0;
  Duration _remainingTime = Duration.zero;
  Timer? _timer;
  bool _isBreak = false;
  bool _isRunning = false;
  final ValueNotifier<Duration> _timeNotifier = ValueNotifier(Duration.zero);

  @override
  void dispose() {
    _timer?.cancel();
    _timeNotifier.dispose();
    super.dispose();
  }

  Future<void> _playAlertSound() async {
    await _audioPlayer.play(AssetSource('sounds/alert.mp3')).catchError((error) {
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inHours)} : ${twoDigits(duration.inMinutes.remainder(60))} : ${twoDigits(duration.inSeconds.remainder(60))}';
  }

  void _startTimer() {
    if (_selectedSimulation == null) return;

    setState(() {
      _isRunning = true;
      _remainingSession = _selectedSessionCount;
      _isBreak = false;
      _remainingTime = Duration(minutes: _selectedSimulation!.studyDuration);
      _timeNotifier.value = _remainingTime;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_remainingTime.inSeconds > 0) {
        // Avoid setState here to prevent screen flickering
        _remainingTime -= const Duration(seconds: 1);
        _timeNotifier.value = _remainingTime;
      } else {
        if (!_isBreak && _selectedSimulation!.breakDuration > 0) {
          // Call setState only on break switch
          setState(() {
            _isBreak = true;
            _remainingTime = Duration(minutes: _selectedSimulation!.breakDuration);
            _timeNotifier.value = _remainingTime;
          });
          await _playAlertSound();
        } else {
          _remainingSession--;
          if (_remainingSession > 0) {
            // Call setState only on study switch
            setState(() {
              _isBreak = false;
              _remainingTime = Duration(minutes: _selectedSimulation!.studyDuration);
              _timeNotifier.value = _remainingTime;
            });
            await _playAlertSound();
          } else {
            timer.cancel();
            setState(() {
              _isRunning = false;
            });
            SimulationIsSuccessPopUp.show(context, () async {
              await SimulationsApiHandler().postStudiedSimulation(_selectedSimulation!.id);
            });

          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 92;

    return FutureBuilder<List<SimulationDTO>>(
      future: SimulationsApiHandler().getSimulations(),
      builder: (BuildContext context, AsyncSnapshot<List<SimulationDTO>> simulationSnapshot) {
        if (simulationSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (simulationSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${simulationSnapshot.error}'));
        } else if (!simulationSnapshot.hasData || simulationSnapshot.data!.isEmpty) {
          return const Center(child: Text('Simülasyon bulunamadı.'));
        }

        final simulations = simulationSnapshot.data!;

        return Scaffold(
          backgroundColor: AppColors.primaryAccent,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: topBarHeight),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: MediumBodyText(
                                'Bir çalışma tekniği ya da sınav seç...',
                                AppColors.titleColor,
                              ),
                              value: _selectedSimulation?.id,
                              items: simulations.map((sim) {
                                return DropdownMenuItem(
                                  value: sim.id,
                                  child: MediumText(sim.name, AppColors.titleColor),
                                );
                              }).toList(),
                              onChanged: _isRunning
                                ? null
                                : (value) {
                                    final selected = simulations.firstWhere((sim) => sim.id == value);
                                    setState(() {
                                      _selectedSimulation = selected;
                                      _remainingTime = Duration(minutes: selected.studyDuration);
                                      _timeNotifier.value = _remainingTime;
                                      _selectedSessionCount = selected.breakDuration > 0 ? 1 : 0;
                                      _remainingSession = 0; // Reset
                                    });
                                  },
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Session Picker or Remaining Sessions
                        if (_selectedSimulation != null)
                          _isRunning
                              ? Column(
                                children: [
                                  if (_selectedSimulation!.breakDuration > 0)
                                    Text(
                                      'Kalan seanslar: ${_remainingSession - 1}',
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: _isBreak ? AppColors.primaryColor : AppColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      _isBreak ? 'Dinlenme Zamanı' : 'Çalışma Zamanı',
                                      style: const TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ],
                              )
                              : (_selectedSimulation!.breakDuration > 0
                                  ? SessionPicker(
                                      onSessionCountChanged: (count) {
                                        _selectedSessionCount = count;
                                      },
                                    )
                                  : const SizedBox()),

                        const SizedBox(height: 32),

                        // Static upper text
                        const Text(
                          'Süre bitmeden simülasyonu durduramazsın!',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 36),

                        // Timer
                        ValueListenableBuilder<Duration>(
                          valueListenable: _timeNotifier,
                          builder: (context, value, _) {
                            return Text(
                              formatDuration(
                                _selectedSimulation == null ? Duration.zero : value,
                              ),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 24),

                        // Start Button
                        TextButton(
                          onPressed: _isRunning || _selectedSimulation == null ? null : _startTimer,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: _isRunning || _selectedSimulation == null
                                  ? Colors.grey
                                  : AppColors.secondaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.timer, color: AppColors.backgroundColor, size: 64),
                                  const SizedBox(height: 8),
                                  MediumBodyText('Başla', AppColors.backgroundColor),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Bottom static text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmallBodyText('Konsantre ol...', AppColors.backgroundColor),
                          ],
                        ),

                        const SizedBox(height: 64),
                      ],
                    ),
                  ),
                ),
              ),

              // Top bar
              Container(
                height: topBarHeight,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeBodyText('Simülasyon', AppColors.successColor),
                    const SizedBox(height: 10),
                    SmallBodyText('Zamana karşı yarışalım!', AppColors.titleColor),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}