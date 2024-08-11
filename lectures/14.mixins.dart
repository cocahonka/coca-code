// ignore_for_file: cascade_invocations, one_member_abstracts, use_setters_to_change_properties

void mixins() {
  //? Миксины
  //* В лекции 11 мы узнали что Dart использует Mixin Based Inheritance (Наследование на основе миксинов).
  //* Так как множественное наследование не поддерживается в Dart,
  //* миксины предоставляют способ добавить поведение к классу без наследования.

  //? Добавление поведения к классу
  //* Что значит "Добавление поведения к классу"?
  //* Вероятно у нас есть "общий" функционал который мы хотим использовать в разных классах.
  //* Пример: у нас есть классы Stack и Queue, у них очень много пересекающегося кода,
  //* поэтому мы вводим абстрактный класс LinearStructure, который содержит общий функционал для Stack и Queue.
  //* Соответственно мы добавили поведение к классу, но какие способы есть для этого?

  //? Наследование?
  //* Мы можем использовать наследование, как было рассмотрено на примере Stack и Queue.
  //* Но наследование имеет свои недостатки, например, оно может привести к проблемам с иерархией классов.
  //* Например что если мы введем новый класс Heap, который имеет мало общего с Stack и Queue, но все равно наследует LinearStructure?
  //* Что если мы захотим сделать фигуры и цвета? Как мы будем наследовать?
  //* Получиться что то вроде: Shape, ShapeCircle, ShapeSquare, Color, BlueColor, RedColor, RedCircle, BlueSquare, RedSquare, BlueCircle...
  //* Количество комбинаций будет расти в геометрической прогрессии.
  //; Вывод - наследование создает хрупкие классы и сложные иерархии.

  //? Интерфейсы?
  //* Да, мы можем имплементировать несколько интерфейсов, но при имплементации нам нужно реализовать все методы,
  //* То есть, повторяемся опять - интерфейсы - это контракт, который класс должен выполнить.
  //* Интерфейс не может содержать реализацию, а значит не может добавить поведение к классу.
  //; Вывод - интерфейсы не могут добавить поведение к классу.

  //? Композиция/Агрегация?
  //* Выделяя повторяющиеся поведение или отдельную иерархию в отдельный класс, мы можем использовать композицию/агрегацию.
  //* В наш класс мы просто добавим поле с объектом другого класса, поведение которого нам нужно.
  //* Но это не всегда удобно, особенно если общее поведение нужно использовать в огромной иерархии классов,
  //* В таком случае мы будем делать Boilerplate код, который будет делать тоже самое в каждом классе.
  //; Вывод - композиция/агрегация лучше наследования, тем более в современном мире трактуется следующая мысль:
  //; "composition over inheritance" - композиция вместо наследования.

  //? Расширения?
  //* Расширения позволяют добавлять методы к существующим классам, а соответственно и поведение.
  //* Но расширения не могут хранить поля, и не могут быть использованы внутри класса.
  //* То есть, расширения могут добавить поведение к классу, но очень ограничены.
  //; Вывод - расширения позволяют добавлять новое поведение к классу, но только в виде внешних методов.

  //? Миксины
  //* Миксины - это способ определения кода, который можно использовать в нескольких иерархиях классов.
  //* Они предназначены для предоставления реализаций членов массово.
  //* Чистые миксины не могут быть инстанциированы, и не могут быть использованы самостоятельно.
  //* Миксины "миксятся" с другими классами, добавляя свои методы и свойства к классу.
  //* Миксины могут быть использованы вместе с наследованием и интерфейсами, причем к одному классу можно применить несколько миксинов.
  //; Вывод - миксины являются самым удобным способом добавления поведения к класс(у/ам).
}

void mixins2() {
  //? Синтаксис
  //* Ключевое слово mixin является еще одним модификатором класса,
  //* поэтому мы можем сделать mixin class, base mixin class и т.д.
  //* Но mixin, в отличии от всех других модификаторов может применяться без ключевого слова class.
  //* Чтобы создать чистый миксин, мы должны использовать сочетание - base mixin
  //* (потому что просто mixin способен быть интерфейсом)
  //
  //* Миксины могут имплементировать интерфейсы и могут иметь абстрактные члены,
  //* но не имеют конструкторов и не могут наследовать другие классы.
  //* Так что пока что наш синтаксис для создания миксинов следующий:
  //* base mixin MixinName
  //* или
  //* base mixin MixinName implements InterfaceName
  //
  //* Для того чтобы использовать миксин, мы должны использовать ключевое слово with.
  //* class ClassName with MixinName

  // Пример
  final maestro = Maestro();
  maestro.entertainMe();

  final impostor = Impostor('John');
  impostor.entertainMe();

  //* В таком исполнении не разгуляешься, нам нужно больше абстракции...
}

base mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

final class Maestro with Musical {
  Maestro() {
    canConduct = true;
  }
}

abstract base class Person {
  String get name;

  void greet(Person other) {
    print('Hello, $other, I am $name');
  }
}

final class Impostor extends Person with Musical {
  Impostor(this._name);

  final String _name;

  @override
  String get name => 'Impostor $_name';
}

void mixins3() {
  //? Абстракция
  //* Иногда миксин зависит от возможности вызвать метод или получить доступ к полям, но не может определить эти члены самостоятельно
  //* (потому что миксины не могут использовать параметры конструктора для создания собственных полей).
  //* Следующие разделы лекции описывают различные стратегии для обеспечения того, чтобы любой подкласс миксина определял любые члены,
  //* от которых зависит поведение миксина.

  //? 1. Абстрактные члены
  //* Объявление абстрактного метода/поля в миксине заставляет любой тип, использующий миксин,
  //* определить абстрактный метод/поле, от которого зависит его поведение.

  // Пример
  final virtuoso = Virtuoso();
  virtuoso.playPiano();
  virtuoso.playInstrument('KoKoDoDoDou');

  final student = Student('John');
  print(student.name);
  final anotherStudent = Student('John');
  print(student == anotherStudent);
}

base mixin Musician {
  void playInstrument(String instrumentName); // Абстрактный метод

  void playPiano() {
    playInstrument('Piano');
  }

  void playFlute() {
    playInstrument('Flute');
  }
}

final class Virtuoso with Musician {
  //* Обязаны реализовать
  @override
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName beautifully');
  }
}

base mixin NameIdentity {
  String get name;

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) => other is NameIdentity && name == other.name;
}

final class Student with NameIdentity {
  Student(this.name);

  @override
  final String name;
}

void mixins4() {
  //? 2. Имплементация интерфейса
  //* Подобно объявлению миксина абстрактным, добавление к миксину implements, не реализуя интерфейс,
  //* также гарантирует, что любые зависимости от членов определены для миксина.

  // Пример
  final punkRocker = PunkRocker();
  punkRocker.playSong();
}

abstract interface class Tuner {
  void tuneInstrument();
}

base mixin Guitarist implements Tuner {
  void playSong() {
    tuneInstrument(); //* Не реализуем этот метод в миксине
    print('Strums guitar majestically.');
  }
}

final class PunkRocker with Guitarist {
  //* Обязаны реализовать
  @override
  void tuneInstrument() {
    print("Don't bother, being out of tune is punk rock.");
  }
}

void mixins5() {
  //? 3. Объявление суперкласса для миксина
  //* Ключевое слово on существует для определения типа, к которому применяются вызовы super.
  //* Поэтому его следует использовать только в том случае, если вам нужен вызов super внутри миксина.
  //* Ключевое слово on заставляет любой класс, использующий миксин, также быть подклассом типа в ключевом слове on.
  //* Если миксин зависит от членов в суперклассе, это гарантирует, что эти члены доступны там, где используется миксин

  // Пример
  SingerDancer().performerMethod();
  FileLogger().duplicate();
}

base class SoundArtist {
  void musicianMethod() {
    print('Playing music!');
  }
}

base mixin MusicalPerformer on SoundArtist {
  void performerMethod() {
    print('Performing music!');
    super.musicianMethod(); //* Мы можем использовать super и брать реализую из суперкласса
  }
}

final class SingerDancer extends SoundArtist with MusicalPerformer {}

base class Logger {
  void log() {
    print('log');
  }
}

base mixin DuplicateLogger on Logger {
  void duplicate() {
    print('duplicate');
    //* Можно не использовать super если имена не пересекаются (duplicate и log в данном случае)
    //* Но не забывайте про рекурсию..
    log();
    log();
  }
}

final class FileLogger extends Logger with DuplicateLogger {
  @override
  void log() {
    print('kok');
  }
}

