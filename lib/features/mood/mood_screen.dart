import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../home/home_screen.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          "How are you feeling?",
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              "You just completed a focus session 🎉",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 40),

            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                _moodButton(context, "😄"),
                _moodButton(context, "😊"),
                _moodButton(context, "😐"),
                _moodButton(context, "😔"),
                _moodButton(context, "😴"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _moodButton(BuildContext context, String emoji) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 34),
          ),
        ),
      ),
    );
  }
}