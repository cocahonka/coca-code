// ignore_for_file: cascade_invocations, unused_field, prefer_final_fields, prefer_const_declarations, unused_local_variable, prefer_const_constructors, unnecessary_type_check, omit_local_variable_types, sort_constructors_first

// План
//? Методы
//* 1. Геттеры и сеттеры
//* 2. Статические поля и методы
//* 3. late
//? Конструкторы
//* 1. Константные конструкторы
//* 2. Фабричные конструкторы
//* 3. Операторы as и is

import 'dart:math';

void gettersAndSetters() {
  //? Геттеры (метод чтения) и сеттеры (метод записи)
  //* Геттеры и сеттеры - это методы, которые позволяют получить и установить значения полей класса.
  //* Если определять более точно - геттеры и сеттеры это свойства полей
  //* Геттеры и сеттеры позволяют контролировать доступ к полям класса, что позволяет управлять изменением и чтением данных

  //? Геттеры и сеттеры неявно есть для каждого поля
  //* Если поле не final и публичное для него есть неявный геттер и сеттер
  //* Если поле final и публичное для него есть неявный геттер
  //* Если поле приватное то неявного геттера и сеттера нет (вне контекста класса)

  //? Зачем?
  //* Доступ и модификация приватных полей
  //* Валидация данных
  //* Вычисляемые свойства

  //? Синтаксис
  //* Type get name => value;
  //* Type get name { return value; }
  //
  //* set name(Type value) => field = value;
  //* set name(Type value) { field = value; }

  //; Если у вас есть геттер и сеттер с одним именем, тогда Type должно совпадать

  // Примеры
  final student = Student();
  student.name = 'John Doe';
  student.age = 25;
  student.height = 180;
  student.info = 'John Doe;25;180';

  // Использование каскадных операторов выглядит более лаконично
  final marcus = Student()
    ..name = '   Marcus     '
    ..height = 169
    ..age = 20;
  print('info: ${marcus.info}, is adult: ${marcus.isAdult}');

  //; В идеале геттеры и сеттеры должны быть простыми и не выполнять сложные операции
  //; Например сеттер не должен присваивать несколько значений разным полям
  //; Сеттеры и геттеры могут быть приватными

  // Еще примеры
  final sword = FantasySword('excalibur');
  print(sword.name);
  sword.name = 'DURANDAL';
  print(sword.name);

  //* Намного чаще используются лишь геттеры, так как лучше работать по принципу иммутабельности
}

class Student {
  // Приватные поля
  String _name = 'Unknown';
  int _age = 0;
  int _height = 0;
  int _weight = 0;

  // Плохое использование (unnecessary)
  int get age => _age;
  set age(int value) => _age = value;

  // Хорошее использование
  String get name => _name;
  set name(String value) => _name = value.trim();

  // Плохое использование (avoid_setters_without_getters)
  set height(int value) => _height = value;

  // Хорошее использование (вычисляемое свойство)
  bool get isAdult => _age >= 18;

  // Плохое использование (сеттер info выполняет слишком много)
  String get info => '$_name $_age y.o. $_height cm.';
  set info(String value) {
    final parts = value.split(';');
    _name = parts[0];
    _age = int.parse(parts[1]);
    _height = int.parse(parts[2]);
  }

  //! Ошибка - несовпадение типов с сеттером
  // String get weight => '$_weight kg.';
  // set weight(int value) => _weight = value;
}

// Пример геттеров
class HomeworkStudent {
  HomeworkStudent({
    required this.name,
    required List<int> marks,
    required this.id,
  }) : _marks = marks;

  final String name;
  final List<int> _marks;
  final int id;

  double get averageMark => _marks.reduce((a, b) => a + b) / _marks.length;
  String get formattedInfo => 'Name: $name, ID: $id, Average mark: $averageMark, Marks: $_marks';

  void addMark(int mark) => _marks.add(mark);
}

// Пример сеттеров
class UserModel {
  String? _email;
  String? _name;
  String? _password;

  String? get email => _email;
  set email(String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue != null && trimmedValue.contains('@')) {
      _email = trimmedValue;
    }
  }

  String? get name => _name;
  set name(String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue != null && trimmedValue.isNotEmpty) {
      _name = trimmedValue;
    }
  }

  String? get password => _password;
  set password(String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue != null && trimmedValue.length >= 6) {
      _password = trimmedValue;
    }
  }

  bool get isValid => _email != null && _name != null && _password != null;
}

