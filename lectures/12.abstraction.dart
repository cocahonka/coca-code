// ignore_for_file: unused_element, no_runtimetype_tostring, unused_local_variable, cascade_invocations

import 'dart:math';

void abstraction() {
  //? Принцип абстракции

  //* Принцип или парадигма абстракции иногда не выделяется в отдельный принцип ООП,
  //* а рассматривается как часть других принципов, и считается "логическим" выводом всех принципов,
  //* которые должны делать программисты при работе с ООП.

  //* Но в множествах языках для абстракции существует много механизмов (интерфейсы, абстрактные классы и т.д),
  //* Поэтому для последовательного обучения мы будем рассматривать абстракцию как отдельный, самостоятельный принцип.

  //; Абстракция - это процесс выделения общих характеристик и функциональности объектов или системы, игнорируя детали реализации.

  //* Для того, чтобы абстракция давала неоспоримые преимущества, вместе с ней нужно тесно использовать полиморфизм.

  //? Зачем?
  //* 1. Упрощение проектирования
  //* 2. Упрощение понимания
  //* 3. Упрощение использования

  //? Преимущества
  //* 1. Выводится из пункта "Зачем"
  //* 2. Модульность (взаимозаменяемость)
  //* 3. Безопасность (скрытие деталей реализации)

  //? Реализация в dart
  //* Обычно языки предоставляют несколько ключевых конструкций для реализации абстракции:
  //* 1. Абстрактные классы (abstract class)
  //* 2. Интерфейсы (interface)
  //* Но Dart добавляет и позволяет комбинировать различные "модификаторы" для классов
  //* То есть, если в других языках вы можете использовать только истинные абстрактные классы или интерфейсы,
  //* То в dart можно сделать нечто среднее, чуть или менее похожее.
  //* Мы рассмотрим все ключевые слова, их комбинации и "истинные" определения (чистый интерфейс, чистый абстрактный класс)

  //; Зачем добавили модификаторы?
  //; Ранее в dart был всего один модификатор: abstract
  //; Абсолютно все классы могли наследоваться, имплементироваться и миксиниться
  //; Это было ошибкой - можно было статически прострелить себе ногу в рантайме
  //; Поэтому добавили модификаторы, которые позволяют контролировать, как класс может использоваться
  //; НО старое поведение не убрали, так что использовать модификаторы - ОБЯЗАТЕЛЬНО
}

void classModifiers() {
  //? Модификаторы класса
  //* Модификаторы класса контролируют, как класс или миксин могут использоваться, как из его собственной библиотеки, так и из внешней библиотеки, где он определен.
  //; Важно: Концептуальные принципы работы модификаторов накладывают ограничения только ВНЕ библиотеки (вне файла)
  //; Внутри файла мы будем по прежнему способны делать запрещенные вещи - например оверайдить приватные методы
  //
  //; Важно 2: модификаторы класса применяются только к class или mixin (enum, typedef, extension - нет)

  //? Список модификаторов
  //* 1. abstract
  //* 2. base
  //* 3. interface
  //* 4. final
  //* 5. sealed
  //* 6. mixin

  //? Возможности
  //* Мы не будем рассматривать модификаторы, которые открывают принципы которых мы еще не знаем (mixin, sealed)
  //* Так что рассмотрим только первые 4
  //* Исходя из первых 4 модификаторов, мы имеем следующие возможности класса:
  //* 1. Способность создать объект данного класса (Construct)
  //* 2. Способность наследовать от данного класса (Extend)
  //* 3. Способность реализовать/имплементировать данный класс (Implement)
  //
  //* Мы знаем первые две способности класса, так что перед изучением модификаторов рассмотрим что такое имплементация
}

void whatIsImplement() {
  //? Имплементация
  //* Как мы знаем, ключевое слово extends позволяет нам наследовать классы, расширять функционал и иметь ВОЗМОЖНОСТЬ
  //* переопределить/оверайдить методы и поля родительского класса.
  //* Имплементация же позволяет нам реализовать весь интерфейс, что обязывает нас реализовать (оверайдить) все методы и поля
  //* Но оверайдить конструктор не получится, он не переносится при имплементации, нужно создавать свой

  //? Синтаксис
  //* class Class implements OtherClass
}

class Person {
  Person({required this.name, required this.age});

  final String name;
  final int age;

  void greet(Person other) {
    print('Hello, ${other.name}');
  }

