// ignore_for_file: cascade_invocations, prefer_const_constructors, avoid_equals_and_hash_code_on_mutable_classes

import 'dart:collection';
import 'dart:io';
import 'dart:math';

void inheritance() {
  //? Наследование...

  //* Наследование является одним из ключевых принципов ООП.

  //* Наследование невозможно без инкапсуляции.
  //* Наследование открывает путь полиморфизму.
  //* Полиморфизм является самой важной частью ООП статически типизированных языков.

  //; Наследование - средство языка, обеспечивающее возможность повторно использовать код
  //; и способствующее созданию иерархии классов.

  //* Dart использует Mixin Based Inheritance
  //* Это накладывает следующие ограничения:
  //* 1. Класс может наследовать только один класс
  //* 2. Методы расширения являются способом добавления функциональности к классу без наследования
  //* 3. Класс может реализовывать несколько интерфейсов
  //* 4. Класс может использовать несколько миксинов

  //? Как?
  //* Для наследования используется ключевое слово extends
  //* Синтаксис: class Child extends Parent {}
  //* Где Parent - это родительский/супер/базовый класс, а Child - подкласс/дочерний/производный класс
  //* Вводится ключевое слово super для доступа к родительскому классу (полям, методам, конструкторам)

  // Простейший пример
  final mammal = Mammal();
  mammal.breathe();
  //! mammal.speak(); // Ошибка: The method 'speak' isn't defined for the class 'Mammal'

  final human = Human();
  human.breathe();
  human.speak();

  // Расширенный пример
  const personPaul = Person('Paul', 20, gender: Gender.female);
  const personIvan = Person('Ivan', 19, gender: Gender.male);

  personPaul.introduce();
  personPaul.greet(personIvan);

  final studentIvan = Student([], '123456', 'Ivan', 19, gender: Gender.male);
  final studentMarcus = Student.marcus([5, 4, 3, 5, 5], '654321');
  final studentOfSuai = SuaiStudent('654321', 'Habuba', 12, gender: Gender.male);

  studentIvan.introduce();
  studentIvan.introduceStudent();
  studentIvan.greetStudent(studentMarcus);
  studentIvan.greetStudent(studentOfSuai);

  //? Проблемы и сложности...
  //* Начиная с наследования начинаются проблемы с проектированием и вообще с понимаем ООП
  //* Существует миллион правил, практик, применений но каждое имеет как плюсы так и минусы
  //* Но единого верного решения нет.
  //* В текущих реалиях наследование считается злом, хотя благодаря ему и существует ООП
}

//? Простейший пример наследования
//* Класс Human наследует/расширяет класс Mammal, добавляя метод speak
class Mammal {
  void breathe() {
    print('Mammal is breathing');
  }
}

class Human extends Mammal {
  void speak() {
    print('Human is speaking');
  }
}

enum Gender { male, female }

//? Пример использования ключевого слова super
class Person {
  const Person(this.name, this.age, {required this.gender});

  final String name;
  final int age;
  final Gender gender;

  bool get isAdult => age >= 18;

  void introduce() {
    print('Hello, my name is $name, I am $age years old');
  }

  void greet(Person other) {
    print('Hello, ${other.name}, nice to meet you, I am $name');
  }
}

class Student extends Person {
  //* При наследовании обязательно нужно инициализировать поля родительского класса
  //* Для этого используется ключевое слово super (как this)
  Student(
    List<int> marks,
    this.passId,
    super.name,
    super.age, {
    required super.gender,
  }) : _marks = [...marks];

  //* Развернутый синтаксис конструктора
  Student.marcus(List<int> marks, this.passId)
      : _marks = [...marks],
        super('Marcus', 20, gender: Gender.male);

  Student.withGender(
    List<int> marks,
    this.passId,
    String name,
    int age,
  )   : _marks = [...marks],
        super(name, age, gender: Gender.female);

  final String passId;
  final List<int> _marks;

  UnmodifiableListView<int> get marks => UnmodifiableListView(_marks);
  double get averageMark => _marks.fold(0, (a, b) => a + b) / _marks.length;

  bool get isUniversityStudent => isAdult && averageMark >= 4.5;

