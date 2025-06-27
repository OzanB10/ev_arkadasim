
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/code_generator.dart';
import '../viewmodels/house_controller.dart';

class HouseJoinScreen extends ConsumerStatefulWidget {
  const HouseJoinScreen({super.key});

  @override
  ConsumerState<HouseJoinScreen> createState() => _HouseJoinScreenState();
}

class _HouseJoinScreenState extends ConsumerState<HouseJoinScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  
  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
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
        title: const Text('Eve Katıl'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.group_add,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Ev Kodu',
                  hintText: 'ABC123',
                  prefixIcon: Icon(Icons.key),
                ),
                textCapitalization: TextCapitalization.characters,
                maxLength: AppConstants.houseCodeLength,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ev kodu boş olamaz';
                  }
                  if (!CodeGenerator.isValidHouseCode(value.trim())) {
                    return 'Geçersiz ev kodu formatı';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Adınız',
                  hintText: 'Ör: Mehmet',
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
                onPressed: houseState.isLoading ? null : _joinHouse,
                child: houseState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Eve Katıl'),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Ev sahibinden aldığınız 6 haneli kodu girerek eve katılabilirsiniz.',
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
  
  void _joinHouse() {
    if (_formKey.currentState!.validate()) {
      ref.read(houseNotifierProvider.notifier).joinHouse(
        code: _codeController.text.trim().toUpperCase(),
        memberName: _nameController.text.trim(),
      );
    }
  }
} 