import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../house/domain/entities/house.dart';
import '../../../house/presentation/screens/house_settings_screen.dart';
import '../../../house/presentation/viewmodels/house_controller.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final houseState = ref.watch(houseNotifierProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: houseState.when(
          data: (house) => house == null
              ? const _WelcomeView()
              : _HouseDashboardView(house: house),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _ErrorView(
            onRetry: () =>
                ref.read(houseNotifierProvider.notifier).refresh(),
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
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor.withOpacity(0.1),
            theme.scaffoldBackgroundColor,
            theme.scaffoldBackgroundColor,
          ],
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Icon(
              Icons.home_work_outlined,
              size: 120,
              color: theme.primaryColor,
            )
                .animate()
                .scale(
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                )
                .then()
                .shimmer(
                  duration: 1200.ms,
                  color: theme.primaryColor.withOpacity(0.5),
                ),
            const SizedBox(height: 24),
            Text(
              'EvArkadaşım\'a Hoş Geldin',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColorDark,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ev arkadaşlarınızla ortak giderlerinizi ve evinizi kolayca yönetin.',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => context.router.pushNamed('/house/create'),
              child: const Text('Yeni Ev Oluştur'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => context.router.pushNamed('/house/join'),
              child: const Text('Mevcut Eve Katıl'),
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
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            theme.primaryColor.withOpacity(0.1),
            theme.primaryColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.home_filled,
                    color: theme.primaryColor,
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
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${house.memberCount} ev arkadaşı',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
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
                          Icon(Icons.settings_outlined),
                          SizedBox(width: 8),
                          Text('Ev Ayarları'),
                        ],
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.vpn_key_outlined,
                    color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Ev Kodu:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Text(
                        house.code,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => _copyHouseCode(context, house.code),
                        borderRadius: BorderRadius.circular(24),
                        child: const Icon(Icons.copy, size: 20),
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
    // TODO: Gerçek paylaşım için share_plus paketi kullanılabilir.
    Clipboard.setData(ClipboardData(text: houseCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ev kodu kopyalandı! Arkadaşlarınızla paylaşabilirsiniz.'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.blueAccent,
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
        'color': Colors.green,
        'onTap': () => context.router.pushNamed('/expenses/add'),
      },
      {
        'title': 'Harcamaları Gör',
        'subtitle': 'Bakiyeleri inceleyin',
        'icon': Icons.receipt_long_outlined,
        'color': Colors.blue,
        'onTap': () => context.router.pushNamed('/expenses'),
      },
      {
        'title': 'Ev Kodunu Paylaş',
        'subtitle': 'Arkadaşlarını davet et',
        'icon': Icons.share_outlined,
        'color': Colors.orange,
        'onTap': () => _shareHouseCode(context),
      },
      {
        'title': 'Ayarlar',
        'subtitle': 'Ev ayarlarını düzenle',
        'icon': Icons.settings_outlined,
        'color': Colors.purple,
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
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.3),
              Theme.of(context).cardColor,
            ],
            center: const Alignment(-1.2, -1.5),
            radius: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const Spacer(),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
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
            Icon(
              Icons.cloud_off,
              size: 80,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 24),
            Text(
              'Bir Hata Oluştu',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Veriler yüklenirken bir sorun oluştu. Lütfen internet bağlantınızı kontrol edin ve tekrar deneyin.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Yeniden Dene'),
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