  void _sayAge() {
    print('I am $age years old');
  }
}

//* Наследование - мы даже не переопределяем greet и поля
class Student extends Person {
  Student({
    required super.name,
    required super.age,
    required this.university,
  });

  final String university;

  void study() {
    print('I am studying at $university');
  }
}

//* Имплементация - мы обязаны переопределить ВСЁ что есть в Person (и создали новый конструктор)
class Teacher implements Person {
  Teacher({required this.name, required this.age, required this.subject});

  @override
  final String name;

  @override
  final int age;

  final String subject;

  @override
  void greet(Person other) {
    print('Shut up ${other.name}');
  }

  //* Даже приватные методы
  //* Но посмотрите в файл 12.abstraction_outside.dart
  @override
  void _sayAge() => print('I AM $age Y.O ESKETIIT');
}

void classModifiers2() {
  //* Теперь мы знаем про возможность имплементации и можем рассмотреть модификаторы класса.

  //? Модификаторы класса
  //* 1. Никаких (просто class) - способен на все 3 возможности (Construct, Extend, Implement)
  //* 2. abstract - Extend и Implement
  //* 3. base - Construct и Extend
  //* 4. interface - Construct и Implement
  //* 5. final - только Construct

  //* Помимо разной поддержки возможностей класса, у каждого модификатора есть своя особенность
  //* Начнем рассматривать конкретно каждый модификатор, начиная с abstract
}

void abstract$() {
  //? abstract
  //* Модификатор abstract позволяет создать абстрактный класс
  //* Абстрактный класс - это класс, который не может быть создан напрямую(?), но может быть унаследован другими классами
  //* Абстрактный класс МОЖЕТ содержать абстрактные методы и поля (без тела и значений),
  //* которые ДОЛЖНЫ быть реализованы в классах-наследниках
  //* Абстрактный класс МОЖЕТ содержать конструктор, но не может быть им создан

  //; напрямую(?) - на самом деле это возможно на половину с помощью ссылочных фабричных конструкторов

  //? Синтаксис
  //* abstract class ClassName {}

  //? Синтаксис абстрактного метода
  //* Type methodName(); // Без тела

  //? Синтаксис абстрактного поля
  //* abstract Type fieldName; // Без значения и инициализации в конструкторе

  //? Пример
  //* 1. Нельзя создать объект абстрактного класса
  // final fightable = Fightable(); //! Abstract classes can't be instantiated.

  //* 2. Но можно создать класс-наследник
  final fightable = FightableDamage(2, 6, 10);

  //* 3. Нельзя создать объект абстрактного класса даже если он имеет конструктор
  // final fightableNoDice = FightableNoDice(10); //! Abstract classes can't be instantiated.

  //* 4. Можно создать класс-наследник, наследующий абстрактный класс с конструктором
  final fightableNoDice = FightableDamageNoDice(10);

  //; Помним что abstract class может выступать и в роли интерфейса

  //; Как же все таки сделать "напрямую(?)"
  //* Ссылочные фабричные конструкторы позволяют перенаправить вызов конструктора на другой конструктор
  //* (даже другого типа, но с условием наследования/реализации интерфейса)
  //? Пример

  final myMap = MyMap(); // На самом деле создали объект класса LinkedHashMyMap
  print(myMap is LinkedHashMyMap); // true

  // Аналогичная запись
  final MyMap myMap2 = LinkedHashMyMap();
}

//* Абстрактный класс
abstract class Fightable {
  int get damageRoll;
  int get healthPoints;

  abstract final int diceCount;
  abstract final int diceSides;

  //* Единственный не абстрактный метод
  int attack(Fightable opponent) {
    final damageDealt = damageRoll;
    opponent.getDamage(damageDealt);
    return damageDealt;
  }

  void getDamage(int damage);
}

//* Реализация абстрактного класса
class FightableDamage extends Fightable {
  FightableDamage(
    this.diceCount,
    this.diceSides,
    int healthPoints,
  ) : _healthPoints = healthPoints;

  static final _random = Random.secure();

  int _healthPoints;

  @override
  int get healthPoints => _healthPoints;

  @override
  int get damageRoll => _random.nextInt((diceSides - 1) * diceCount + 1) + diceCount;

  @override
  final int diceCount;

  @override
  final int diceSides;

  @override
  void getDamage(int damage) {
    _healthPoints -= damage;
  }
}

