import 'dart:io';

import 'package:process_run/process_run.dart';
import 'package:test/test.dart';

void main() {
  test('Проверка ввода и вывода', () async {
    final inputData = File('test/input.txt').openRead();

    final result = await runExecutableArguments(
      'dart',
      ['run'],
      stdin: inputData,
    );

    expect(
      result.outText,
      contains(
        'Name: aksenoff, Age: 25, Height: 1.75, Student: true, Dynamic: age multiply by 5 is 125, Object: SUAI',
      ),
      reason: 'Вывод программы не соответствует ожидаемому',
    );

    expect(
      result.outText,
      contains('Your name: TestUser, Your age: 30, Your favorite number: 42.6'),
      reason: 'Вывод программы не соответствует ожидаемому',
    );
  });
}
