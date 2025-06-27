
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../house/domain/entities/house.dart';
import '../../../house/presentation/screens/house_settings_screen.dart';
import '../../../house/presentation/viewmodels/house_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final houseState = ref.watch(houseNotifierProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: houseState.when(
          data: (house) => house == null
              ? const _WelcomeView()
              : _HouseDashboardView(house: house),
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (error, stack) => _ErrorView(
            onRetry: () => ref.read(houseNotifierProvider.notifier).refresh(),
          ),
        ),
      ),
    );
  }
}

class _WelcomeView extends StatelessWidget {
  const _WelcomeView();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundLight,
            AppColors.surfaceLight,
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.home_work_outlined,
                size: 80,
                color: AppColors.primary,
              ),
            )
                .animate()
                .scale(
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                )
                .then()
                .shimmer(
                  duration: 1200.ms,
                  color: AppColors.primary.withOpacity(0.5),
                ),
            const SizedBox(height: 32),
            Text(
              'EvArkadaşım\'a Hoş Geldin',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ev arkadaşlarınızla ortak giderlerinizi ve evinizi kolayca yönetin.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondaryLight,
                height: 1.5,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                elevation: 0,
                shadowColor: AppColors.primary.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/house/create'),
              child: const Text(
                'Yeni Ev Oluştur',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/house/join'),
              child: const Text(
                'Mevcut Eve Katıl',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
          ]
              .animate(interval: 100.ms)
              .fadeIn(duration: 400.ms, delay: 200.ms)
              .slideY(begin: 0.5, curve: Curves.easeOut),
        ),
      ),
    );
  }
}

class _HouseDashboardView extends StatelessWidget {
  const _HouseDashboardView({required this.house});
  final House house;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HouseHeader(house: house),
            const SizedBox(height: 32),
            Text(
              'Hızlı Eylemler',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _ActionGrid(houseCode: house.code),
          ],
        ).animate().fadeIn(duration: 500.ms, curve: Curves.easeIn),
      ),
    );
  }
}

class _HouseHeader extends StatelessWidget {
  const _HouseHeader({required this.house});
  final House house;

  void _copyHouseCode(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ev kodu kopyalandı: $code'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: AppColors.cardShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.home_filled,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        house.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${house.memberCount} ev arkadaşı',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'settings') {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HouseSettingsScreen(),
                      ));
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'settings',
                      child: Row(
                        children: [
                          Icon(Icons.settings_outlined, color: AppColors.textSecondaryLight),
                          SizedBox(width: 8),
                          Text('Ev Ayarları'),
                        ],
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert, color: AppColors.textSecondaryLight),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: AppColors.dividerLight),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.vpn_key_outlined,
                  color: AppColors.textSecondaryLight,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Ev Kodu:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        house.code,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          fontFamily: 'monospace',
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => _copyHouseCode(context, house.code),
                        borderRadius: BorderRadius.circular(24),
                        child: const Icon(
                          Icons.copy,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.houseCode});
  final String houseCode;

  void _shareHouseCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: houseCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ev kodu kopyalandı! Arkadaşlarınızla paylaşabilirsiniz.'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: AppColors.info,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        'title': 'Harcama Ekle',
        'subtitle': 'Yeni bir ortak harcama',
        'icon': Icons.add_shopping_cart_outlined,
        'color': AppColors.success,
        'onTap': () => Navigator.of(context).pushNamed('/expenses/add'),
      },
      {
        'title': 'Harcamaları Gör',
        'subtitle': 'Bakiyeleri inceleyin',
        'icon': Icons.receipt_long_outlined,
        'color': AppColors.info,
        'onTap': () => Navigator.of(context).pushNamed('/expenses'),
      },
      {
        'title': 'Ev Kodunu Paylaş',
        'subtitle': 'Arkadaşlarını davet et',
        'icon': Icons.share_outlined,
        'color': AppColors.warning,
        'onTap': () => _shareHouseCode(context),
      },
      {
        'title': 'Ayarlar',
        'subtitle': 'Ev ayarlarını düzenle',
        'icon': Icons.settings_outlined,
        'color': AppColors.secondary,
        'onTap': () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HouseSettingsScreen(),
            )),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return _ActionCard(
          title: action['title'] as String,
          subtitle: action['subtitle'] as String,
          icon: action['icon'] as IconData,
          color: action['color'] as Color,
          onTap: action['onTap'] as VoidCallback,
        ).animate().scaleXY(delay: (100 * index).ms, duration: 300.ms, curve: Curves.easeOut).fadeIn();
      },
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.cardLight,
          border: Border.all(
            color: AppColors.borderLight,
            width: 0.5,
          ),
          boxShadow: AppColors.cardShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const Spacer(),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cloud_off,
                size: 64,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Bir Hata Oluştu',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Veriler yüklenirken bir sorun oluştu. Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Yeniden Dene'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.2, curve: Curves.easeOut),
      ),
    );
  }
} 