//* Абстрактный класс наследуется от абстрактного класса
abstract class FightableNoDice extends Fightable {
  FightableNoDice(int healthPoints) : _healthPoints = healthPoints;

  int _healthPoints;

  @override
  int get healthPoints => _healthPoints;

  //; Не переопределяем, так как не используем damageRoll - ошибки нету

  @override
  final int diceCount = 1;

  @override
  final int diceSides = 1;

  @override
  void getDamage(int damage) {
    _healthPoints -= damage;
  }
}

//* Наследуемся от абстрактного класса, который не имеет абстрактных методов (кроме damageRoll)
class FightableDamageNoDice extends FightableNoDice {
  //* Можем использовать конструктор абстрактного класса
  FightableDamageNoDice(super.healthPoints);

  @override
  int get damageRoll => 1;
}

//* Пример "создания" абстрактного класса
abstract class MyMap {
  //* Перенаправляющие фабричные конструкторы
  factory MyMap() = LinkedHashMyMap;
  factory MyMap.tree(int value) = TreeHashedMyMap;

  abstract final int veryImportantValue;
  void addValue(int value);
}

//* Имплементация абстрактного класса (Чтобы не переносить фабричный конструктор)
class LinkedHashMyMap implements MyMap {
  @override
  void addValue(int value) {
    print('Added $value in $runtimeType');
  }

  //* Переопределили veryImportantValue как геттер, а не как поле - ошибки нету
  @override
  int get veryImportantValue => 42;
}

class TreeHashedMyMap implements MyMap {
  TreeHashedMyMap(this.veryImportantValue);

  @override
  void addValue(int value) {
    print('Added $value in $runtimeType');
  }

  @override
  final int veryImportantValue;
}

void base$() {
  //? base
  //* Для обеспечения наследования реализации класса или миксина используйте модификатор base.
  //* Базовый класс запрещает реализацию за пределами собственной библиотеки (запрещает implements). Это гарантирует:
  //* 1. Конструктор базового класса вызывается каждый раз, когда создается экземпляр подтипа класса.
  //* 2. Все реализованные закрытые члены существуют в подтипах.
  //* 3. Новый реализованный член в базовом классе не нарушает подтипы, поскольку все подтипы наследуют новый член.
  //* -  Это верно, если подтип уже объявляет член с тем же именем и несовместной сигнатурой.
  //* Вы должны пометить любой класс, который реализует или расширяет базовый (base) класс, как base, final или sealed.
  //* Это предотвращает нарушение базовых гарантий класса внешними библиотеками.

  //? Кратко
  //* С помощью base можно создать "истинные/чистые" абстрактные классы и обычные классы
  //* Ранее мы имплементировали для примера абстрактный класс (для демонстрации перенаправляющего фабричного конструктора)
  //! ЭТО ЯВЛЯЕТСЯ ОШИБКОЙ! - Нарушается транзитивность классов
  //* Абстрактный класс и обычный класс должны иметь возможность ТОЛЬКО наследоваться, но не имплементироваться
  //* Для этого и нужен модификатор base

  //; Опять же помним, что в пределах файла мы можем делать все что угодно

  //? Выводы
  //* Теперь мы можем создавать "чистые" абстрактные классы и обычные классы, вот комбинации:
  //* base class - чистый класс готовый к наследованию
  //* base abstract class - чистый абстрактный класс
  //! Теперь используем только так
}

//* Истинный абстрактный класс - не может инициализироваться, не может имплементироваться
//* Только наследоваться
abstract base class User {
  User(this.name);

  final String name;

  void greet(User other);
}

//* Истинный обычный класс - может инициализироваться, не может имплементироваться
base class Admin extends User {
  Admin(super.name);

  @override
  void greet(User other) {
    print('Hello, ${other.name}');
  }

  void ban(User user) {
    print('Banned ${user.name}');
  }
}

//* Пример как нарушить транзитивность классов
//* НО в файле 12.abstraction_outside.dart мы уже не можем нарушить транзитивность
base class HeadRecruiter implements User {
  //* Нарушение транзитивности - HeadRecruiter не должен имплементировать User
  //* Супер конструктора больше нет
  // HeadRecruiter(String name) : super(name);

  @override
  String get name => 'Josh';

  @override
  void greet(User other) {
    print('Hello, ${other.name}');
  }

  void recruit(User user) {
    print('Recruited ${user.name}');
  }
}

