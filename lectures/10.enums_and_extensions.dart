// План
//? Перечисления
//* Enum
//* Enhanced Enum
//* FSM (Finite State Machine) - конечный автомат
//? Расширения
//* Extension

// ignore_for_file: unused_local_variable, prefer_asserts_with_message

import 'dart:io';

void enums() {
  //? Перечисления - Enum
  //* Enum - представляет собой особый вид классов, используемых для представления
  //* фиксированного числа постоянных значений (констант).

  //? Зачем
  //* Позволяют создавать ФИКСИРОВАННЫЙ набор значений/объектов/констант (стороны света, дни недели, месяцы и т.д.)
  //* Позволяют создавать машины состояний (конечный автомат).
  //* Позволяют менять состояние в четком диапазоне значений.

  //? Создание Enum
  //* Синтаксис:
  //* enum EnumName { value1, value2, value3, ... }

  //? Возможности и особенности
  //* Каждое значение enum представлно как некоторое имя которое и является значением.
  //* Все значения enum являются константами.
  //* enum класс нельзя создать как объект, значения можно получить как статические поля класса.
  //* Значения enum имеют геттеры index, name
  //* Сам enum имеет геттер values, который содержит список всех значений enum. (index - порядковый номер значения)

  // Базовые примеры
  const someDirection = Direction.east;

  print(someDirection);
  print(someDirection.name);
  print(someDirection.index);
  print(someDirection == Direction.east);
  print(Direction.values[someDirection.index] == Direction.east);

  // Примеры со сравнением
  void checkAndProcessError(Status status) {
    if (status == Status.error) {
      print('An error occurred');
      exit(1);
    }
  }

  checkAndProcessError(Status.loading);

  // Пример с валидацией вордли
  bool validateWordle(String input, WordleValidator validator) {
    final formattedInput = input.trim().toLowerCase();

    if (validator == WordleValidator.inputWord) {
      return input.length == 5 && input.contains(RegExp('[a-z]'));
    }

    if (validator == WordleValidator.attemps) {
      final numericValue = int.tryParse(input);
      return numericValue != null && numericValue > 0;
    }

    if (validator == WordleValidator.yesOrNo) {
      return const ['yes', 'no'].contains(formattedInput);
    }

    // В случае если не сработало ни одно условие
    // Хотя мы рассмотрели все возможные варианты
    // Можно добавить else, но проблема останется
    // (Dart не понимает что мы посмотрели ВСЕ возможные значения)
    return false;
  }

  print("Validate 'jiger' by inputWord rule : ${validateWordle('jiger', WordleValidator.inputWord)}");
  print("Validate 'migger' by inputWord rule : ${validateWordle('migger', WordleValidator.inputWord)}");
  print("Validate 'yes' by yesOrNo rule : ${validateWordle('yes', WordleValidator.yesOrNo)}");
  print("Validate 'n' by yesOrNo rule : ${validateWordle('n', WordleValidator.yesOrNo)}");
  print("Validate '1' by attemps rule : ${validateWordle('1', WordleValidator.attemps)}");
  print("Validate '1.5' by attemps rule : ${validateWordle('1.5', WordleValidator.attemps)}");
}

enum Direction { north, east, south, west }

enum Status { none, loading, loaded, error }

enum WordleValidator { inputWord, yesOrNo, attemps }

