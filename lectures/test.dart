import 'package:test/test.dart';

typedef Code = (int, int, String);

void main() {
  test('Зеленая трава зеленеет', () {
    final codes = lz77('зеленая зелень зеленеет', 9, 7);
    expect(codes, [
      (0, 0, 'з'),
      (0, 0, 'е'),
      (0, 0, 'л'),
      (7, 1, 'н'),
      (0, 0, 'а'),
      (0, 0, 'я'),
      (0, 0, ' '),
      (1, 5, 'ь'),
      (2, 6, 'е'),
      (4, 1, 'т'),
    ]);
  });

  test('Красная краска', () {
    final codes = lz77('красная краска', 8, 4);
    expect(codes, [
      (0, 0, 'к'),
      (0, 0, 'р'),
      (0, 0, 'а'),
      (0, 0, 'с'),
      (0, 0, 'н'),
      (5, 1, 'я'),
      (0, 0, ' '),
      (0, 3, 'с'),
      (4, 1, 'а'),
    ]);
  });

  test('Красная краска', () {
    final codes = lz77('красная краска', 9, 5);
    expect(codes, [
      (0, 0, 'к'),
      (0, 0, 'р'),
      (0, 0, 'а'),
      (0, 0, 'с'),
      (0, 0, 'н'),
      (6, 1, 'я'),
      (0, 0, ' '),
      (1, 4, 'к'),
      (1, 0, 'а'),
    ]);
  });

  test('Картофель', () {
    final codes = lz77('картофель', 100, 100);
    expect(codes, [
      (0, 0, 'к'),
      (0, 0, 'а'),
      (0, 0, 'р'),
      (0, 0, 'т'),
      (0, 0, 'о'),
      (0, 0, 'ф'),
      (0, 0, 'е'),
      (0, 0, 'л'),
      (0, 0, 'ь'),
    ]);
  });

  test('Биба', () {
    final codes = lz77('биба', 5, 4);
    expect(codes, [(0, 0, 'б'), (0, 0, 'и'), (3, 1, 'а')]);
  });

  test('Биба', () {
    final codes = lz77('биба', 4, 1);
    expect(codes, [(0, 0, 'б'), (0, 0, 'и'), (2, 0, 'б'), (0, 0, 'а')]);
  });
}

List<Code> lz77(String input, int mapLength, int bufferLength) {
  var tape = List<String?>.filled(mapLength - 1, null) + input.split('');
  final codes = <Code>[(0, 0, input[0])];

  var mapIndex = 0;
  while (tape.length > mapLength) {
    // Пропускаем пустые ячейки
    if (tape[mapIndex] == null) {
      mapIndex++;
      continue;
    }

    // Если достигли конца словаря, значит берем один символ из буфера
    if (mapIndex == mapLength) {
      codes.add((0, 0, tape[mapLength]!));
      tape = tape.skip(1).toList();
      mapIndex = 0;
      continue;
    }

    // Если символ из словаря не равен первому символу буфера, то пропускаем его
    if (tape[mapIndex] != tape[mapLength]) {
      mapIndex++;
      continue;
    }

    // Ищем максимальную подстроку
    var length = 0;
    while (mapLength + length <
            tape.length - 1 && // Не выходим за границы ленты
        mapIndex + length < mapLength && // Не выходим за границы словаря
        length < bufferLength - 1 && // Не выходим за границы буфера
        tape[mapIndex + length] ==
            tape[mapLength + length] // Символы равны
            ) {
      length++;
    }
    codes.add((mapIndex, length, tape[mapLength + length]!));
    tape = tape.skip(length + 1).toList();
    mapIndex = 0;
  }

  return codes;
}