  void introduceStudent() {
    //* Оба варианта вызова метода introduce() будут работать корректно
    //* Поэтому можно использовать любой, запись super понадобиться при полиморфизме
    super.introduce();
    //introduce();

    print('My passId is $passId');
  }

  void greetStudent(Student other) {
    //* Почему это работает? - Student наследует Person, а значит является Person
    //* Это пример полиморфизма, но о нем позже.
    greet(other);
    print('I am a student');
  }
}

class SuaiStudent extends Student {
  SuaiStudent(
    String passId,
    String name,
    int age, {
    required Gender gender,
  }) : super(
          [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5],
          passId,
          name,
          age,
          gender: gender,
        );
}

void polymorphism() {
  //? Полиморфизм

  //* Полиморфизм - наиболее важная часть ООП статически типизированных языков

  //* Полиморфизм невозможен без наследования,
  //* Наследование невозможно без инкапсуляции.
  //* Статическое ООП бесполезно без полиморфизма.
  //* Полиморфизм - супер важен для действительного ООП, но второстепенен для желаемого.

  //* Желаемое ООП - это изначальная идея ООП, и подразумевалось что ООП должно быть только в динамических языках.
  //* Действительное ООП - это ООП в статически типизированных языках, которое не может существовать без полиморфизма.

  //* Действительное ООП реализовано в: Dart, Java, C#, Kotlin
  //* Желаемое ООП реализовано в: Python, Ruby, JavaScript, PHP

  //? Полиморфизм - множество форм.
  //* Полиморфизм имеет несколько форм и определений к ним
  //* 1. Ad Hoc (Специальный) - перегрузка методов (плохая практика и в dart такого нету)
  //* 2. Generic (Параметрический) - обобщенное программирование
  //* 3. SubTypes (Полиморфизм подтипов) - истинный полиморфизм - тот без которого действительное ООП не существует

  //? Получается ответ на главный вопрос: что такое полиморфизм?
  //* Вероятно будет предполагать именно полиморфизм подтипов
  //* И так:
  //; Полиморфизм - это способность использовать объекты разных классов через ОБЩИЙ интерфейс,
  //; где подклассы могут отвечать ПО-РАЗНОМУ на обращение к этому интерфейсу.

  //? Разберем по порядку
  //* ОБЩИЙ интерфейс - в рамках наследования - это один из базовых классов
  //* Под интерфейсом имеются ввиду публичные поля и методы
  //* В примере со студентами это класс Person или Student - все зависит от желаемого интерфейса
  //
  //* ПО-РАЗНОМУ - это когда поведение метода зависит от класса объекта, в нашем случае от наследника
  //* Чтобы иметь возможность реализовать эту идею нужно воспользоваться наследованием и переопределением методов
  //* Переопределение методов - это когда в дочернем классе переопределяется метод родительского класса
  //* Для этого используется ключевое слово override, а точнее аннотация @override
  //* Переопределять можно не только методы, но и поля и геттеры/сеттеры

  // Пример
  //* Не используем полиморфизм
  final consoleLogger = ConsoleLogger('[CONSOLE]');
  consoleLogger.log('Hello, World!');

  //* Используем полиморфизм
  //* В этом случае мы приводим fileLogger к общему "интерфейсу" - Logger
  //* Но хотя fileLogger теперь и имеет тип Logger, метод log будет вызываться из класса FileLogger
  final Logger fileLogger = FileLogger('[FILE]');
  fileLogger.log('Hello, World!');

  //* Также стоит обратить внимание что когда мы делаем "апкаст" - приведение типа к общему "интерфейсу"
  //* То мы не можем более воспользоваться НОВЫМИ методами и полями, которые есть в дочернем классе
  //! fileLogger.file; // Ошибка: The getter 'file' isn't defined for the class 'Logger'

  //* Можно попробовать сделать и "даункаст", но никаких гарантий что объект
  //* который мы хотим привести к более конкретному типу, действительно является этим типом
  //! final FileLogger fileLogger2 = fileLogger; // Ошибка: A value of type 'Logger' can't be assigned to a variable of type 'FileLogger'

  //* Но есть решение - использовать is
  if (fileLogger is FileLogger) {
    print(fileLogger.file);
  }

  if (fileLogger is ConsoleLogger) {
    print(consoleLogger.output);
  }

  // Пример с функцией
  final loggers = [
    ConsoleLogger('[CONSOLE]'),
    FileLogger('[FILE]'),
    Logger('[LOGGER]'),
    ConsoleLogger('[CONSOLE2]'),
  ];

  showPolymorphismInList(loggers);

  //; greetStudent - пример полиморфизма который мы использовали ранее
}