void enhancedEnums() {
  //? Улучшенные Enum
  //* В Dart 2.17 добавили возможность добавлять  методы и поля,
  //* константные и фабричные конструкторы в enum
  //* Но суть таких enum остается той же - хранить фиксированный набор значений

  //? Ограничения
  //* Чтобы использовать улучшенные enum стоит помнить о следующих ограничениях
  //* 1. Все поля должны быть final
  //* 2. Все конструкторы должны быть константными
  //* 3. Фабричный конструктор должен возращать фиксированное значение которое есть в этом enum
  //* 4. Все фиксированные значения должны распологаться строго вверху определения enum

  //? Зачем
  //* Возможность хранить несколько связных данных в фиксированном наборе значений
  //* Возможность правильно использовать инкапсуляцию

  //? Создание Enhanced Enum
  //* Синтаксис:
  //* enum EnumName {
  //* value1(args...),
  //* value2(args...),
  //* value3(args...),
  //* ...
  //* const EnumName(args...)
  //* final field1;
  //* final field2;
  //* ...
  //* }

  // Пример

  //const vehicle = Vehicle.bus;
  final vehicle = Vehicle.byTires(6);
  print('vehile: $vehicle');
  print('vehile.name: ${vehicle.name}');
  print('vehile.index: ${vehicle.index}');
  print('vehile.tires: ${vehicle.tires}');
  print('vehile.passengers: ${vehicle.passengers}');
  print('vehile.carbonPerKilometer: ${vehicle.carbonPerKilometer}');
  print('vehile.carbonFootprint: ${vehicle.carbonFootprint}');
  print('vehile.isTwoWheeled: ${vehicle.isTwoWheeled}');
  vehicle.drive(80);
}

enum Vehicle {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  factory Vehicle.byTires(int tires) {
    return values.firstWhere((element) => element.tires == tires);
  }

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  void drive(double distance) {
    print('Driving $distance km on $name');
  }
}

void finiteStateMachine() {
  //? FSM (Finite State Machine) - конечный автомат
  //* Конечный автомат - это модель вычислений, которая состоит из конечного числа состояний,
  //* переходы между которыми происходят в результате воздействия на конечный автомат входных сигналов.

  //? Зачем
  //* Позволяет управлять состоянием объекта
  //* Позволяет управлять потоком данных
  //* Позволяет управлять потоком управления

  //? Как достичь истинного FSM?
  //* Использовать Enum для определения состояний
  //* Использовать switch для определения переходов

  //? Switch
  //* Switch - это конструкция языка программирования, которая позволяет выбирать один
  //* из нескольких константных вариантов выполнения кода (аналог if-else)
  //* В Dart до 3 версии switch был очень ограничен и не поддерживал FSM, поэтому являлся бесполезным
  //* Сейчас switch умеет работать с FSM и Patterns что делает его очень полезным
  //* Разберем работу switch только с FSM
  //* Switch с enum будет ЗАСТАВЛЯТЬ нас обработать ВСЕ возможные состояния, иначе будет ошибка

  //? Синтаксис switch как statement (инструкция)
  //* switch (enumValue) {
  //* case Enum.value1: someWork;
  //* case Enum.value2: { somework; }
  //* ...
  //* default: someWork; ИЛИ case _: someWork;
  //* }

  //? Синтаксис switch как expression (выражение)
  //* switch (enumValue) {
  //* Enum.value1 => someWork,
  //* Enum.value2 => { somework, }
  //* ...
  //* _ => someWork;
  //* };

  //? Отличие между statement и expression
  //* Statement - это инструкция, которая выполняет какое-то действие (пример: if-else)
  //* Expression - это выражение, которое возвращает значение (пример: return или присваивание)

  //; Желательно не использовать default или _ в switch с enum, так как это нарушает принцип FSM
  //; Вместо default стоит использовать "проваливания - fallthrough" (НО fallthrough нельзя использовать в expression)
  //; break не нужен, так как switch с enum сам обрабатывает переходы

  const direction = Direction.south;

  // Statement
  switch (direction) {
    case Direction.north:
      print('north');
    case Direction.east:
    case Direction.south:
      // north и east "проваливаются в south"
      print('east, south');
      print('east, south');
      print('east, south');
    // ignore: no_default_cases
    default:
      // все другие необработанные значения (west)
      print('object');
  }

  // Expression
  final distance = switch (direction) {
    Direction.north => 200,
    Direction.east => 150,
    Direction.south => 60,
    Direction.west => 60,
  };

  //? Более конкретный пример FSM
  //* Пусть у нас есть конечный автомат, который управляет состоянием вордли

  //? Состояния
  //* 1. inputAttemps - ввод количества попыток
  //* 2. inputGuess - ввод слова
  //* 3. inputPlayDesire - ввод желания играть

  //? Переходы
  //* 1. inputAttemps -> inputGuess
  //* 2. inputGuess -> inputPlayDesire
  //* 3. inputPlayDesire -> inputGuess

  //? Реализация
  //* Создадим конечный автомат, который будет управлять состоянием вордли

  final input = [
    '4',
    'word',
    'joker',
    'lamp',
    'yes',
    'fish',
    'lamp',
    'no',
  ];

  var state = WordleState.initState;
  const secretWord = 'lamp';
  () {
    while (true) {
      switch (state) {
        case WordleState.inputAttemps:
          final attemps = int.tryParse(input.removeAt(0));
          print('attemps: $attemps');
          state = state.nextState;
        case WordleState.inputGuess:
          final guess = input.removeAt(0);
          print('guess: $guess');
          if (guess == secretWord) state = state.nextState;
        case WordleState.inputPlayDesire:
          final desire = input.removeAt(0);
          print('desire: $desire');
          if (desire == 'yes') state = state.nextState;
          if (desire == 'no') return;
      }
    }
  }();

  // Пример 2
  // Валидация вордли с использованием FSM
  print("Validate 'jiger' by inputWord rule : ${WordleValidatorEnhanced.inputWordValidation.validate('jiger')}");
  print("Validate 'migger' by inputWord rule : ${WordleValidatorEnhanced.inputWordValidation.validate('migger')}");
  print("Validate 'yes' by yesOrNo rule : ${WordleValidatorEnhanced.yesOrNoValidation.validate('yes')}");
  print("Validate 'n' by yesOrNo rule : ${WordleValidatorEnhanced.yesOrNoValidation.validate('n')}");
  print("Validate '1' by attemps rule : ${WordleValidatorEnhanced.attempsValidation.validate('1')}");
  print("Validate '1.5' by attemps rule : ${WordleValidatorEnhanced.attempsValidation.validate('1.5')}");

  //; Если мы добавим новое значение в enum, то switch заставит нас обработать его!!!
}

