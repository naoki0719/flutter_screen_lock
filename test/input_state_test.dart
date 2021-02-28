import 'package:flutter_screen_lock/input_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('input stream test', () {
    var state = InputState();
    state.initialize(false);

    expectLater(
      state.currentInput,
      emitsInOrder(
        ['1', '12', '123', '1234', '123', '12', '1', '', '1', '12', ''],
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
    var state = InputState();
    state.initialize(false);

    expectLater(state.verifyInput, emitsInOrder([true, false]));

    state.addCharacter('1');
    state.addCharacter('2');
    state.addCharacter('3');
    state.addCharacter('4');
    state.verify('1234');
    state.verify('12345');
  });
}