void interface$() {
  //? interface
  //* Чтобы определить интерфейс, используйте модификатор interface.
  //* Библиотеки за пределами собственной библиотеки интерфейса могут реализовать интерфейс, но не расширять/наследовать его.
  //* Это гарантирует:
  //* 1. Когда один из методов экземпляра класса вызывает другой метод экземпляра в этом,
  //* - он всегда вызовет известную реализацию метода из той же библиотеки.
  //* 2. Другие библиотеки не могут переопределить методы, которые собственные методы класса интерфейса позже могут вызывать
  //* - в неожиданных способах. Это уменьшает проблему хрупкого базового класса.

  //? Кратко
  //* С помощью interface можно создать "чистые" интерфейсы
  //* Интерфейс имеет два значения:
  //* 1. Интерфейс - это контракт, который гарантирует, что класс реализует все члены интерфейса.
  //* 2. Интерфейс - это публичный API, который скрывает детали реализации класса.
  //* Ранее мы использовали второе определение.
  //
  //* Для создания "чистого интерфейса" использование записи interface class - является ошибкой
  //* Так как ключевое слово interface запрещает наследование, НО не запрещает создание объекта, то мы опять нарушаем транзитивность
  //* Для чистого интерфейса используем abstract interface class
  //* 1. abstract - для того чтобы не создавать объект + иметь абстрактные члены
  //* 2. interface - для того чтобы не наследовать

  //; Опять же помним, что в пределах файла мы можем делать все что угодно

  //? В чем разница между интерфейсом и абстрактным классом, и когда каждый использовать?
  //* Данный вопрос мучает многих начинающих, разберемся по порядку
  //* Сходства:
  //* 1. Оба могут иметь абстрактные методы и поля
  //* 2. Оба заставляют реализовать абстрактные методы и поля
  //* Различия:
  //* 1. Абстрактный класс МОЖЕТ иметь реализованные методы и поля, интерфейс - нет
  //* 2. Абстрактный класс МОЖЕТ иметь конструктор, интерфейс - нет
  //* 3. Любой класс может наследовать только 1 абстрактный класс, но реализовать множество интерфейсов
  //
  //* Таким образом, если у вас есть общая реализация, которая будет применима к наследникам, используйте абстрактный класс.
  //* Если у вас есть только контракт, который должен быть реализован, используйте интерфейс.
  //* Обычно интерфейс используют только для методов

  //; Есть неофициальное правило, как использовать интерфейс и абстрактный класс
  //; 1. Пишем "контракт" - интерфейс только с методами и возможно геттерами
  //; 2. Если имплементаторы будут использовать схожие/дублирующие методы/поведение то делаем абстрактный класс (имплементируя интерфейс)
  //; 3. Создаем реализацию абстрактного класса
  //; 4. Для полиморфного поведения приводим реализации к интерфейсу

  // Примеры

  // (Интерфейс - супер общие методы)  https://github.com/hawkkiller/sizzle_starter/blob/main/lib/src/core/rest_client/src/rest_client.dart
  // (Абстрактный класс - общие методы с реализацией) https://github.com/hawkkiller/sizzle_starter/blob/main/lib/src/core/rest_client/src/rest_client_base.dart
  // (Реализация (http, dio)) https://github.com/hawkkiller/sizzle_starter/blob/main/lib/src/core/rest_client/src/http/rest_client_http.dart

  // (Интерфейс) https://gist.github.com/cocahonka/50b1a12f359710a054fb7612f281f5ce
  // (Реализация) https://gist.github.com/cocahonka/e52d48a0ed621153104953240edde19f

  // (Абстрактный класс -> Абстрактный класс -> 2 Реализации) https://gist.github.com/cocahonka/672986b5263bf246a9c036d4856bb2a3
  // Для апкаста используется ProcessHandler
}

typedef Token = ({String accessToken, String refreshToken});

//* Чистый интерфейс
abstract interface class TokenStorage {
  Token? load();
  void save(Token token);
  void clear();
}

