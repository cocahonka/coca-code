// ignore_for_file: cascade_invocations, prefer_const_constructors, avoid_equals_and_hash_code_on_mutable_classes, no_runtimetype_tostring, one_member_abstracts

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
  final studentOfSuai = SuaiStudent(
    '654321',
    'Habuba',
    12,
    gender: Gender.male,
  );

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
base class Mammal {
  void breathe() {
    print('Mammal is breathing');
  }
}

final class Human extends Mammal {
  void speak() {
    print('Human is speaking');
  }
}

enum Gender { male, female }

//? Пример использования ключевого слова super
base class Person {
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

base class Student extends Person {
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

  Student.withGender(List<int> marks, this.passId, String name, int age)
    : _marks = [...marks],
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

final class SuaiStudent extends Student {
  SuaiStudent(String passId, String name, int age, {required Gender gender})
    : super(
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
    //Logger('[LOGGER]'),
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
abstract base class Logger {
  Logger(this.prefix) : mute = false;

  final String prefix;
  bool mute;

  //* Метод log ничего не делает, он нужен только для создания "интерфейса"
  void log(String message) {}
}

//* Класс логера, который выводит сообщение в консоль
final class ConsoleLogger extends Logger {
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
final class FileLogger extends Logger {
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

final class Navigator {
  Navigator(this.routeStrategy);

  void start() {
    routeStrategy.buildRoute((1, 2), (1, 2));
  }

  RouteStrategy routeStrategy;
}

abstract interface class RouteStrategy {
  void buildRoute(Point a, Point b);
}

final class WalkStrategy extends RouteStrategy {
  @override
  void buildRoute(Point a, Point b) {
    print('walk $a $b');
  }
}

final class PublicStrategy extends RouteStrategy {
  @override
  void buildRoute(Point a, Point b) {
    print('bus $a $b');
  }
}

final class CarStrategy extends RouteStrategy {
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
class Meal implements Comparable<Meal> {
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

  @override
  int compareTo(Meal other) {
    if (price == other.price) {
      return calories.compareTo(other.calories);
    }

    return price.compareTo(other.price);
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

  final meals = [
    Meal('Pizza', 12.32, 860),
    Meal('Burger', 5.99, 450),
    Meal('Salad', 3.99, 120),
    Meal('Pryanik', 0.99, 50),
    Meal('Sushi', 15.99, 600),
    Meal('Cheese cake', 7.99, 350),
  ];

  meals.sort();

  print(meals);
}

// Домашнее задание
//? 1. Система уведомлений
//* Реализовать систему уведомлений, которая поддерживает разные типы уведомлений (например, Email, SMS, Push).
//* Каждое уведомление должно отправляться по-своему и содержать различную информацию.
//* Отправление уведомления происходит с помощью метода со следующей сигнатурой: void send(String recipient, String message)
//* Создать класс NotificationManager, который будет хранить, позволять добавлять и отправлять уведомления.
//* Для отправки уведомлений у NotificationManager должен быть метод void sendAll(String recipient, String message)
//* После отправки всех уведомлений, NotificationManager должен очищать список уведомлений
//* Пример использования:
/*
 final manager = NotificationManager();

  manager.addNotification(EmailNotification(header: 'Hello from Dart'));
  manager.addNotification(SMSNotification(maximumTimeout: 10, cost: 12));
  manager.addNotification(PushNotification(prefix: '[Dart is awesome]'));

  manager.sendAll('user@example.com', 'Hello, this is a test notification!');
*/

//? 2. Создайте следующую иерархию классов:
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

//? 3. Реализуйте паттерн "Состояние" - State
//* Паттерн нужно продемонстрировать на примере аудиоплеера
//* Суть аудиоплеера такова:
//* 1. Плеер может находиться в трех состояниях: заблокирован, готов к воспроизведению, воспроизведение
//* 2. У плеера следующий интерфейс взаимодействия: заблокировать, играть, включить следующий трек, остановить
//* 3. В зависимости от события и состояния сами определите исход, вот некоторые примеры:
//* Если плеер заблокирован, то при нажатии на кнопку "заблокировать" плеер должен разблокироваться
//* Если плеер готов к воспроизведению, то при нажатии на кнопку "следующий трек" плеер должен поставить следующий трек,
//* но не начинать его воспроизведение (оставаться в состоянии готовности)
//* Также у аудиоплеера есть некоторая зависимость от внешнего сервиса Locker, в этом сервисе есть метод tryUnlock,
//* Он должен вызываться при попытке разблокировать плеер, и если метод вернет true, то плеер разблокируется
//
//; Далее у задания будут две части, каждую часть реализуйте в ОТДЕЛЬНОМ файле и не удаляйте код!
//
//* Часть 1. Реализация без паттерна
//* Реализуйте аудиоплеер без использования паттерна "Состояние", используйте знания которые получили раньше
//* Проверьте работоспособность плеера при помощи считывания ввода с клавиатуры и вызова соответствующих методов интерфейса взаимодействия
//
//* Часть 2. Реализация с паттерном
//* Паттерн "Состояние" предполагает следующие пункты
//* 1. Создание отдельных классов для каждого состояния, в которых будет инкапсулировано поведение, соответствующее данному состоянию
//* 2. Главный класс, называемый "Контекст", вместо того, чтобы хранить код всех состояний, будет хранить ссылку на текущее состояние и делегировать ему работу
//* 3. Чтобы состояния могли инициировать переходы состояний и иметь доступ к зависимостям, каждому состоянию передается ссылка на контекст
//* Реализуйте аудиоплеер используя паттерн "Состояние", работоспособность проверьте также как и в первой части
//; УЧТИТЕ что код в "main" не должен поменяться и должен работать с обоими реализациями
//; P.S Паттерн состояние похож на паттерн "Стратегия", изученный в лекции - оба паттерна используют композицию
//; P.S.S код Locker
/*
class Locker {
  static final _random = Random();

  /// return true if player is successfully unlocked
  bool tryUnlock() => _random.nextDouble() >= 0.25;
}
*/

//? 4. Виджеты
//* Вам нужно реализовать простую систему виджетов, которая позволяет строить деревья виджетов и выводить их на экран.
//*     1. Реализуйте три вида виджетов: Text, Picture и Column.
//*     2. У каждого виджета должен быть метод build(), а также опциональное поле child, которое МОЖЕТ содержать другой виджет.
//*     3. Каждый метод build() в КОНЦЕ должен вызывать метод build() дочернего виджета (child), если он существует,
//*        - и возвращать его результат (результат build()).
//*     P.S - Сигнатура build: Widget? build()
//* Описание виджетов:
//*     1. Text: выводит текст.
//*     2. Picture: выводит ссылку на картинку.
//*     3. Column: выводит "Column" и вызывает метод build() для каждого виджета, который содержится в его списке contents.
//* Учтите, что виджеты принимают не только дочерние виджеты, но и другие параметры.
//* Например виджет текст принимает String data
// Пример кода:
/*
void main() {
  final longWidgetTree = Column(
    contents: [
      Text(data: 'Hello'),
      Column(
        contents: [Text(data: 'World'), Picture(url: 'https://example.com/image.png')],
        child: Column(
          contents: [Text(data: 'Goodbye')],
          child: Picture(
            url: 'https://example.com/another-image.png',
            child: Text(data: 'Word'),
          ),
        ),
      ),
    ],
  );

  longWidgetTree.build();
}
*/
// Вывод
/*
Column
Text: Hello
Column
Text: World
Picture: https://example.com/image.png
Column
Text: Goodbye
Picture: https://example.com/another-image.png
Text: Word
*/

//? 5. Создайте класс Equatable
//* Класс должен иметь:
//* 1. Публичный геттер props List<Object?> по дефолту возвращающий пустой лист
//* 2. Переопределенные методы hashCode и operator == (на основе props)
//* 3. Переопределенный метод toString (на основе props)
//
//* Классы, которые наследуются от Equatable должны:
//* 1. Иметь константный конструктор
//* 2. Переопределять метод props (props - это список всех полей объекта)
//* После этого класс и его объекты должны быть способны к сравнению и выводу
//* Причем количество полей и их типы неважны и могут быть абсолютно любыми
//
//* Пример использования (проверяйте работу на этом примере):
//; P.S Конструктор должен быть константным, НО объект создавайте не константным
/*
class EqualityTest extends Equatable {
  const EqualityTest({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.f,
    required this.g,
  });

  final String a;
  final int b;
  final List<int> c;
  final List<Object?> d;
  final List<List<Set<int>>> e;
  final Map<int, List<Set<List<Map<String, int>>>>> f;
  final Map<int, List<Set<List<Map<List<Object?>, int>>>>> g;

  EqualityTest copyWith({
    String? a,
    int? b,
    List<int>? c,
    List<Object?>? d,
    List<List<Set<int>>>? e,
    Map<int, List<Set<List<Map<String, int>>>>>? f,
    Map<int, List<Set<List<Map<List<Object?>, int>>>>>? g,
  }) {
    return EqualityTest(
      a: a ?? this.a,
      b: b ?? this.b,
      c: c ?? this.c,
      d: d ?? this.d,
      e: e ?? this.e,
      f: f ?? this.f,
      g: g ?? this.g,
    );
  }

  @override
  List<Object?> get props => [a, b, c, d, e, f, g];
}

void main() {
  final test = EqualityTest(
    a: 'a',
    b: 1,
    c: [
      1,
      2,
      3,
    ],
    d: [
      1,
      2.5,
      'd',
    ],
    e: [
      [
        {1},
        {2},
        {3},
      ],
      [
        {4},
        {5},
        {6},
      ]
    ],
    f: {
      1: [
        {
          [
            {'1': 1},
            {'2': 2},
          ]
        },
        {
          [
            {'3': 3},
            {'4': 4},
          ]
        }
      ],
      2: [
        {
          [
            {'5': 5},
            {'6': 6},
          ]
        },
        {
          [
            {'7': 7},
            {'8': 8},
          ]
        }
      ],
    },
    g: {
      1: [
        {
          [
            {
              [
                '1',
                6,
                4.5,
                [5],
              ]: 1,
            },
            {
              [
                '1',
                6,
                4.5,
                [8, 10, null],
              ]: 2,
            },
          ]
        },
        {
          [
            {
              ['3']: 3,
            },
            {
              ['4']: 4,
            }
          ]
        },
      ],
      2: [
        {
          [
            {
              ['5']: 5,
            },
            {
              ['6']: 6,
            },
          ]
        },
        {
          [
            {
              ['7']: 7,
            },
            {
              ['8']: 8,
            }
          ]
        }
      ],
    },
  );
  print(test);
  print(test == test.copyWith()); // true
  print(test == test.copyWith(a: 'Z')); // false
}
*/
