// ignore_for_file: unused_local_variable, omit_local_variable_types, prefer_final_locals, prefer_const_constructors, unused_catch_stack, unused_label, dead_code, prefer_const_declarations

import 'dart:async';
import 'dart:collection';
import 'dart:io';

class RestClientCustomBackedException implements Exception {}

class RestClientFormatException implements Exception {}

void labels() {
  //* Labels - используются для управления потоком выполнения программы
  //? В Dart есть возможность помечать циклы и операторы ветвления метками
  //? и использовать их для управления потоком выполнения программы
  //? Метки позволяют прерывать выполнение циклов и операторов ветвления

  // Пример
  outerLoop:
  for (var i = 0; i < 3; i++) {
    innerLoop:
    for (var j = 0; j < 3; j++) {
      print('i = $i, j = $j');
      if (j == 1) {
        break outerLoop;
      }
    }
  }

  //! Это очень плохая практика, так как это буквально оператор goto
  //! НИКОГДА НЕ ИСПОЛЬЗУЙТЕ
}

typedef IntList = List<int>;
typedef Matrix2x2 = List<List<int>>;
typedef JsonMap = Map<String, Object?>;

//! Плохо
typedef PassIdsMap = Map<String, IntList>;

void typedefs() {
  //* Typedefs (Type-allias) - позволяют создавать псевдонимы для функций
  //? Typedefs позволяют создавать псевдонимы для функций и любых типов
  //? и использовать их вместо определения типа

  // Пример
  Matrix2x2 matrix = [
    [1, 2, 3],
    [4, 5, 6],
  ];

  JsonMap json = {
    'key': 'value',
    'key2': 42,
    'key3': [1, null, 3],
  };

  //; Лучше не стоит вкладывать typedef в другой typedef
  //; Такая возможность существует, но усложняет просмотр исходного кода
}

void exceptions() {
  //* Exceptions, Error - используются для обработки ошибок
  //? Exceptions - это специальные объекты, которые используются для обработки ошибок
  //? В Dart есть множество встроенных классов исключений, которые можно использовать
  //? для обработки ошибок

  //* Различия
  //? Exceptions - это объекты, которые могут быть брошены и перехвачены
  //? Error - это объекты, которые могут быть брошены, но не желательно должны быть перехвачены

  //* Синтаксис
  //* throw Exception(...); - бросить исключение
  //* try { ... } catch (Object e) { ... } - перехватить исключение
  //* finally { ... } - выполнить код после блока try-catch (обязательно даже если произошла ошибка)

  //* Специальные операторы
  //* on - позволяет перехватывать только определенные типы исключений
  //* rethrow - позволяет перебросить исключение

  // Примеры

  //! Плохая практика - так как перехватываются все ошибки
  try {
    throw Exception('Error');
  } catch (e) {
    print(e);
  }

  //! Аналогично
  try {
    throw Exception('Error');
  } catch (e, s) {
    //* S - StackTrace - позволяет получить информацию о стеке вызовов (где произошла ошибка)
    print(e);
    print(s);
  }

  //! Аналогично (но не поймает Error)
  try {
    throw Exception('Error');
  } on Exception catch (e) {
    print(e);
  }

  //! Аналогично (поймает все ошибки)
  try {
    throw Exception('Error');
  } on Object catch (e) {
    print(e);
  }

  //* Хорошая практика (Ловим строго конкретный тип ошибки)
  try {
    throw FormatException('Error');
  } on FormatException catch (e, s) {
    //* Тут обрабатываем ошибку
    print(e);
  }

  //* Можно и несколько типов
  try {
    throw FormatException('Error');
  } on FormatException catch (e) {
    //* Тут обрабатываем ошибку форматирования
    print(e);
  } on HttpException catch (e) {
    //* Тут обрабатываем ошибку HTTP
    print(e);
  }

  //? Пример использования finally
  try {
    throw Exception('Error');
  } catch (e) {
    print(e);
  } finally {
    print('Finally');
  }

  try {
    throw UnimplementedError('wtf1');
  } finally {
    print('wtf2');
  }

  //* Идеальный вариант (на примере Rest клиента)
  try {
    //? Отправляем запрос
    //? Получаем ответ
    //? Парсим ответ
    //? Возвращаем ответ
  } on RestClientCustomBackedException catch (e, s) {
    //? Логируем/обратываем ошибку
    //? Возвращаем ошибку
    rethrow;
  } on RestClientFormatException catch (e, s) {
    //? Логируем/обратываем  ошибку
    //? Возвращаем ошибку
    rethrow;
  } on HttpException catch (e, s) {
    //? Логируем/обратываем  ошибку
    //? Возвращаем ошибку
    rethrow;
  } on Object catch (e, s) {
    //? Логируем/обратываем  ошибку
    //? Возвращаем ошибку
    rethrow;
  } finally {
    //? Закрываем соединение и т.д.
  }

  //; Ествественно если вы знаете что можно возникнуть только 1 ошибка, то ловите только ее
  //; Без общего catch (on Object catch (e, s))
}

