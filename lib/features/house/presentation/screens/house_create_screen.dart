
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../viewmodels/house_controller.dart';

class HouseCreateScreen extends ConsumerStatefulWidget {
  const HouseCreateScreen({super.key});

  @override
  ConsumerState<HouseCreateScreen> createState() => _HouseCreateScreenState();
}

class _HouseCreateScreenState extends ConsumerState<HouseCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _houseNameController = TextEditingController();
  final _creatorNameController = TextEditingController();
  
  @override
  void dispose() {
    _houseNameController.dispose();
    _creatorNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final houseState = ref.watch(houseNotifierProvider);
    
    ref.listen(houseNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (house) {
          if (house != null) {
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
          }
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hata: $error'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Ev Oluştur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.home_work,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _houseNameController,
                decoration: const InputDecoration(
                  labelText: 'Ev Adı',
                  hintText: 'Ör: Beşiktaş Evi',
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ev adı boş olamaz';
                  }
                  if (value.trim().length > AppConstants.maxHouseNameLength) {
                    return 'Ev adı çok uzun';
                  }
                  return null;
                },
                maxLength: AppConstants.maxHouseNameLength,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _creatorNameController,
                decoration: const InputDecoration(
                  labelText: 'Adınız',
                  hintText: 'Ör: Ahmet',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Adınız boş olamaz';
                  }
                  if (value.trim().length > AppConstants.maxPersonNameLength) {
                    return 'Ad çok uzun';
                  }
                  return null;
                },
                maxLength: AppConstants.maxPersonNameLength,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: houseState.isLoading ? null : _createHouse,
                child: houseState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Ev Oluştur'),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Ev oluşturduktan sonra arkadaşlarınızla paylaşabileceğiniz 6 haneli bir kod alacaksınız.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _createHouse() {
    if (_formKey.currentState!.validate()) {
      ref.read(houseNotifierProvider.notifier).createHouse(
        name: _houseNameController.text.trim(),
        creatorName: _creatorNameController.text.trim(),
      );
    }
  }
} 