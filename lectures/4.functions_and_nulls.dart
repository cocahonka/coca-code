// ignore_for_file: unused_element, unused_local_variable, avoid_init_to_null, prefer_final_locals, omit_local_variable_types, unused_import, unnecessary_null_comparison

import 'dart:io';

void nullableTypes() {
  //* Нулевые типы
  //? Нулевые типы - это типы, которые могут принимать значение null
  //? Нулевые типы в Dart введены для улучшения безопасности и предотвращения ошибок времени выполнения
  //? Нулевые типы позволяют избежать ошибок времени выполнения, связанных с нулевыми значениями
  //? Это очень важная концепция в современном программировании
  //? В Dart она называется Sound Null Safety (SNS или NS)

  //? В общем - переменные разделяются на 2 вариации: nullable и non-nullable
  //? И асболютно любой тип можно сделать nullable

  //* Чтобы сделать переменную nullable, нужно добавить знак вопроса после типа
  int? nullableInt = null;
  String? nullableString = null;
  // И т.д

  //* Nullable переменные единственные, которые могут быть не иннициализированы
  //* Так как они по умолчанию null
  double? nullableDouble;

  //* Никто не запрещает хранить в nullable переменной non-nullable значение
  bool? nullableBool = true;

  //*  Переменную с nullable типом можно присвоить переменной с non-nullable типом, но не наоборот
  int nonNullableInt = 42;
  // nonNullableInt = nullableInt; // Ошибка: A value of type 'int' can't be assigned to a variable of type 'int?'.
  nullableInt = nonNullableInt;
}

void nullableOperators() {
  //* Операторы для работы с нулевыми значениями
  //? Операторы для работы с нулевыми значениями позволяют упростить работу с нулевыми значениями
  //? Операторы для работы с нулевыми значениями позволяют избежать ошибок времени выполнения, связанных с нулевыми значениями

  //; Операторы доступа
  //* ?[] - Оператор доступа к элементу списка по индексу если список не null (если список нулл вернет null)
  List<int>? numbers = [1, 2, 3, 4, 5];
  // print(numbers?[0]); // 1

  numbers = null;
  print(numbers?[0]); // null

  //* ?. - Оператор доступа к свойству объекта если объект не null (если объект нулл вернет null)
  String? name = 'Ivan';
  // print(name?.length); // 4

  name = null;
  print(name?.length); // null

  //* ! - Оператор утверждения (Bang-operator), что значение не null
  //! Это опасный оператор, так как он может вызвать ошибку времени выполнения
  //! Его стоит использовать только если вы на 100% уверены, что значение не null

  //; final userInput = stdin.readLineSync()!;
  // name!.length; // Если name null, то будет ошибка времени выполнения

  //; Логический оператор
  //* ?? - Оператор объединения с null (null-aware operator)
  //? Оператор объединения с null возвращает значение слева, если оно не null, иначе возвращает значение справа
  int? a = null;

  print(a ?? 42); // 42

  a = 10;

  // print(a ?? 42); // 10

  //* ??= - Оператор присваивания, если null (null-aware assignment operator)
  //? Оператор присваивания, если null присваивает значение справа переменной, если переменная null
  int? b = null;

  b ??= 42;

  print(b); // 42

  //; Spread - операторы
  //* ...? - Оператор распространения списка, если список не null (null-aware spread operator)
  List<int>? numbers1 = [1, 2, 3];
  List<int>? numbers2 = null;

  // List<int> numbers3 = [...?numbers1, ...?numbers2];

  // print(numbers3); // [1, 2, 3]
}

void autoSmartCasts() {
  //* Автоматическое приведение типов (на примере null)
  //? Компилятор Dart достаточно умен чтобы после проверки на null привести переменную к non-nullable типу

  // Пример автоматического приведения типов
  String? word = 'hello';

  if (word != null) {
    print(word.toUpperCase()); //; Не используется оператор доступа ?. или !
  }
}

