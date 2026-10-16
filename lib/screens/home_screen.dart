import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/coin_chip.dart';
import '../widgets/game_tile.dart';
import '../widgets/khelox_app_bar.dart';

/// Home = FREE ZONE
class HomeScreen extends StatelessWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final games = <(String, IconData, Color)>[
      ('Spin Wheel', Icons.album_rounded, AppColors.gold),
      ('Scratch Card', Icons.confirmation_number_rounded, AppColors.cyan),
      ('Captcha', Icons.verified_user_rounded, const Color(0xFF6FB3A8)),
      ('Daily Check-in', Icons.event_available_rounded, AppColors.gold),
      ('Surveys', Icons.poll_rounded, AppColors.cyan),
    ];

    return Scaffold(
      appBar: kheloxAppBar(
        actions: [CoinChip(type: CoinType.fcoin, value: user.fcoin)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ZoneHeader(
            title: 'FREE ZONE',
            subtitle: 'Play free games and earn Fcoin',
            color: AppColors.gold,
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.0,
            children: [
              for (final g in games)
                GameTile(
                  title: g.$1,
                  icon: g.$2,
                  color: g.$3,
                  onTap: () => showMsg(context, '${g.$1} - coming soon'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}