// Пример с тем и другим
class FantasySword {
  FantasySword(this._name);

  String _name;
  String get name => 'The Legendary ${_name[0].toUpperCase() + _name.substring(1)}';
  set name(String value) => _name = value.toLowerCase().split('').reversed.join();
}

void staticFieldsAndMethods() {
  //? Статические поля и методы (static)
  //* 1. Принадлежат классу, а не объекту
  //* 2. Доступны без создания объекта
  //* 3. Используются для хранения общей информации для всех объектов класса
  //* 4. Не могут обращаться к нестатическим полям и методам

  //? Зачем?
  //* Хранение общей информации для всех объектов класса
  //* Глобальные константы

  //? Синтаксис
  //* static Type field = value;
  //* static Type get field => value;
  //* static Type method() { return value; }

  // Примеры
  print('Total students: ${StudentManager.totalStudents}');
  final letiStudent = StudentManager.createLetiStudent('Marcus');
  final suaiStudent = StudentManager.createSuaiStudent('Ivan');
  print('Total students: ${StudentManager.totalStudents}');

  print(letiStudent.isExpelled);
  print(suaiStudent.isExpelled);

  //; Использование статический ИЗМЕНЯЕМЫХ полей - это ОЧЕНЬ плохо (глобальне переменные)
  //; Статические поля должны быть неизменяемыми, иначе это нарушает принципы ООП и создает много проблем

  // Пример бага (студент уже был отчислен, но мы изменили порог отчисления)
  StudentManager.expelMark = 1;
  print(letiStudent.isExpelled);
  print(suaiStudent.isExpelled);

  // https://github.com/search?q=repo%3Acocahonka%2Fsuai-leetcode-bot%20static&type=code
  // https://github.com/search?q=repo%3Acocahonka%2Fcomfy-whitelist%20companion&type=code
}

class StudentManager {
  static int totalStudents = 0;
  static int expelMark = 2;
  static const yearsForGraduation = 4;

  static SuaiStudent createSuaiStudent(String name) {
    totalStudents++;
    return SuaiStudent(name);
  }

  static LetiStudent createLetiStudent(String name) {
    totalStudents++;
    return LetiStudent(name);
  }
}

class SuaiStudent {
  SuaiStudent(this.name) : marks = [];

  final String name;
  final List<int> marks;
  bool get isExpelled => marks.any((mark) => mark <= StudentManager.expelMark);
}

class LetiStudent {
  LetiStudent(this.name) : marks = [2, 3, 4];

  final String name;
  final List<int> marks;
  bool get isExpelled => marks.any((mark) => mark <= StudentManager.expelMark);
}

void lateKeyword() {
  //? late
  //* 1. Позволяет отложить инициализацию поля до момента первого обращения к нему
  //* 2. Позволяет инициализировать поле потом и оставить его non-nullable

  //? Cинтаксис
  //* late Type name;

  final diceRoll = DiceRoll(sidesCount: 6, throwCount: 3);
  print('Max roll: ${diceRoll.maxRoll}');
  print('Rolls: ${diceRoll._rolls}');

  // https://github.com/cocahonka/flutter-training-enhanced-meals/blob/00f36976828c3918ba3a83ce28ba200edcb65138/lib/scopes/categories_scope.dart#L32

  //; С late нужно быть очень осторожным, тем более если поле не final
  //; А еще хуже если поле late публичное или статическое
}

class DiceRoll {
  DiceRoll({
    required this.sidesCount,
    required int throwCount,
  }) {
    this.throwCount = powBy2(throwCount);
  }

  static Random _random = Random();

  final int sidesCount;
  late final int throwCount;

  int powBy2(int value) => value * value;

  late final List<int> _rolls = List.generate(throwCount, (_) => _random.nextInt(sidesCount) + 1);
  late int maxRoll = () {
    print('Max Roll has been init');
    return _rolls.reduce(max);
  }();
}

