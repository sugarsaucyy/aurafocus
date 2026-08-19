import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../focus/session_complete_screen.dart';
import 'package:provider/provider.dart';

import '../../../services/session_service.dart';

class HomeTimerSection extends StatefulWidget {
  const HomeTimerSection({super.key});

  @override
  State<HomeTimerSection> createState() => _HomeTimerSectionState();
}

class _HomeTimerSectionState extends State<HomeTimerSection> {
  final List<int> timerOptions = [15, 25, 45, 60];

  int selectedIndex = 1; // Starts at 25 minutes

  late int totalSeconds;
  late int remainingSeconds;
  bool isRunning = false;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    totalSeconds = timerOptions[selectedIndex] * 60;
    remainingSeconds = totalSeconds;
  }

  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void increaseTime() {
    if (isRunning) return;

    if (selectedIndex < timerOptions.length - 1) {
      setState(() {
        selectedIndex++;
        totalSeconds = timerOptions[selectedIndex] * 60;
        remainingSeconds = totalSeconds;
      });
    }
  }

  void decreaseTime() {
    if (isRunning) return;

    if (selectedIndex > 0) {
      setState(() {
        selectedIndex--;
        totalSeconds = timerOptions[selectedIndex] * 60;
        remainingSeconds = totalSeconds;
      });
    }
  }

  void startTimer() {
    if (isRunning) return;
    final sessionService = context.read<SessionService>();

    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();

        await sessionService.completeSession(timerOptions[selectedIndex]);
        await sessionService.increaseStreak();

        if (!mounted) return;

        setState(() {
          isRunning = false;
          remainingSeconds = totalSeconds;
        });

        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SessionCompleteScreen()),
        );
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      remainingSeconds = totalSeconds;
      isRunning = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text(
            "Focus Time",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: 280,
            height: 280,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 400),
                    tween: Tween<double>(
                      begin: 1,
                      end: remainingSeconds / totalSeconds,
                    ),
                    builder: (context, value, child) {
                      return CircularProgressIndicator(
                        value: value,
                        strokeWidth: 12,
                        backgroundColor: AppColors.secondaryBackground,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.kombuGreen,
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.eco,
                        size: 45,
                        color: AppColors.kombuGreen,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        formattedTime,
                        style: GoogleFonts.poppins(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Stay present.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: decreaseTime,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: AppColors.kombuGreen,
                    size: 26,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  "${timerOptions[selectedIndex]} min",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.kombuGreen,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              GestureDetector(
                onTap: increaseTime,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.kombuGreen,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton(
              onPressed: () {
                if (isRunning) {
                  pauseTimer();
                } else {
                  startTimer();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kombuGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                isRunning ? "Pause Focus" : "Start Focus",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            "One focused session at a time 🌱",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