void mixins6() {
  //? Когда использовать?

  //? Добавление поведения к классу
  //* Миксины можно использовать вместо композиции и агрегации, когда поведение должно быть доступно в нескольких классах.
  //* В таком случае композитное поле как бы "развернётся" внутри самого класса, НО это не значит что миксины заменяют композицию.
  //* При помощи композиции мы можем воспользоваться полиморфизмом подтипов, а через миксины нет.

  // Пример с миксином
  final counter = Counter();
  counter.addListener(() => print('Listener 1: ${counter.count}'));
  counter.addListener(() => print('Listener 2: ${counter.count}'));
  counter.increment();

  // Пример с композицией
  final counter2 = Counter2();
  counter2.changeNotifier.addListener(() => print('Listener 1: ${counter2.count}'));
  counter2.changeNotifier.addListener(() => print('Listener 2: ${counter2.count}'));
}

//* Здесь композиция лучше смотрится, так как наша цель использовать полиморфизм подтипов
final class Navigator {
  Navigator(this.route);

  RouteStrategy route; //* Композитное поле

  void navigate() {
    route.navigate();
  }
}

abstract interface class RouteStrategy {
  void navigate();
}

final class BusStrategy implements RouteStrategy {
  @override
  void navigate() {
    print('Bus strategy');
  }
}

final class CarStrategy implements RouteStrategy {
  @override
  void navigate() {
    print('Car strategy');
  }
}

//* А здесь уже лучше использовать миксины, так как мы хотим добавить поведение к классу
typedef VoidCallback = void Function();

abstract interface class Listenable {
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
}

base mixin ChangeNotifier implements Listenable {
  final List<VoidCallback> _listeners = [];

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }
}

final class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

//; Сравните с использованием композиции
final class ChangeNotifier2 implements Listenable {
  final List<VoidCallback> _listeners = [];

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }
}

final class Counter2 {
  final ChangeNotifier2 changeNotifier = ChangeNotifier2();
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    changeNotifier.notifyListeners();
  }

  //* Можно добавить методы для удобства, но это лишний boilerplate
  // void addListener(VoidCallback listener) {
  //   _changeNotifier.addListener(listener);
  // }

  // void removeListener(VoidCallback listener) {
  //   _changeNotifier.removeListener(listener);
  // }
}

void conclusion() {
  //? Выводы

  //? Архитектурные соображения
  //* 1. Изолированные расширения функциональности базовых классов
  //* 2. Ограничение применения, расширение на основе суперкласса

  //* Вообще стоит рассматривать отношения наследования, если определенная характеристика является существенной,
  //* Тогда стоит определить отдельную сущность, а если какая то характеристика является не существенной, тогда
  //* можно использовать миксины.
  //* Пример: Прямоугольник и Круг - их существенная характеристика - это фигура, а не существенная - цвет.
  //* А значит цвет можно сделать миксином.

  //* Также можно ориентироваться на многообразие вашей иерархии классов.
  //* Допустим есть виджеты: кнопка, текстовое поле, чекбокс, радио-кнопка, и т.д.
  //* каждый виджет можно сделать анимированным - это поведение, которое можно вынести в миксин.
  //* final class MyAwesomeButton extends Button with AnimatedMixin {}

  //; Equatable - тоже должен быть миксином, а не абстрактным классом

  //; Миксины помогают достичь DRY (Don't Repeat Yourself) принципа.

  //; Примеры применения миксинов: Логирование, Кеширование, Валидация, Анимация

  //? Как воспринимать миксины?
  //* Миксины - интерфейс с реализацией, но не абстрактный класс.

  // https://github.com/felangel/stream_listener/blob/master/packages/stream_listener/lib/src/stream_listener_mixin.dart#L5
  // https://github.com/felangel/mason/blob/master/packages/mason_cli/lib/src/install_brick.dart
  // https://github.com/felangel/fresh/blob/2a17d1bdb92d545e454643150d67c29b4a8b9756/packages/fresh/lib/src/fresh.dart#L88
  // https://github.com/felangel/bloc/blob/master/packages/hydrated_bloc/lib/src/hydrated_bloc.dart#L106
  // https://github.com/purplenoodlesoop/purple-starter/blob/e19e2eae45e96928d16678d9bae4730c77525656/lib/src/core/logic/identity_logging_mixin.dart#L4
}

void main() {
  final labels = {
    'Mixins': mixins,
    'Mixins 2': mixins2,
    'Mixins 3': mixins3,
    'Mixins 4': mixins4,
    'Mixins 5': mixins5,
    'Mixins 6': mixins6,
  };

  final divider = '=' * 20;

  for (final MapEntry(key: title, value: action) in labels.entries) {
    print('$divider $title $divider');
    action();
    print('\n');
  }
}
