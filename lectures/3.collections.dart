// ignore_for_file: omit_local_variable_types, unused_local_variable, prefer_final_locals, prefer_const_declarations, unnecessary_const, cascade_invocations, prefer_final_in_for_each, unnecessary_statements

import 'dart:collection';
import 'dart:math';

void lists() {
  //* List<Type> - список, массив, хранящий элементы одного типа (Type)

  // Примеры
  List<int> numbers = [1, 2, 3, 4, 5];
  var strings = <String>['Hello', 'World', 'Dart'];
  final booleans = <bool>[true, false, true];

  //! Предпочтительный вариант
  final doubles = [3.14, 1.61803398875, 2.71828];

  const constNumbers = const [1, 2, 3];

  const constNumbersFixed = [1, 2, 3];
  final finalConstNumbers = const [1, 2, 3];
  final finalNumbers = [1, 2, 3];

  //? Различие между const и final
  //? const полностью иммутабельный, т.е. нельзя изменить значения внутри списка
  //? final можно изменить значения внутри списка, но нельзя переопределить сам список (как у const)

  // Примеры
  //! constNumbersFixed[0] = 42; // Вызовется ошибка
  //! constNumbersFixed = [4, 2, 1]; // Вызовется ошибка

  //! finalConstNumbers[0] = 42; // Вызовется ошибка
  //! finalConstNumbers = [4, 2, 1]; // Вызовется ошибка

  finalNumbers[0] = 42; //* Всё ОК!
  //! finalNumbers = [4, 2, 1]; // Вызовется ошибка

  //? Подлянка final name = const list
  // Линтер не скажет что изменение или добавление будет ошибкой времени компиляции!
  // В дарте нету чистого immutableList

  // Способы создания иммутабельных листов в рантайме (когда нельзя const)
  final unmodifiableList = List<int>.unmodifiable([1, 2, 3]);
  final List<int> anotherUnmodifiableList = List.unmodifiable(finalNumbers);
  // Или
  final unmodifiableListView = UnmodifiableListView([1, 2, 3]);
  final anotherUnmodifiableListView = UnmodifiableListView(finalNumbers);

  //! unmodifiableListView[0] = 42; // Ошибка рантайма

  // Различия:
  print('finalNumbers $finalNumbers');
  print('unmodifiableList: $anotherUnmodifiableList');
  print('unmodifiableListView: $anotherUnmodifiableListView');

  finalNumbers.add(12);

  print('\nfinalNumbers $finalNumbers');
  print('unmodifiableList: $anotherUnmodifiableList');
  print('unmodifiableListView: $anotherUnmodifiableListView');

  //; Лучше использовать UnmodifiableListView для иммутабельных листов
  //; Так как тип данных будет подсказывать что лист нельзя изменить
  //; Как решить проблему с изменением листа в рантайме? - Сделать копию (spread operator)

  // Примеры методов и полей через оператор доступа (.)
  print('numbers.length: ${numbers.length}');
  print('numbers.first: ${numbers.first}');
  print('numbers.last: ${numbers.last}');
  print('numbers.isEmpty: ${numbers.isEmpty}');
  print('numbers.isNotEmpty: ${numbers.isNotEmpty}');
  print('numbers.reversed: ${numbers.reversed}');

  numbers.add(10);
  numbers.addAll([1, 2, 3]);
  numbers.indexOf(10);
  numbers.removeAt(1);
  numbers.remove(10);
  //numbers.clear();
  // И другие...

  print('$numbers\n');

  //? Динамический список
  //? List<Object> - список, хранящий элементы разных типов
  List<Object> dynamicList = [1, 'Hello', true, 3.14];
  final anotherDynamicList = [1, 'Hello', true, 3.14];
}

void maps() {
  //* Map<Key, Value> - ассоциативный массив, словарь, хранящий пары ключ-значение

  // Примеры
  Map<String, int> ages = {
    'Alice': 25,
    'Bob': 30,
    'Charlie': 35,
  };

  var cities = <String, String>{
    'Moscow': 'Russia',
    'Berlin': 'Germany',
    'Paris': 'France',
  };

  //! Предпочтительный вариант
  final capitals = {
    'Russia': 'Moscow',
    'Germany': 'Berlin',
    'France': 'Paris',
  };

  const constCapitals = const {
    'Russia': 'Moscow',
    'Germany': 'Berlin',
    'France': 'Paris',
  };

  const anotherConstCapitals = {
    'Russia': 'Moscow',
    'Germany': 'Berlin',
    'France': 'Paris',
  };

  //? Неизменяемые мапы рантайма
  // Map.unmodifiable(other)
  // UnmodifiableMapView(map);

  // Примеры методов и полей через оператор доступа (.)
  print('ages.length: ${ages.length}');
  print('ages.keys: ${ages.keys}');
  print('ages.values: ${ages.values}');
  print('ages.isEmpty: ${ages.isEmpty}');
  print('ages.isNotEmpty: ${ages.isNotEmpty}');
  print('ages.containsKey("Alice"): ${ages.containsKey("Alice")}');
  print('ages.containsValue(25): ${ages.containsValue(25)}');

  ages['Alice'] = 26;
  ages['David'] = 40;

  ages.remove('Bob');
  ages.remove('cocahonka');
  // И другие...

  print('$ages\n');
}