void records() {
  //* Records - это иммутабельные анонимные объекты, которые содержат в себе данные (именнованные или нет)
  //* Аналог - кортеж в Python, дата-класс в Kotlin, 'статическая карта'

  //? Преимущества
  //? - Иммутабельность
  //? - Boilerplate-less (не нужно писать лишние классы и т.д.)
  //? - Поддерживают именнованные аргументы
  //? - Статичность

  //* Синтаксис records
  final records = ('first', 2, someBool: true, someString: 'string');

  //* Тип Records
  (int, int) pairOfInt = (1, 2);

  //* Сначала идут неименнованные аргументы, потом именнованные
  (int, {String name}) person = (42, name: 'john');

  //* Можно дать имя и неименнованным аргументам (но это бесполезно и излишне)
  //* Так как IDE все равно не запомнит
  (int age, int height, {String name}) person2 = (12, 120, name: 'john');

  //* Аргументы можно передавать в любом порядке
  (int, int, {String name}) person3 = (120, name: 'john', 12);

  //? Полученние данных из records
  final firstNumber = pairOfInt.$1;
  final secondNumber = pairOfInt.$2;
  //; Изменение данных в records не возможно (иммутабельность)

  final age = person.$1;
  final name = person.name;

  //; Имена считаются как разные типы
  // Пример
  final xyz = (x: 1, y: 2, z: 3);
  final anotherXyz = (x: 1, y: 2, z: 3);
  final someAnotherXyz = (x: 1, y: 2, z: 4);
  final yetAnotherXyz = (a: 1, b: 2, c: 3);

  print(xyz == anotherXyz); // true
  print(xyz == someAnotherXyz); // false
  print(xyz == yetAnotherXyz); // false

  //* 2 Самых легких паттерна деструктуризации
  final numbers = (1, 2, 3);
  final (a, b, c) = numbers;

  final (:x, :y, :z) = xyz; // Если используете теже имена
  final (x: first, y: second, z: third) = xyz; // Если хотите другие имена

  //* Свап-переменных как в Python при использовании данного паттерна
  var numberFirst = 1;
  var numberSecond = 2;
  (numberFirst, numberSecond) = (numberSecond, numberFirst);
  print('$numberFirst $numberSecond'); // 2 1

  //* Функции также могут принимать и возращать records
  ({String name, int age}) getPersonData() => (name: 'John', age: 42);
  print(getPersonData());
}

void main() {
  //! Это функция содержит в себе элементы которых вы ее не знаете
  //! Так что не смотрите сюда

  final actionMap = {
    'labels': labels,
    'typedefs': typedefs,
    'records': records,
    'exceptions': exceptions,
  };

  runZonedGuarded(
    () {
      for (final MapEntry(:key, :value) in actionMap.entries) {
        print('\n${'=' * 20}$key${'=' * 20}');
        value();
      }
    },
    (e, s) => print(e),
  );
}

// Домашнее задание

//; Все функции пишите сами
//; Все функции должны возращать значение в main
//; В main нужно проверять результат с помощью asserts

// 1. Напишите функцию которая принимает аргумент credentials типа Map<String, String> (Обязательный именованный)
// Функция должна возвращать Map<String, int>
// Нужно вернуть новую карту где значения старой карты должны быть преобразованы в число int.parse
// Если при итерации возникает ошибка преобразования в число, то следует добавить в новую карту ключ 'error' со значением 500
// И вернуть полученную новую карту
// P.s используйте typedef для двух типов карт
// P.s.s ловить стоит строго один тип ошибки
// Примеры работы
// func(credintials: {'key': '42', 'omg': '35'}) вернет {'key': 42, 'omg': 35}
// func(credintials: {'key': '42', 'omg': '35', 'jesus': 'wtf'}) вернет {'key': 42, 'omg': 35, 'error': 500}
// func(credintials: {'key': '42', 'omg': '11.5', 'jesus': 'wtf'}) вернет {'key': 42, 'error': 500}

// 2. Напишите функцию которая принимает число n (необязательный позиционный аргумент), по дефолту 10
// Функция возвращает список чисел Фибоначи до n-го числа
// Для высчитывания чисел фибоначи используйте swap переменных
// (просчитывать числа фибоначи через массив нельзя, только сохранять)

// 3. Напишите фукнцию которая рандомно высчитывает координаты (широта и долгота)
// Фукнция ничего не принимает
// Функция возвращает record с именованными аргументами
// Предел генерации координат от -180 до 180 (могут быть и дробные числа)
// В Main assert должен удостовериться что результаты в допустимых пределах
// В Main используйте простую деструктуризацию

// 4. Напишите функцию getSafe которая принимает лист чисел и индекс.
// (Лист обязателен позиционный, индекс именованный обязательный)
// Фукнция пытается вернуть значение по индексу, но если происходит ошибка то возращается null
// Обрабатывать следует только 1 ошибку

// 5. Напишите функцию которая принимает одно обязательное позиционное число и возращает матрицу чисел, заполненную особым образом.
// Размер матрицы n*n
// Тип матрицы определите через typedef
// В матрице должны быть числа от 1 до n*n
// Пример работы
// func(3) вернет [
// [1, 4, 7],
// [2, 5, 8],
// [3, 6, 9]
// ]
// func(4) вернет [
// [1, 5, 9, 13],
// [2, 6, 10, 14],
// [3, 7, 11, 15],
// [4, 8, 12, 16]
// ]