enum WordleState {
  inputAttemps,
  inputGuess,
  inputPlayDesire;

  static WordleState get initState => WordleState.inputAttemps;

  WordleState get nextState => switch (this) {
        WordleState.inputAttemps => WordleState.inputGuess,
        WordleState.inputGuess => WordleState.inputPlayDesire,
        WordleState.inputPlayDesire => WordleState.inputGuess,
      };
}

enum WordleValidatorEnhanced {
  inputWordValidation,
  yesOrNoValidation,
  attempsValidation;

  bool validate(String input) {
    final formattedInput = input.trim().toLowerCase();

    return switch (this) {
      WordleValidatorEnhanced.inputWordValidation => input.length == 5 && input.contains(RegExp('[a-z]')),
      WordleValidatorEnhanced.yesOrNoValidation => const ['yes', 'no'].contains(formattedInput),
      // Создаем анонимную функцию! Чтобы можно было вставить несколько строк
      WordleValidatorEnhanced.attempsValidation => () {
          final numericValue = int.tryParse(input);
          return numericValue != null && numericValue > 0;
        }(),
    };
  }
}

void extensions() {
  //? Расширения - Extension
  //* Extension - это способ добавить новые методы и поля, статики, геттеры и др.
  //* к существующему классу или типу без изменения самого класса или типа

  //? Зачем
  //* Позволяет добавлять новые методы и поля к существующим классам и типам
  //* Позволяет добавлять методы и поля к классам и типам, которые мы не можем изменить
  //* (dart builtin, или классы других людей)

  //? Создание Extension
  //* Синтаксис:
  //* extension ExtensionName on Type {}
  //* Имя опционально, но лучше ВСЕГДА его указывать

  //? Особенности
  //* Внутри любой конструкции в extension считается что ведется работа над указанным объектом
  //* Поэтому если extension сделан например на List то чтобы получить размер можно просто написать length
  //* Не используя this
  //* this в свою очередь можно использовать для обращения к объекту над которым ведется работа

  //? Пример использования
  //? String
  //* 1. Сделаем parse и tryParse методы
  //* 2. Добавим метод capitalize
  //? List<int>, List<double>
  //* 1. Добавим геттер average
  //? List<Object>
  //* 1. Добавим метод zip
  //? List<List<Object>>
  //* 1. Добавим геттер flatten
  //* 2. Добавим метод unzip
  //? Enum
  //* 1. Добавим метод getValueByName и getValueByNameOrNull

  // Пример String
  print('String extension');
  const number = '123';
  print(number.tryParse());
  print(number.parse());
  print('hello'.capitalize());
  print('HELLO'.capitalize());
  print(''.capitalize());
  print('t'.capitalize());
  print('\n');

  // Пример List<int>, List<double>
  print('List<int>, List<double> extension');
  final numbers = [1, 2, 3, 4, 5];
  print(numbers.average);
  final doubles = [1.0, 2.0, 3.0, 4.0, 5.0];
  print(doubles.average);
  print('\n');

  // Пример List<Object>
  print('List<Object> extension');
  final list1 = [1, 2, 3];
  final list2 = ['a', 'b', 'c'];
  final result = list1.zip(list2);
  print(result);
  final list3 = [1, 2, 3];
  final list4 = [1, 2, 3, 4];
  // Если не использовать cast, то у нас будет List<List<Object>> вместо List<List<int>>
  final result2 = list3.zip(list4).map((e) => e.cast<int>()).toList();
  print(result2);
  print('\n');

  // Пример List<List<Object>>
  print('List<List<Object>> extension');
  final listList = [
    [1, 2, 3],
    ['a', 'b', 'c', 'd', 'f'],
    [4, 5, 6, 7, 8],
  ];
  print(listList.flatten);
  final firstList = [1, 2, 3];
  final secondList = [4, 5, 6, 7];
  final zippedList = firstList.zip(secondList);
  final unzippedList = zippedList.unzip();
  print(firstList);
  print(secondList);
  print(zippedList);
  print(unzippedList);
  print('\n');

  // Пример Enum
  print('Enum extension');
  final value = Direction.values.getValueByName('east');
  final valueOrNull = Direction.values.getValueByNameOrNull('joker');
  print(value);
  print(valueOrNull);

  //* Встроенные методы
  final builtinValue = Direction.values.byName('east');
  print('\n');
}