void simpleFunctions() {
  //* Сигнатура функции - это её имя, возращаемый тип и список параметров
  //? В Dart функции являются объектами первого класса
  //? Объект первого класса - это объект, который может быть передан как аргумент, возвращён из функции и присвоен переменной
  //? Функции могут быть присвоены переменным, переданы в качестве аргументов и возвращены из других функций
  //? Функции могут быть анонимными
  //? Функции могут быть вложенными
  //? Функции могут быть рекурсивными
  //? Функции могут быть асинхронными
  //? Функции могут быть замыканиями
  //? Функции могут быть генераторами

  //* Сигнатура функции в Dart определяется следующим образом
  //* OutType name(InputType args...)
  //? OutType - тип возвращаемого значения
  //? name - имя функции
  //? InputType - типы аргументов функции
  //? args - аргументы функции

  //* Новые типы для функций (и не только для функций)
  //* void - функция не возвращает значения
  //* Never - функция не возвращает управление (функция 100% завершится с ошибкой)

  // Пример функции, которая принимает два аргумента типа int и возращает их сумму
  int sum(int a, int b) {
    return a + b;
  }

  print(sum(3, 9)); // 12

  // Пример функции, которая принимает строку и число и возвращает строку умноженную на число
  String multiply(String str, int n) {
    return str * n;
  }

  print(multiply('Hello', 3)); // HelloHelloHello

  //* Стрелочные функции
  //? Стрелочные функции - это сокращённый синтаксис для функций, которые содержат только одно выражение
  //? Стрелочные функции не имеют тела функции и ключевого слова return

  // Пример стрелочной функции, которая принимает два аргумента типа int и возращает их сумму
  int sumArrow(int a, int b) => a + b;

  print(sumArrow(3, 9)); // 12

  // Пример стрелочной функции, которая принимает строку и число и возвращает строку умноженную на число

  String multiplyArrow(String str, int n) => str * n;

  print(multiplyArrow('Hello', 3)); // HelloHelloHello
}

void lexicalScope() {
  //* Лексическая область видимости
  //? Лексическая область видимости - это область видимости, которая определяется на момент написания кода
  //? Переменные, объявленные внутри функции, видны только внутри этой функции
  //? Переменные, объявленные внутри блока кода, видны только внутри этого блока кода
  //? Переменные, объявленные внутри класса, видны только внутри этого класса

  // Пример лексической области видимости
  const a = 10;

  void printA() {
    const b = 100;
    print(a); // Переменная a видна внутри функции printA
  }

  printA(); // 10

  // print(b); // Ошибка: The name 'b' isn't defined in the current scope
}

void extendedArgs() {
  //* Расширенные аргументы функций
  //? Функции в Dart могут принимать аргументы с именем, позиционные аргументы и аргументы со значением по умолчанию
  //? Аргументы с именем позволяют передавать аргументы в любом порядке
  //? Позиционные аргументы - это аргументы, которые передаются в функцию в том порядке, в котором они объявлены

  //* 1. Тип - обычные аргументы (обязательные + позиционные)
  // Уже изучили...

  //* 2. Тип - аргументы с именем
  //* (Обязательные - required и необязательные)

  // Пример функции, которая принимает два аргумента с именем
  void printPersonInfo({required String name, int age = 27}) {
    print('Name: $name, Age: $age');
  }

  printPersonInfo(name: 'Ivan', age: 19);
  printPersonInfo(name: 'Davidov');

  //; Конечно можно совмещать 1 и 2 типы, но 1 тип всегда идет первым
  // Пример функции, которая принимает два аргумента с именем и один позиционный аргумент
  void printPersonInfo2(String name, {required String city, int? age}) {
    print(
      'Name: $name, Age after 10 years: ${age == null ? 'Unknown' : age + 10}, City: $city',
    );
  }

  printPersonInfo2('Ivan', city: 'Saint-Petersburg', age: 19);
  printPersonInfo2('Davidov', city: 'SUAI');

  //* 3. Тип - опциональные позиционные аргументы
  //* (Необязательные + позиционные)

  // Пример функции, которая принимает два опциональных позиционных аргумента
  void printPersonInfo3(String name, [int age = 32, String city = 'Moscow']) {
    print('Name: $name, Age: $age, City: $city');
  }

  // Пример функции которая принимает один позиционный аргумент и два опциональных позиционных аргумента
  void printPersonInfo4(String name, [int? age, String city = 'Moscow']) {
    print(
      'Name: $name, Age in binary: ${age?.toRadixString(2) ?? 0}, City: $city',
    );
  }

  //; Совмещать 2 и 3 типы аругментов нельзя

  //? Таблица аргументов
  //                  1 тип    2 тип    3 тип
  // Обязательные?    +        +        -
  // Необязательные?  -        +        +
  // Позиционные?     +        -        +
}