void sets() {
  //* Set<Type> - множество, хранящее уникальные элементы одного типа (Type)

  // Примеры
  Set<int> numbers = {1, 2, 3, 4, 5};
  var strings = <String>{'Hello', 'World', 'Dart'};
  final booleans = <bool>{true, false, true};

  // const и unmodifiableSet как и в листах и мапах

  // Сэт можно превести к листу
  final numbersList = numbers.toList();

  print('numbers: $numbers');
  print('strings: $strings');
  print('booleans: $booleans');
  print('numberList: $numbersList\n');
}

void spreadOperators() {
  //* Spread-операторы - операторы распространения, позволяющие разворачивать коллекции

  // Примеры
  final numbers = [1, 2, 3];
  final moreNumbers = [0, ...numbers, 4, 5, 6];
  print('moreNumbers: $moreNumbers');

  final cities = {'Moscow', 'Berlin', 'Paris'};
  final moreCities = {'London', ...cities, 'New York', 'Tokyo'};
  print('moreCities: $moreCities');

  final capitals = {
    'Russia': 'Moscow',
    'Germany': 'Berlin',
    'France': 'Paris',
  };
  final moreCapitals = {
    'USA': 'Washington',
    ...capitals,
    'Japan': 'Tokyo',
  };
  print('moreCapitals: $moreCapitals\n');

  //? Spread-операторы можно использовать для создания копий коллекций
  final copyNumbers = [...numbers];
  final copyCities = {...cities};
  final copyCapitals = {...capitals};
  // Причем простые типы (int, double, String, bool) копируются по значению
  // А составные типы (List, Set, Map и другие) копируются по ссылке

  // Пример
  final someList = [
    1,
    2,
    ['hello', 'world'],
  ];
  final someListCopy = [...someList];

  print('someList: $someList');
  print('someListCopy: $someListCopy\n');

  someList[0] = 99;
  (someList[2] as List)[1] = 'Dart';

  print('someListModified: $someList');
  print('someListCopy: $someListCopy\n');

  // Соотвественно когда мы будем изучать функции и передавать в них лист
  // Мутируя состояние входного листа (аргумент функции) оригинальный лист также будет мутироваться
}

void forInLoop() {
  //* For-In цикл позволяет перебирать коллекцию если она имеет возможность итерироваться
  //* Синтаксис - for(MOD el in collection)

  // Пример
  final numbers = [1, 2, 3, 4, 5];
  for (var number in numbers) {
    print(number);
  }
  //! Это предпочтительнее
  for (final number in numbers) {
    print(number);
  }

  final someSet = {1, 2, 3, 4, 5};
  for (final number in someSet) {
    print(number);
  }

  final someMap = {
    'Alice': 25,
    'Bob': 30,
    'Charlie': 35,
  };
  for (final key in someMap.keys) {
    print('key: $key');
  }
  for (final value in someMap.values) {
    print('value: $value');
  }
  for (final entry in someMap.entries) {
    print('key: ${entry.key}, value: ${entry.value}');
  }

  //? Важно помнить что при использовании for-in цикла
  //? Нельзя изменять коллекцию внутри цикла
  //? Иначе будет ошибка времени выполнения
}

void collectionsFlow() {
  // В коллекциях можно использовать удобные фишки как Control-flow operators
  const promoActive = true;

  final nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  print('\nnav: $nav');

  final listOfInts = [1, 2, 3];
  final listOfStrings = ['#0', for (final i in listOfInts) '#$i'];
  print('listOfString: $listOfStrings');

  // Всё это можно использовать не только для List, и не только один раз
  // Пример для map
  final listOfStringsMap = <int, String>{
    0: '#0',
    for (final i in listOfInts) i: '#$i',
    if (promoActive) 99: 'Outlet',
    for (final string in nav) string.codeUnitAt(0): 'Page',
  };

  print('listOfStringMap: $listOfStringsMap\n');
}

void random() {
  // Генерация рандомных значений
  final generator = Random();
  generator.nextInt(10); // 0 - 9
  generator.nextDouble(); // 0.0 - 1.0
  generator.nextBool(); // true/false
  generator.nextInt(101) + 100; // 100 - 200

  final randomListInRangeFrom50To100 = [
    for (var i = 0; i < 5; ++i) generator.nextInt(51) + 50,
  ];

  print('\nrandomListInRangeFrom50To100: $randomListInRangeFrom50To100\n');
}

void main() {
  lists();
  maps();
  sets();
  spreadOperators();
  forInLoop();
  collectionsFlow();
  random();
}

// Домашнее задание

// 1. Ввести 5 численных значений (обязательно должно быть повторяющееся)
// На основе этих 5 значений создать мутабельную переменную с типом List<int> (обязательно int!)
// Сделать distint листа (убрать все повторяющеся значения)

// 2. Вывести на экран последовательность фибоначчи до 10 элемента
// (все элементы должны быть записаны в лист)

// 3. Сгенерировать список из 10 случайных чисел в диапазоне от 2 до 10
// На основне этого списка создать новый список где каждое число будет возведено в квадрат
// А потом рассортировано и выведено на экран

// 4. Задача для map
// Есть список из 5 чисел
// На основе этого списка создать мапу где ключом будет число, а значением строка
// В строке должно быть написано "Число: $key, Квадрат числа: ${key * key}"