// Расширение для String
extension StringExtension on String {
  int? tryParse() => int.tryParse(this);

  int parse() => int.parse(this);

  String capitalize() => isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : this;
}

// Расширение для List<int>, List<double>
extension ListIntExtension on List<int> {
  double get average => isEmpty ? 0 : reduce((value, element) => value + element) / length;
}

extension ListDoubleExtension on List<double> {
  double get average => isEmpty ? 0 : reduce((value, element) => value + element) / length;
}
//? Дублирование кода?
//* К сожалению мы пока что не в силах убрать дублирование кода
//* Потому что не знаем что такое Дженерики, так что будем использовать псевдо "перегрузку"
//* На данный момент мы знаем только про 1 способ сделать что-то более "Общим" - использовать тип Object
//* Но к сожалению в контексте сложения ЧИСЕЛ такой вариант нам не подходит
//* Чтобы воспользоваться Object, нам нужна специфическая задача, которая не требует знание типа
//* Пример внизу

// Расширение для List<Object>
extension ListObjectExtension on List<Object> {
  List<List<Object>> zip(List<Object> other) {
    assert(other.length >= length);

    final result = <List<Object>>[];
    for (var i = 0; i < length; i++) {
      result.add([this[i], other[i]]);
    }
    return result;
  }
}
//? Проблема типов?
//* Это расширение работает для листов с любым содержимым, т.е. мы все таки смогли решить задачу в общем виде
//* Но в таком случае у нас теряется типизация при вызове данного метода
//* [1, 2, 3].zip([1, 2, 3]); - Логично предположить что такая запись должна вернуть тип List<List<int>>
//* Так как объект у которого мы вызываем метод и объект которых передаем в аргументы метода имеют тип List<int>
//* Но в нашей реализации мы явно указали что возращаем List<List<Object>> и исправить это, не зная Джереников нельзя
//* Единственное что мы можем сделать - это использовать встроенную функцию cast
//* [1, 2, 3].zip([1, 2, 3]).map((el) => el.cast<int>());
//* В таком случае мы получим List<List<int>>