//* Реализация интерфейса
base class MapTokenStorage implements TokenStorage {
  final _storage = <String, String>{};

  @override
  Token? load() {
    final accessToken = _storage['accessToken'];
    final refreshToken = _storage['refreshToken'];

    if (accessToken == null || refreshToken == null) return null;

    return (accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  void save(Token token) {
    _storage['accessToken'] = token.accessToken;
    _storage['refreshToken'] = token.refreshToken;
  }

  @override
  void clear() {
    _storage.clear();
  }
}

void final$() {
  //? final
  //* Чтобы закрыть иерархию типов, используйте модификатор final.
  //* Это предотвращает подтипизацию от класса за пределами текущей библиотеки.
  //* Запрет как наследования, так и реализации предотвращает подтипизацию вообще. Это гарантирует:
  //* 1. Вы можете безопасно добавлять пошаговые изменения в API.
  //* 2. Вы можете вызывать методы экземпляра, зная, что они не были перезаписаны в подклассе сторонней стороны.
  //* Финальные классы могут быть расширены или реализованы в пределах одной и той же библиотеки.
  //* Модификатор final охватывает эффекты base, и поэтому любые подклассы также должны быть помечены как base, final или sealed.

  //? Кратко
  //* Используем final для конечных классов (реализаций), которые не должны наследоваться или имплементироваться

  // Для примеров см. ссылки interface$()
}

void privateAbstraction() {
  //? Приватные абстрактные методы и поля
  //* Когда будете проектировать классы и интерфейсы будьте ОЧЕНЬ осторожны с приватными АБСТРАКТНЫМИ методами и полями

  //? Почему?
  //* Потому что они не могут быть переопределены в классах-наследниках
  //* Для интерфейсов - это не так критично, так как интерфейсы не имеют реализации
  //* Но для абстрактных классов это критично.
  //* Если публичный метод/поле будет опираться на приватный абстрактный метод/поле,
  //* то класс-наследник ВНЕ библиотеки не сможет его переопределить.
  //* Тогда если публичный метод/поле не будет переопределено или будет вызывать супер реализацию, мы получим ошибку
  //! РАНТАЙМА

  final privateAbstractionError = PrivateAbstractionErrorImpl();
  privateAbstractionError.publicMethod(); //* Всё ОК!

  //? Как избежать такой ошибки?
  //* 1. Используйте интерфейсы, тогда реализации ВНЕ библиотеки просто не будут содержать приватные методы/поля,
  //* - а реализации внутри библиотеки будут обязаны реализовать ВСЕ методы/поля
  //* 2. Сделайте абстрактный класс приватным, тогда проблем с внешними реализациями не будет
  //* 3. Сделайте абстрактный класс final, тогда проблем с внешними реализациями не будет

  final privateAbstractionErrorFixed = PrivateAbstractionErrorImplFixed();
  privateAbstractionErrorFixed.publicMethod(); //* Всё ОК!
}

abstract base class PrivateAbstractionError {
  void publicMethod() {
    print('Public work');
    _privateMethod();
  }

  void _privateMethod();
}

final class PrivateAbstractionErrorImpl extends PrivateAbstractionError {
  //* Пока мы в библиотеке, все работает, так как нас заставляют переопределить _privateMethod
  //* Но см. файл 12.abstraction_outside.dart
  @override
  void _privateMethod() {
    print('Private work');
  }
}

//? Пример фикса
abstract final class PrivateAbstractionErrorFixed {
  void publicMethod() {
    print('Public work');
    _privateMethod();
  }

  void _privateMethod();
}

final class PrivateAbstractionErrorImplFixed extends PrivateAbstractionErrorFixed {
  @override
  void _privateMethod() {
    print('Private work');
  }
}

void conclusion() {
  //? Выводы и повтор

  //; Абстракция - это процесс выделения общих характеристик и функциональности объектов или системы, игнорируя детали реализации.

  //? Возможности модификаторов класса:
  //* 1. Инициализация
  //* 2. Наследование
  //* 3. Имплементация

  //? "Чистые" комбинации
  //* 1. abstract base class - чистый абстрактный класс
  //* - Не может быть создан и имплементирован, но может быть унаследован.
  //* - МОЖЕТ содержать конструктор, абстрактные методы и поля

  //* 2. abstract interface class - чистый интерфейс
  //* - Не может быть создан и унаследован, но может быть имплементирован.
  //* - Содержит ТОЛЬКО абстрактные методы и поля

  //* 3. base class - базовый класс
  //* - Может быть создан, унаследован, но не имплементирован.

  //* 4. final class - конечный класс
  //* - Не может быть унаследован и имплементирован, но может быть создан.

  //* 5. abstract final class - неймпспейс(?) или решение проблемы с приватными абстрактными методами и полями

  //? Когда интерфейс, когда абстрактный класс?
  //* 1. Интерфейс - контракт, который гарантирует, что класс реализует все члены интерфейса.
  //* 2. Абстрактный класс - общая реализация, которая будет применима к наследникам.
  //; Абстрактный класс как правило более подвержен изменениям, чем интерфейс
  //; Поэтому лучше начинать проектировать именно с интерфейсов

  //? Namespace(?)
  //* С помощью модификаторов можно создавать "неймпспейсы" (abstract final class)
  //* Так как их нельзя наследовать, имплементировать и создавать, они могут быть использованы как пространства имен
  //* Соответственно, они могут содержать только статические методы и поля (иначе бесполезны для неймпспейса)
  print(Constants.appAuthor);
}

abstract final class Constants {
  static const String appName = 'MyApp';
  static const String appVersion = '1.0.0';
  static const String appAuthor = 'cocahonka';
  static const int favNumber = 42;
}

//; P.S.S Бонус с Comparable

void main() {
  abstract$();
  base$();
  interface$();
  final$();
  privateAbstraction();
}

// Домашнее задание

//? 1. Линейная структура данных
//* Реализовать архитектуру для линейного хранения данных типа Object
//* Конечные реализации должны быть Stack и Queue (очередь и стек)
//* Обе структуры должны базироваться и работать на листах (List)
//* Методы, поля - все за вами (стэк уже был вами реализован, можете взять в пример)
//* Попытайтесь сделать API (взаимодействие) максимально удобным и понятным

//? 2. Погода
//* Реализовать архитектуру для работы с погодой с помощью паттерна "Репозиторий"
//* Репозиторий - паттерн проектирования, который используется для абстрагирования слоя доступа к данным.
//* Он позволяет отделить логику получения данных от бизнес-логики, упрощая поддержку и тестирование кода.
//
//* Репозиторий должен предоставлять интерфейс для добавления, получения и удаления данных о погоде.
//* Данные о погоде включают дату DateTime, температуру и описание (например, "солнечно", "дождливо").
//* У репозитория должны быть различные реализации (например работа через файл или в оперативной памяти)
//* Продемонстрировать работу репозитория с помощью консольного ввода (stdin)
//* Также продемонстрировать работу с различными реализациями репозитория и с их переключением в процессе работы
//; После того как основная работа будет закончена, сделайте метод для синхронизации репозиториев между собой

//? 3. Платежная система
//* Реализовать архитектуру для платежной системы
//* Часть 1.
//* Нужно реализовать архитектуру для хранения позиций заказа (товаров)
//* Каждая позиция должна содержать название, цену и количество
//* Обертка, которая содержит и работает со всеми позициями должна иметь методы:
//* add - добавить позицию
//* remove - удалить позицию по значению
//* clear - очистить все позиции
//* total - вернуть общую стоимость всех позиций
//* freeze - заморозить позиции, чтобы нельзя было их изменить (новый объект обертки)
//* Должны быть различные реализации обертки (например через стэк и очередь или другие)
//
//* Часть 2.
//* Реализовать архитектуру для карты (кошелька)
//* Кошелек должен иметь методы:
//* add - добавить деньги
//* remove - снять деньги
//* balance - вернуть текущий баланс
//* Различные кошельки должны иметь различные бонусы (например, кэшбэк)
//
//* Часть 3.
//* Реализовать архитектуру для обработки платежей
//* Любая платежная система (Сбер, Киви и т.д.) должна иметь зависимость: кошелек пользователя
//* но кошелек можно менять в процессе работы платежной системы.
//* У платежной системы должно быть следующее API:
//* processPayment - оплатить заказ (Принимает обертку позиций),
//* возвращает уникальный номер оплаченного заказа, если оплата прошла успешно
//* Если нет выбрасывается исключение (NotEnoughMoneyException) с описанием ошибки
//* refundPayment - вернуть деньги за заказ (Принимает уникальный номер заказа)
//* Возвращает true, если деньги успешно вернулись, иначе false
//
//* Детально продемонстрировать работу (как менять в процессе различные реализации, как обрабатываются ошибки и т.д.)
//* Сделать ввод на основе консоли (stdin)
//
//* Пример кастомных ошибок
/*
base class PaymentException implements Exception {
  const PaymentException(this.message);

  final String message;

  @override
  String toString() => 'PaymentException: $message';
}

final class NotEnoughMoneyException extends PaymentException {
  const NotEnoughMoneyException() : super('Not enough money');
}

*/