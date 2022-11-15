import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

class InputController {
  InputController();

  late int _digits;
  late String? _correctString;
  late ValidationCallback? _validationCallback;

  final List<String> _currentInputs = [];

  late ValueNotifier<String> _inputValueNotifier;
  late StreamController<bool> _verifyController;
  late StreamController<bool> _confirmedController;

  /// Get latest input text value.
  ValueNotifier<String> get currentInput => _inputValueNotifier;

  /// Get verify result stream.
  Stream<bool> get verifyInput => _verifyController.stream;

  /// Get confirmed result stream.
  Stream<bool> get confirmed => _confirmedController.stream;

  String _firstInput = '';

  String get confirmedInput => _firstInput;

  /// Add some text at the end and stream it.
  void addCharacter(String input) {
    if (_currentInputs.length >= _digits) {
      return;
    }

    _currentInputs.add(input);
    _inputValueNotifier.value = _currentInputs.join();

    if (_digits != _currentInputs.length) {
      return;
    }

    if (_correctString == null && _firstInput.isEmpty) {
      setConfirmed();
      clear();
    } else {
      _verify();
    }
  }

  /// Remove trailing characters and notify.
  void removeCharacter() {
    if (_currentInputs.isNotEmpty) {
      _currentInputs.removeLast();
      _inputValueNotifier.value = _currentInputs.join();
    }
  }

  /// Erase all current input.
  void clear() {
    if (_currentInputs.isNotEmpty) {
      _currentInputs.clear();
      try {
        _inputValueNotifier.value = '';
      } catch (e) {
        // disposed
      }
    }
  }

  void setConfirmed() {
    _firstInput = _currentInputs.join();
    _confirmedController.add(true);
  }

  void unsetConfirmed() {
    _firstInput = '';
    _confirmedController.add(false);
    clear();
  }

  /// Verify that the input is correct.
  void _verify() {
    final inputText = _currentInputs.join();
    late String correctString;

    if (_correctString != null) {
      correctString = _correctString!;
    } else {
      correctString = _firstInput;
    }

    if (_validationCallback == null) {
      _localValidation(inputText, correctString);
    } else {
      _validationCallback!(inputText)
          .then((success) => _verifyController.add(success));
    }
  }

  void _localValidation(String inputText, String correctString) {
    if (inputText == correctString) {
      _verifyController.add(true);
    } else {
      _verifyController.add(false);
    }
  }

  /// Create each stream.
  void initialize({
    required int digits,
    required String? correctString,
    ValidationCallback? onValidate,
  }) {
    _inputValueNotifier = ValueNotifier<String>('');
    _verifyController = StreamController.broadcast();
    _confirmedController = StreamController.broadcast();

    _digits = digits;
    _correctString = correctString;
    _validationCallback = onValidate;
  }

  /// Close all streams.
  Future<void> dispose() async {
    _inputValueNotifier.dispose();
    await _verifyController.close();
    await _confirmedController.close();
  }
}