void constConstructors() {
  //? Константные конструкторы
  //* 1. Позволяют создавать константные (каноничные) объекты
  //* 2. Позволяют использовать объекты в качестве констант

  //? Синтаксис
  //* const ClassName();

  //? Зачем
  //* Оптимизация памяти, производительности

  //* Константные конструкторы могут быть использованы только в классах у которых все поля final

  // Пример
  const point = Point(1, 2);
  const point2 = Point(1, 2);
  final point3 = Point(2, 4);
  print(point.hashCode);
  print(point2.hashCode);
  print(point3.hashCode);
  print(point == point2);

  //; Обычно константные конструкторы используются для создания моделей (дата-классов)
  //; Дата классы - это классы, главная цель которых содержать иммутабельные данные
}

class Point {
  const Point(this.x, this.y);

  const Point.zero()
      : x = 0,
        y = 0;

  final int x;
  final int y;
}

void fabricConstructor() {
  //? Фабричные конструкторы
  //* Обычно фабричные конструкторы используются для:
  //* 1. Конструктор должен не все время возвращать новый объект, возможно возвращать старый
  //* 2. Вам нужно проделать дополнительную работу ДО создания объекта, работа которая не может быть выполнена в списке инициализации
  //* 3. Поля не могут быть просчитаны в списке инициализации, (можно использовать late final НО factory безопаснее!)

  //? Синтаксис
  //* factory ClassName.constructorName() { return ClassName(); }
  // или
  //* factory ClassName() { return ClassName(); }

  //? Отличия от обычного конструктора
  //* 1. Фабричный конструктор можно расматривать как метод, и этот метод имеет аргументы и тело (нету списка иницилизации)
  //* 2. Цель фабричного конструктора - вернуть объект, а НЕ инициализировать поля
  //* 3. Фабричный конструктор не имеет доступа к this

  //? Зачем
  //* Кеширование объектов
  //* Преобразование объектов

  // Пример
  final cached1 = SomethingCached.firstCached('Marcus');
  final cached2 = SomethingCached.firstCached('Habuba');
  final cached3 = SomethingCached.secondCached('Marcus');
  final cached4 = SomethingCached.secondCached('Ivan');
  print('chached1 Marcus : ${cached1.hashCode}');
  print('chached2 Habuba : ${cached2.hashCode}');
  print('chached3 Marcus : ${cached3.hashCode}');
  print('chached4 Ivanus : ${cached4.hashCode}\n');

  // Пример 2
  final logger1 = Logger('UI');
  final logger2 = Logger('UI');
  print(logger1 == logger2);

  final logger3 = Logger.fromJson({'name': 'UI'});
  final logger4 = Logger.fromJson({'name': 'UX'});
  print(logger3 == logger2);
  print(logger4 == logger3);

  // Пример 3
  final marcusStudent = Student()
    ..name = 'Marcus'
    ..age = 20
    ..height = 169;

  final user = User.fromStudent(marcusStudent);
  print(marcusStudent.info);
  print(marcusStudent.hashCode);
  print(user.name);
  print(user.email);
}

//? Кэширование объектов
//* Представим задачу:
//* Нам нужно при создании очередного объекта вернуть старый объект, если такой уже существует
//* Как различать новые и страрые объекты? - по полям
//* Значит если какие-либо выбранные нами поля уже существуют в кэше, то мы возвращаем старый объект
//* В данном случае будем ориетироваться на поле String value
class SomethingCached {
  final String name;

  SomethingCached._internal(this.name);

  static final Map<String, SomethingCached> _cache = {};

  static SomethingCached firstCached(String value) {
    if (_cache.containsKey(value)) {
      final oldObject = _cache[value]!;
      return oldObject;
    } else {
      final newObject = SomethingCached._internal(value);
      _cache[value] = newObject;
      return newObject;
    }
  }

  factory SomethingCached.secondCached(String value) {
    return _cache.putIfAbsent(value, () => SomethingCached._internal(value));
  }
}
//? В чем отличие от static?
//* Статические методы и правда могут быть использованы как factory конструкторы
//* Но поддержка остальный принципов ООП страдает
//* (мы не можем переопределить статический метод в дочернем классе, не сможем использовать дженерики и т.д.)

class Logger {
  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name) : mute = false;

  static final Map<String, Logger> _cache = <String, Logger>{};

  final String name;
  bool mute;

  void log(String msg) {
    if (!mute) print(msg);
  }
}

