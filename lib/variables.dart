// ignore: unused_import
import 'dart:io';

void variables() {
  // Создание переменных различных типов
  int age = 25;
  double height = 1.75;
  String name = 'aksenoff';
  bool isStudent = true;
  dynamic variable = 42;
  Object object = 'SUAI';

  // Изменение значения динамической переменной
  variable = 'age multiply by 5 is ${age * 5}';

  // Запрос данных у пользователя
  stdout.write('Введите ваше имя: ');
  String userName = stdin.readLineSync()!;

  stdout.write('Введите ваш возраст: ');
  String userAgeInput = stdin.readLineSync()!;
  int userAge = int.parse(userAgeInput);

  stdout.write('Введите ваше любимое дробное число: ');
  String userFavoriteNumberInput = stdin.readLineSync()!;
  double userFavoriteNumber = double.parse(userFavoriteNumberInput);

  // Вывод результатов
  print('Name: $name, Age: $age, Height: $height, Student: $isStudent, Dynamic: $variable, Object: $object');
  print('Your name: $userName, Your age: $userAge, Your favorite number: $userFavoriteNumber');
}
