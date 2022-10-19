import 'package:flutter_screen_lock/src/input_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('input stream test', () {
    final state = InputController();
    state.initialize(digits: 4, correctString: '1234');

    expectLater(
      state.currentInput,
      emitsInOrder(
        <String>['1', '12', '123', '1234', '123', '12', '1', '', '1', '12', ''],
      ),
    );

    state.addCharacter('1');
    state.addCharacter('2');
    state.addCharacter('3');
    state.addCharacter('4');
    state.removeCharacter();
    state.removeCharacter();
    state.removeCharacter();
    state.removeCharacter();
    state.removeCharacter();
    state.addCharacter('1');
    state.addCharacter('2');
    state.clear();

    state.dispose();

    expect(() => state.addCharacter('b'), throwsStateError);
  });

  test('input verify', () {
    final state = InputController();
    state.initialize(digits: 4, correctString: '1234');

    expectLater(state.verifyInput, emitsInOrder(<bool>[true]));

    state.addCharacter('1');
    state.addCharacter('2');
    state.addCharacter('3');
    state.addCharacter('4');
  });

  test('input verify as failed', () {
    final state = InputController();
    state.initialize(digits: 4, correctString: '1234');

    expectLater(state.verifyInput, emitsInOrder(<bool>[false]));

    state.addCharacter('1');
    state.addCharacter('2');
    state.addCharacter('3');
    state.addCharacter('5');
  });
}