class User {
  const User(this.name, this.email);

  factory User.fromStudent(Student student) {
    return User(student.name, student.hashCode.toString());
  }

  final String name;
  final String email;
}

class LateFactory {
  factory LateFactory(String id) {
    return LateFactory._internal(int.tryParse(id) ?? 0);
  }

  LateFactory._internal(this.value);

  final int value;
}

class LateFactory2 {
  LateFactory2(String id) {
    value = int.tryParse(id) ?? 0;
  }

  late final int value;
}

void asAndIs() {
  //? Type test operators
  //* 1. as - приведение типа
  //* 2. is - проверка типа
  //* 3. is! - проверка что объект не является указанным типом

  // Пример
  final student = Student()
    ..name = 'Marcus'
    ..age = 20
    ..height = 169;

  final user = User.fromStudent(student);

  if (user is User) print('User is User');
  if (student is User) print('Student is User');

  final unknownMap = <String, Object>{
    'age': 20,
    'name': 'John',
  };

  final (age, name) = (unknownMap['age']!, unknownMap['name']!);
  print(age is int);
  print(name is! String);

  // Приведение типа
  final int intAge = age as int;
  final String stringName = unknownMap['name']! as String;

  //; Оператор as считается опасным, так как он может вызвать исключение (всегда сначала проверяйте через is)
  //; Тем более не забываем про смарткасты
  final int intAge2 = age is int ? age : 0;
}

void main() {
  final labels = {
    'gettersAndSetters': gettersAndSetters,
    'staticFieldsAndMethods': staticFieldsAndMethods,
    'lateKeyword': lateKeyword,
    'constConstructors': constConstructors,
    'fabricConstructor': fabricConstructor,
    'asAndIs': asAndIs,
  };

  for (final MapEntry(key: label, value: action) in labels.entries) {
    print('${'=' * 20} $label ${'=' * 20}');
    action();
    print('\n');
  }
}

// План
//? Методы
//* 1. Геттеры и сеттеры
//* 2. Статические поля и методы
//* 3. late
//? Конструкторы
//* 1. Константные конструкторы XXX
//* 2. Фабричные конструкторы XXX
//* 3. Операторы as и is XXX

// Домашка

//? 1. Реализовать паттерн синглтон для класса логгера
//* Логгер должен иметь поле префикса и метод для логирования (через print)
//* Паттерн синглтон - это паттерн, который гарантирует, что у класса есть только один экземпляр (объект)
//* Т.е. при каждом обращении к конструктору должен возвращаться один и тот же объект
//* Конструктор ничего не принимает

//? 2. Реализовать полнодуплексный дата класс для студента
//* Дата класс - это класс, который в основном базируется на данных и эти данные неизменяемы
//* Класс в этом задании должен иметь
//* 1. Поля: имя, год постулпения, средний балл, список оценок, возраст
//* 2. Константный конструктор
//* 3. Конструктор для создания студента из json
//* 4. Метод copyWith для создания нового студента на основе старого с возможностью изменить поля (если поля переданы)
//* Если поля не переданы, то оставляем старые
//* 5. Метод toJson для преобразования студента в json
//* 6. Геттер для получения всей информации о студенте в красивом ввиде
//* 7. Геттер для проверки является ли студент лауреатом (средний балл больше 4.8 и год постулпения меньше 2020)

//? 3. Создать фабрику микроволновок с микроволновками
//* См. прошлое задание и переделайте его
//* Только теперь реализовать всё в одном классе (счётчик моделей должен работать исправно)

//? 4. Реализуйте СТЭК на основе List<int>
//* Требования
//* 1. Два конструктора
//* 2. Методы push pop popOrNull
//* 3. Геттеры front frontOrNull isEmpty isNotEmpty entries
//* 4. entries помимо того что является геттером еще должен быть sync*

//? 5. Реализуйте класс «Кошелек»
//* В класс могут добавляться экземпляры дата-класса Wallet различного номинала.
//* Кошелек должен иметь возможность возвращать полную сумму денег,
//* У каждого кошелка максимальный лимит в 100 едениц валюты,
//* последующее добавление валюты не должно приводить к увеличению суммы
