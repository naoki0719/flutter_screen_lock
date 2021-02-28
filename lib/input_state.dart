import 'dart:async';

class InputState {
  final List<String> _currentInputs = [];

  StreamController<String> _inputController;
  StreamController<bool> _verifyController;
  StreamController<bool> _confirmedController;

  /// Get latest input text stream.
  Stream<String> get currentInput => _inputController.stream;

  /// Get verify result stream.
  Stream<bool> get verifyInput => _verifyController.stream;

  /// Get confirmed result stream.
  Stream<bool> get confirmed => _confirmedController.stream;

  /// Add some text at the end and stream it.
  void addCharacter(String input) {
    _currentInputs.add(input);
    _inputController.add(_currentInputs.join());
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
    _confirmedController.add(true);
  }

  void unsetConfirmed() {
    _confirmedController.add(false);
  }

  /// Verify that the input is correct.
  void verify(String correctString) {
    final inputText = _currentInputs.join();

    if (inputText == correctString) {
      _verifyController.add(true);
    } else {
      _verifyController.add(false);
    }
  }

  /// Create each stream.
  void initialize(bool confirmation) {
    _inputController = StreamController.broadcast();
    _verifyController = StreamController.broadcast();

    if (confirmation) {
      _confirmedController = StreamController.broadcast();
    }
  }

  /// Close all streams.
  void dispose() {
    _inputController?.close();
    _verifyController?.close();
    _confirmedController?.close();
  }
}
