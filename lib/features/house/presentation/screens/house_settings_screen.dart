import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../viewmodels/house_controller.dart';

@RoutePage()
class HouseSettingsScreen extends ConsumerStatefulWidget {
  const HouseSettingsScreen({super.key});

  @override
  ConsumerState<HouseSettingsScreen> createState() => _HouseSettingsScreenState();
}

class _HouseSettingsScreenState extends ConsumerState<HouseSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final houseState = ref.watch(houseNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ev Ayarları'),
      ),
      body: houseState.when(
        data: (house) {
          if (house == null) {
            return const Center(
              child: Text('Ev bulunamadı'),
            );
          }
          return _buildSettingsContent(context, house);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Hata: $error'),
        ),
      ),
    );
  }
  
  Widget _buildSettingsContent(BuildContext context, house) {
    return ListView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      children: [
        // Ev Bilgileri Kartı
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Ev Bilgileri',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  context,
                  label: 'Ev Adı',
                  value: house.name,
                  icon: Icons.home_outlined,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  context,
                  label: 'Ev Kodu',
                  value: house.code,
                  icon: Icons.key,
                  trailing: IconButton(
                    onPressed: () => _copyHouseCode(context, house.code),
                    icon: const Icon(Icons.copy),
                    tooltip: 'Kopyala',
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  context,
                  label: 'Üye Sayısı',
                  value: '${house.memberCount} kişi',
                  icon: Icons.people,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  context,
                  label: 'Oluşturulma',
                  value: _formatDate(house.createdAt),
                  icon: Icons.calendar_today,
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Ev İşlemleri
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Ev Adını Düzenle'),
                subtitle: const Text('Ev ismini değiştirin'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showEditHouseNameDialog(context, house.name),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.people, color: Colors.green),
                title: const Text('Üyeleri Görüntüle'),
                subtitle: const Text('Ev arkadaşlarının listesi'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // TODO: Üyeler listesi ekranına git
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Üye listesi yakında!')),
                  );
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.orange),
                title: const Text('Ev Kodunu Paylaş'),
                subtitle: const Text('Arkadaşlarınızı davet edin'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _shareHouseCode(context, house.code),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Tehlikeli İşlemler
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text('Evden Ayrıl'),
                subtitle: const Text('Bu evden ayrılmak istiyorsanız'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showLeaveHouseDialog(context),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('Evi Sil'),
                subtitle: const Text('Evi tamamen silmek istiyorsanız'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showDeleteHouseDialog(context),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 32),
      ],
    );
  }
  
  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
  
  void _copyHouseCode(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ev kodu kopyalandı: $code'),
        backgroundColor: Colors.green,
      ),
    );
  }
  
  void _shareHouseCode(BuildContext context, String code) {
    _copyHouseCode(context, code);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ev kodu kopyalandı! Arkadaşlarınızla paylaşabilirsiniz.'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );
  }
  
  void _showEditHouseNameDialog(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ev Adını Düzenle'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Yeni Ev Adı',
            border: OutlineInputBorder(),
          ),
          maxLength: AppConstants.maxHouseNameLength,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                // TODO: Ev adını güncelle
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ev adı güncelleme özelliği yakında!'),
                  ),
                );
              }
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }
  
  void _showLeaveHouseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Evden Ayrıl'),
        content: const Text(
          'Bu evden ayrılmak istediğinizden emin misiniz? '
          'Bu işlem geri alınamaz ve tüm verileriniz silinecektir.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Evden ayrılma işlemi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Evden ayrılma özelliği yakında!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Ayrıl'),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteHouseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Evi Sil'),
        content: const Text(
          'Bu evi tamamen silmek istediğinizden emin misiniz? '
          'Bu işlem geri alınamaz ve tüm veriler kalıcı olarak silinecektir.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Evi silme işlemi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ev silme özelliği yakında!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
} 