void showPolymorphismInList(List<Logger> loggers) {
  for (final logger in loggers) {
    logger.log('Test message');
  }
}

//* "Базовый" класс логера с методом log
class Logger {
  Logger(this.prefix) : mute = false;

  final String prefix;
  bool mute;

  //* Метод log ничего не делает, он нужен только для создания "интерфейса"
  void log(String message) {}
}

//* Класс логера, который выводит сообщение в консоль
class ConsoleLogger extends Logger {
  ConsoleLogger(super.prefix);

  final Stdout output = stdout;

  //* Меняем поведение метода log
  @override
  void log(String message) {
    if (!mute) {
      output.writeln('$prefix: $message');
    }
  }
}

//* Класс логера, который выводит сообщение в файл
class FileLogger extends Logger {
  FileLogger(super.prefix);

  late final File file = File('log.txt')..createSync();

  //* Меняем поведение метода log
  @override
  void log(String message) {
    if (!mute) {
      file.writeAsStringSync('$prefix: $message\n', mode: FileMode.append);
    }
  }
}

void polymorphism2() {
  //? super и override
  //* Теперь мы можем переопределять поведения дочерних классов, а также умеем приводить объекты к общему интерфейсу
  //* У нас также имеется возможность использовать базовые определения методов в переопределенных методах
  //* Для этого нам понадобиться ключевое слово super, если ранее оно было не совсем нужно, то теперь оно становиться важным

  // Пример
  final student = Student2([5, 4, 3, 5, 5]);
  print(student.average); // 4.4
  final Student2 suaiStudent = SuaiStudent2([5, 4, 3, 5, 5]);
  print(suaiStudent.average); // 4.84

  print(suaiStudent); // [5, 4, 5]

  //? Переопределение супер-базовых методов и геттеров
  //* Самый общий тип в Dart - Object
  //* Object содержит такие методы и геттеры как: hashCode, toString, operator == и т.д.
  //* Поэтому переопределение этих методов и геттеров может быть полезным
  //* (красивый вывод объекта, сравнение объектов по внутреннему состоянию и т.д.)
  // Пример
  final meal = Meal('Burger', 150, 300);
  print(meal); // Burger: 150₽, 300 kcal

  final meal2 = Meal('Burger', 150, 300);
  print(meal == meal2); // true

  final meal3 = Meal('Pizza', 120, 930);
  print(meal == meal3); // false

  print(meal3); // Pizza: 120₽, 930 kcal

  //; Задание прямо на лекции:
  //* Реализовать систему навигации в картах
  //* Должен быть класс Navigator, который будет строить маршрут между двумя точками
  //* Маршрут может быть по дороге, пешком или на общественном транспорте
  //* Каждый из способов требует инкапсуляции нужных для него данных, так что не получится использовать enum

  playNavigator();
}

//* Задание с навигацией

void playNavigator() {
  final nav = Navigator(WalkStrategy());

  nav.start();

  nav.routeStrategy = PublicStrategy();

  nav.start();
}

typedef Point = (int, int);

class Navigator {
  Navigator(this.routeStrategy);

  void start() {
    routeStrategy.buildRoute((1, 2), (1, 2));
  }

  RouteStrategy routeStrategy;
}

class RouteStrategy {
  void buildRoute(Point a, Point b) => throw UnimplementedError();
}

class WalkStrategy extends RouteStrategy {
  @override
  void buildRoute(Point a, Point b) {
    print('walk $a $b');
  }
}

class PublicStrategy extends RouteStrategy {
  @override
  void buildRoute(Point a, Point b) {
    print('bus $a $b');
  }
}

