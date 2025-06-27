
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';

class ExpenseAddScreen extends ConsumerStatefulWidget {
  const ExpenseAddScreen({super.key});

  @override
  ConsumerState<ExpenseAddScreen> createState() => _ExpenseAddScreenState();
}

class _ExpenseAddScreenState extends ConsumerState<ExpenseAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harcama Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.receipt,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Tutar',
                  hintText: '100.50',
                  prefixIcon: Icon(Icons.attach_money),
                  suffixText: '₺',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tutar boş olamaz';
                  }
                  final amount = double.tryParse(value.trim());
                  if (amount == null || amount <= 0) {
                    return 'Geçerli bir tutar giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Açıklama',
                  hintText: 'Ör: Market alışverişi',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLength: AppConstants.maxDescriptionLength,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Açıklama boş olamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _addExpense,
                child: const Text('Harcama Ekle'),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Bu harcama ev arkadaşlarınız arasında eşit olarak bölünecektir.',
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
  
  void _addExpense() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement expense adding
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harcama eklendi!'),
          backgroundColor: Colors.green,
        ),
      );
              Navigator.of(context).pop();
    }
  }
} 