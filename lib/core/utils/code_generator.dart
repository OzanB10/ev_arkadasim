import 'dart:math';

class CodeGenerator {
  static const String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  static final Random _random = Random();
  
  static String generateHouseCode({int length = 6}) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_random.nextInt(_chars.length)),
      ),
    );
  }
  
  static bool isValidHouseCode(String code) {
    if (code.length != 6) return false;
    return RegExp(r'^[A-Z0-9]+$').hasMatch(code);
  }
} 