// Расширение для List<List<Object>>
extension ListListObjectExtensions on List<List<Object>> {
  List<Object> get flatten => expand((element) => element).toList();

  (List<Object>, List<Object>) unzip() => fold(
        (<Object>[], <Object>[]),
        (record, element) {
          assert(element.length == 2);

          record.$1.add(element.first);
          record.$2.add(element.last);
          return record;
        },
      );
}

// Расширение для Enum
extension EnumExtensions on Iterable<Enum> {
  Enum getValueByName(String name) {
    return getValueByNameOrNull(name) ?? (throw ArgumentError('No such value'));
  }

  Enum? getValueByNameOrNull(String name) {
    for (final value in this) {
      if (value.name == name) return value;
    }
    return null;
  }
}
//? На самом деле такое расширение уже существует
//* Так что важно усвоить, что перед тем как писать свои расширения, нужно убедиться, не делаете ли вы
//* работу дважды, может быть такой метод все таки уже есть?

void main() {
  final labels = {
    'enums': enums,
    'enhancedEnums': enhancedEnums,
    'finiteStateMachine': finiteStateMachine,
    'extensions': extensions,
  };

  final divider = '=' * 20;

  for (final MapEntry(key: title, value: action) in labels.entries) {
    print('$divider $title $divider');
    action();
    print('\n');
  }
}

// План
//? Перечисления
//* Enum
//* Enhanced Enum
//* FSM (Finite State Machine) - конечный автомат
//? Расширения
//* Extension

// Домашнее задание
//!!! Далее под понятием enum будет подразумеваться как обычный enum так и enhanced enum

//? 1. Реализуйте пространство имен для цветов
//* См. задание 6 в лекции 9.
//* В прошлый раз вы делали пространство имен для цветов используя static
//* Теперь реализуйте пространство имен используя enum
//* Каждый цвет по прежнему должен хранить в себе его hex код

//? 2. Реализуйте перечисление для месяцев (Month)
//* Реализуйте enum для месяцев
//* Каждое значение месяца должно иметь следующую информацию:
//* - календарный номер, имя на английском, имя на русском
//* У каждого значения месяца также должны быть методы
//* - Month plusNumber(int number)
//* - Month plusMonth(Month month)
//* Методы должны возращать месяц полученный путем сложения одного месяца с другим
//* В случае числа - месяц полученный путем сложения месяца с числом
//* Примеры:
//* - Month.january.plusNumber(2) == Month.march
//* - Month.january.plusMonth(Month.february) == Month.march
//; Для чисел предусмотрите переполнение:
//* Например числа (+1000 и -1000) и другие больше 12 или отрицательные не должны вызывать проблем
//; Для сложение месяца с месяцем НЕ используйте конечный автомат, используйте функцию для сложения номеров месяцев.

//? 3. Создайте расширение для int
//* Метод или геттер isPrime (простое ли число)

//? 3.1 Создайте расширение для String
//* Геттер reversed