void recursion() {
  //* Рекурсия
  //? Рекурсия - это процесс, когда функция вызывает саму себя
  //? Рекурсия может быть бесконечной, если нет условия выхода из рекурсии
  //? Рекурсия может быть использована для решения задач, которые могут быть разбиты на более мелкие подзадачи

  // Пример рекурсивной функции, которая считает факториал числа
  int factorial(int n) {
    if (n == 0) {
      return 1;
    } else {
      return n * factorial(n - 1);
    }
  }

  print(factorial(5)); // 120

  // Пример рекурсвной функции, которая считает факториал числа (стрелочная)
  int factorialArrow(int n) => n == 0 ? 1 : n * factorialArrow(n - 1);

  print(factorialArrow(5)); // 120

  //* Приём мемоизации
  //? Мемоизация - это техника оптимизации, которая заключается в сохранении результатов выполнения функции
  //? Мемоизация позволяет избежать повторных вычислений и ускорить выполнение функции
  //? Мемоизация может быть использована для оптимизации рекурсивных функций

  // Пример мемоизации (задача о числах Фибоначчи)
  int fib(int n) {
    if (n == 0 || n == 1) {
      return n;
    } else {
      return fib(n - 1) + fib(n - 2);
    }
  }

  print(fib(10)); // 55

  int fibMemo(int n, {Map<int, int>? memo}) {
    memo ??= {};

    if (memo.containsKey(n)) {
      return memo[n]!;
    }

    if (n == 0 || n == 1) {
      return n;
    } else {
      memo[n] = fibMemo(n - 1, memo: memo) + fibMemo(n - 2, memo: memo);
      return memo[n]!;
    }
  }

  print(fibMemo(10)); // 55

  // Сравнение:
  print(fibMemo(100)); // Легко
  //print(fib(100)); // Считаем 100 лет...

  //; Лучше никогда не использовать рекурсию, если есть другие способы решения задачи (динамическое программирование)
  //; Рекурсия - это красиво, но не всегда эффективно и особенно безопасно
  //; Любую рекурсию можно заменить на цикл
}

void listTricks() {
  //* Функции take и skip
  //? Функция take возвращает первые n элементов списка
  //? Функция skip возвращает список без первых n элементов

  final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print(numbers.skip(3).take(2));
  print(numbers.skip(8).take(10));
  print(numbers.skip(100));
}

void main() {
  final actions = <String, void Function()>{
    'nullableTypes': nullableTypes,
    'nullableOperators': nullableOperators,
    'autoSmartCasts': autoSmartCasts,
    'simpleFunctions': simpleFunctions,
    'lexicalScope': lexicalScope,
    'extendedArgs': extendedArgs,
    'recursion': recursion,
    'listTricks': listTricks,
  };

  for (final MapEntry(key: name, value: action) in actions.entries) {
    print('${'=' * 20}$name${'=' * 20}');
    action();
  }
}

// Домашнее задание (проверка умения работать с null и функциями)

//; Реализуйте все функции, вызовете их в функции main и выведите результаты

// 1. Напишите функцию, которая принимает строку и возвращает её длину.
// Если строка null, функция должна возвращать 0.

// 2. Создайте функцию createUser с обязательным именованным аргументом name,
// и необязательными именованными age и email. Если email не указан, присвойте 'No email provided',
// Если возраст не указан то присвойте 0.
// Функция должна возвращать Map<String, Object> с ключами name, age и email.

// 3. Напишите функцию которая будет принимать количество граней игрального кубика и количество бросков
// Количество бросков по умолчанию 1
// Посчитайте сумарное количество очков за все броски
// Затем с вероятностью 50 на 50 верните либо сумму всех очков, либо null
// И в main если эта функция вернет null то выведите "Повезет в следующий раз"
// А если не null то выведите "Ваши очки: $points"

// 4. Разбейте следующий код на понятные функции и скомбинируйте их вызов в еще одной функции
// Также функция должна не печатать, а возращать лист простых чисел которые подходят под условие
// Вывести все простые числа от X до Y исключая те, сумма цифр которых четна
/*
void simpleNumbersTask() {
  // 1 и 100 замените на X и Y
  for (var i = 2, isSimple = true; i <= 100; ++i, isSimple = true) {
    for (var j = 2; j <= i ~/ 2; ++j) {
      if (i % j == 0) {
        isSimple = false;
        break;
      }
    }

    if (isSimple) {
      var sum = 0;
      for (var number = i; number > 0; number ~/= 10) {
        sum += number % 10;
      }

      if (sum.isOdd) {
        print(i);
      }
    }
  }
}
*/

// 5. Реализуйте рекурсвную функцию (с мемоизацией), которая принимает одно число - количество строк треугольника
// Функция возвращает двумерный массив содержащий треугольник паскаля
// Пример:
// pascalTriangle(5) вернет слеюущий массив
// [
//  [1],
//  [1, 1],
//  [1, 2, 1],
//  [1, 3, 3, 1],
//  [1, 4, 6, 4, 1]
// ]
