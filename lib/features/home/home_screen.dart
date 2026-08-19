import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../services/storage_service.dart';
import 'widgets/greeting_card.dart';
import 'widgets/today_focus_card.dart';
import 'widgets/quote_card.dart';
import 'widgets/home_timer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final name = await StorageService.getUserName();

    setState(() {
      userName = name ?? "Friend";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GreetingCard(userName: userName),

              const SizedBox(height: 30),

              const HomeTimerSection(),

              const SizedBox(height: 20),

              const TodayFocusCard(),

              const SizedBox(height: 20),

              const QuoteCard(),

            ],
          ),
        ),
      ),
    );
  }
}