//? 4. Создайте расширение для коллекций чисел (int и double)
//* 1. Нужны методы min, max, sum, groupBy
//* - groupBy должен принимать int - число по которому будет произведена группировка
//* - (на сколько групп будет разбит изначальный лист)
//* - Данное задание вы уже выполняли, просто найдите код или напишите заного
//* - groupBy должен возращать Iterable<Iterable<int>> или List<List<int>>
//* - Пример: [1, 2, 3, 4, 5, 6].groupBy(2) == [[1, 2], [3, 4], [5, 6]]
//* 2. Нужны геттеры isUpscale, isDownscale (возрастающая/убывающая ли последовательность)
//* 3. Ответить на вопрос (письменно, не кодом) как было бы лучше сделать isUpscale, isDownscale?
//* - Оставить их в виде геттеров или лучше перевести в форму методов?

//? 5. Реализуйте свой класс Matrix4x4
//* Класс должен инкапсулировать приватный двумерный лист
//* Конструктор должен принимать одномерный лист размером 16 или выдавать ошибку throw ArgumentError('Неверный размер матрицы');
//* Ошибка должна вызываться ДО создания объекта
//* Одномерный лист следует преобразовать в двумерный специальным методом groupBy (см. задание 3)
//* Класс должен иметь один метод - sum - возращающий сумму всей матрицы
//*
//* Для этого класса нужно создать расширение в том же файле, расширение должно иметь метод:
//* sumOfTwoDiagonals - возращает сумму двух диагоналей матрицы

//? 6. Кофемашина (задача на 2 дня)
//* Реализуйте FSM на примере кофемашины
//* 1. Создайте перечисление возможных состояний
//* 2. Реализуйте переход между этими состояними в свободной форме (как хотите) НО используя FSM
//* 3. Реализуйте взаимодействие с каждым из состояний (простые print и readline) без сложной провверки и т.д.
//*
//* Описание (интерпритируйте на свой вкус, это задание на ваше воображение)
//* Кофемашина может готовить 3 вида кофе: капучино, латте и эспрессо.
//* Кофемашина также может находиться в режиме ожидания и в режиме выбора напитка

//? 7. Реализуйте перечисление для денежных валют
//* Реализуйте enum для денежных валют (например, USD, EUR, GBP).
//* Каждая валюта должна содержать информацию о её символе, курсе по отношению к рублю.
//* Реализуйте метод для конвертации суммы из одной валюты в другую.

//? 8. Создайте расширение для списка строк
//* Расширение должно добавить метод groupByFirstLetter, который группирует строки по первой букве.
//* Метод возращает Map<String, List<String>>
//* Пример работы:
//* Код для теста:
// ['hello', 'world', 'hey', 'guys'].groupByFirstLetter().forEach((key, value) => print('$key: $value'));
//* Вывод программы:
/*
H: [hello, hey]
W: [world]
G: [guys]
*/

//? 9. Создайте расширение для списка объектов
//* Расширение должно добавить метод toMapByField, который преобразует список объектов в карту,
//* где ключами будут значения указанного поля.
//* Пример работы:
//* Код для теста:
/*
class Person {
  Person(this.name, this.age);

  final String name;
  final int age;
}

void mapPrint(Object key, Object value) => print('$key: $value');

void main() {
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
      .toMapByField((obj) => (obj as int).toRadixString(2))
      .forEach(mapPrint);

  [Person('Ivan', 19), Person('Marcus', 19), Person('Paul', 20)]
      .toMapByField((obj) => (obj as Person).name)
      .forEach(mapPrint);
}
*/
//* Вывод программы:
/*
1: 1
10: 2
11: 3
100: 4
101: 5
110: 6
111: 7
1000: 8
1001: 9
1010: 10
1011: 11
1100: 12
1101: 13
1110: 14
Ivan: Instance of 'Person'
Marcus: Instance of 'Person'
Paul: Instance of 'Person'
*/

extension ListToMapByFieldExtension on List<Object> {
  Map<Object, Object> toMapByField(Object Function(Object) keySelector) {
    return {for (final element in this) keySelector(element): element};
  }
}
