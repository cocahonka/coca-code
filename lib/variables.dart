// ignore: unused_import
import 'dart:io';

void variables() {
  // Создание переменных различных типов
  const age = 25;
  const height = 1.75;
  const name = 'aksenoff';
  const isStudent = true;
  dynamic variable = 42;
  const Object object = 'SUAI';

  // Изменение значения динамической переменной
  variable = 'age multiply by 5 is ${age * 5}';

  // Запрос данных у пользователя
  stdout.write('Введите ваше имя: ');
  final userName = stdin.readLineSync()!;

  stdout.write('Введите ваш возраст: ');
  final userAgeInput = stdin.readLineSync()!;
  final userAge = int.parse(userAgeInput);

  stdout.write('Введите ваше любимое дробное число: ');
  final userFavoriteNumberInput = stdin.readLineSync()!;
  final userFavoriteNumber = double.parse(userFavoriteNumberInput);

  // Вывод результатов
  print('Name: $name, Age: $age, Height: $height, Student: $isStudent, Dynamic: $variable, Object: $object');
  print('Your name: $userName, Your age: $userAge, Your favorite number: $userFavoriteNumber');
}
