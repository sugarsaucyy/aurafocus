import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

class PlantWidget extends StatelessWidget {
  final int sessions;

  const PlantWidget({super.key, required this.sessions});

  String getPlantEmoji() {
    if (sessions == 0) {
      return "🪴";
    } else if (sessions < 5) {
      return "🌱";
    } else if (sessions < 15) {
      return "🌿";
    } else if (sessions < 30) {
      return "🌾";
    } else {
      return "🌳";
    }
  }

  String getPlantTitle() {
    if (sessions == 0) {
      return "Empty Pot";
    } else if (sessions < 5) {
      return "Tiny Seedling";
    } else if (sessions < 15) {
      return "Growing Sprout";
    } else if (sessions < 30) {
      return "Young Plant";
    } else {
      return "Flourishing Tree";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(getPlantEmoji(), style: const TextStyle(fontSize: 90)),

          const SizedBox(height: 16),

          Text(
            getPlantTitle(),
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "$sessions Focus Sessions",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 22),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: (sessions % 5) / 5,
              minHeight: 12,
              backgroundColor: AppColors.secondaryBackground,
              valueColor: const AlwaysStoppedAnimation(AppColors.kombuGreen),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "${5 - (sessions % 5)} sessions until the next stage 🌿",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