class CarStrategy extends RouteStrategy {
  @override
  void buildRoute(Point a, Point b) {
    print('car $a $b');
  }
}

//? Пример с использованием super
class Student2 {
  Student2(List<int> marks) : _marks = [...marks];

  final List<int> _marks;

  void log(String message) {
    print(message);
  }

  double get average => _marks.fold(0, (a, b) => a + b) / _marks.length;
}

class SuaiStudent2 extends Student2 {
  SuaiStudent2(super.marks);

  //* Переопределяем геттер average
  //* Но внутри переопределенного метода мы можем использовать базовое определение метода благодаря super
  @override
  double get average => min(super.average * 1.1, 5);
}

//? Пример переопределения супер-базовых методов и геттеров
//; Важно, переопределять методы для сравнения нужно только в immutable классах (все поля final)
class Meal {
  Meal(this.name, this.price, this.calories);

  final String name;
  final double price;
  final double calories;

  //* Теперь при вызове object.toString будет выводиться эта информация
  @override
  String toString() => '$name: $price₽, $calories kcal';

  //* Для того чтобы объекты можно было сравнивать по внутреннему состоянию (состоянию полей)
  //* Нужно переопределить hashCode и operator ==
  @override
  int get hashCode => Object.hashAll([name, price, calories]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Meal &&
        other.runtimeType == runtimeType &&
        name == other.name &&
        price == other.price &&
        calories == other.calories;
  }
}

void conclusions() {
  //? Выводы
  //* Наследование - это один из ключевых принципов ООП, который позволяет использовать полиморфизм
  //* Но само наследование по отдельности не имеет смысла, оно нужно только в связке с полиморфизмом.
  //* Но даже в связке с полиморфизмом наследование по большей части добавляет только проблем.

  //* Основная проблема наследования - это то, что оно не приспособлено к изменениям
  //* Если в программе будет много наследников и родителей, то изменение одного из них может привести к каскаду изменений
  //* Решением этой проблемы будет использование:
  //* 1. композиции, агрегации (паттерны мост, стратегия и др)
  //* 2. интерфейсов
  //* 3. миксинов
  //* и д.р.

  // https://www.youtube.com/watch?v=ve3eAhuaF0s&ab_channel=ExtremeCode (полиморфизм)
  // https://www.youtube.com/watch?v=-n6784KeQMs&ab_channel=ExtremeCode (проблемы наследования)
  // https://refactoring.guru/ru/design-patterns/bridge (мост)

  //; Проблема ромба
  //* Проблема ромба - это когда один класс наследует два класса, которые в свою очередь наследуют один и тот же класс
  //* В таком случае возникает проблема с доступом к методам и полям, которые могут быть переопределены
  //* Тем более в таком случае возникают множественные внутренние объекты, хотя класс один
  //* Если обычное наследование приводит к проблемам, то множественное наследование...

  //; Следующая лекция
  //* Следующая лекция будет посвящена принципу абстракции, которая в том числе будет решать проблему наследования
}

void main() {
  final labels = {
    'inheritance': inheritance,
    'polymorphism': polymorphism,
    'polymorphism2': polymorphism2,
  };

  final divider = '=' * 20;

  for (final MapEntry(key: title, value: action) in labels.entries) {
    print('$divider $title $divider');
    action();
    print('\n');
  }
}

// Домашнее задание

//? 1. Создайте следующую иерархию классов:
//* 1. Fightable - имеет поля diceCount и diceSides, методы attack и getDamage, геттер damageRoll
//* 2. Creature - имеет поля name, health, геттер isAlive
//* 3. Monster - имеет поле description
//* 4. Goblin - определяет значения полей
//* 5. Orc - определяет значения полей
//
//* метод getDamage возвращает void
//* метод attack возвращает int (количество нанесенного урона)
//* геттер damageRoll возвращает int (результат броска кубиков)
//
//* Рандомно заполните лист 10 конкретными существами
//* Рандомно выберите два существа и пусть они сражаются
//* Сражения происходят до тех пор, пока одно из существ не умрет
//* Вывести победителя (должен остаться только один элемент в листе)
//; Переопределите toString

//? 2. Создайте класс Equatable...
