import 'dart:async';

class InputController {
  InputController();

  late int _digits;
  late String _correctString;
  late bool _isConfirmed;

  final List<String> _currentInputs = [];

  late StreamController<String> _inputController;
  late StreamController<bool> _verifyController;
  late StreamController<bool> _confirmedController;

  /// Get latest input text stream.
  Stream<String> get currentInput => _inputController.stream;

  /// Get verify result stream.
  Stream<bool> get verifyInput => _verifyController.stream;

  /// Get confirmed result stream.
  Stream<bool> get confirmed => _confirmedController.stream;

  String _firstInput = '';

  String get confirmedInput => _firstInput;

  /// Add some text at the end and stream it.
  void addCharacter(String input) {
    if (_digits < _currentInputs.length) {
      return;
    }

    _currentInputs.add(input);
    _inputController.add(_currentInputs.join());

    if (_digits != _currentInputs.length) {
      return;
    }

    if (_isConfirmed && _firstInput.isEmpty) {
      setConfirmed();
      clear();
    } else {
      _verify();
    }
  }

  /// Remove the trailing characters and stream it.
  void removeCharacter() {
    if (_currentInputs.isNotEmpty) {
      _currentInputs.removeLast();
      _inputController.add(_currentInputs.join());
    }
  }

  /// Erase all current input.
  void clear() {
    if (_currentInputs.isNotEmpty) {
      _currentInputs.clear();
      if (_inputController.isClosed == false) {
        _inputController.add('');
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

    if (_isConfirmed) {
      correctString = _firstInput;
    } else {
      correctString = _correctString;
    }

    if (inputText == correctString) {
      _verifyController.add(true);
    } else {
      _verifyController.add(false);
    }
  }

  /// Create each stream.
  void initialize({
    required int digits,
    required String correctString,
    bool isConfirmed = false,
  }) {
    _inputController = StreamController.broadcast();
    _verifyController = StreamController.broadcast();
    _confirmedController = StreamController.broadcast();

    _digits = digits;
    _correctString = correctString;
    _isConfirmed = isConfirmed;
  }

  /// Close all streams.
  void dispose() {
    _inputController.close();
    _verifyController.close();
    _confirmedController.close();
  }
}
//
// class InputController {
//   final List<String> _currentInputs = [];
//
//   late StreamController<String> _inputController;
//   late StreamController<bool> _verifyController;
//   late StreamController<bool> _confirmedController;
//
//   /// confirmation first input
//   String _firstInput = '';
//
//   /// Get latest input text stream.
//   Stream<String> get currentInput => _inputController.stream;
//
//   /// Get verify result stream.
//   Stream<bool> get verifyInput => _verifyController.stream;
//
//   /// Get confirmed result stream.
//   Stream<bool> get confirmed => _confirmedController.stream;
//
//   String get firstInput => _firstInput;
//
//   /// Add some text at the end and stream it.
//   void addCharacter(String input) {
//     _currentInputs.add(input);
//     _inputController.add(_currentInputs.join());
//   }
//
//   /// Remove the trailing characters and stream it.
//   void removeCharacter() {
//     if (_currentInputs.isNotEmpty) {
//       _currentInputs.removeLast();
//       _inputController.add(_currentInputs.join());
//     }
//   }
//
//   /// Erase all current input.
//   void clear() {
//     if (_currentInputs.isNotEmpty) {
//       _currentInputs.clear();
//       if (_inputController.isClosed == false) {
//         _inputController.add('');
//       }
//     }
//   }
//
//   void setConfirmed() {
//     _firstInput = _currentInputs.join();
//     _confirmedController.add(true);
//   }
//
//   void unsetConfirmed() {
//     _confirmedController.add(false);
//   }
//
//   /// Verify that the input is correct.
//   void verify(String correctString) {
//     final inputText = _currentInputs.join();
//
//     if (inputText == correctString) {
//       _verifyController.add(true);
//     } else {
//       _verifyController.add(false);
//     }
//   }
//
//   /// Create each stream.
//   void initialize() {
//     _inputController = StreamController.broadcast();
//     _verifyController = StreamController.broadcast();
//     _confirmedController = StreamController.broadcast();
//   }
//
//   /// Close all streams.
//   void dispose() {
//     _inputController.close();
//     _verifyController.close();
//     _confirmedController.close();
//   }
// }
