// ignore_for_file: unused_local_variable, cascade_invocations, unnecessary_statements, unused_field, use_late_for_private_fields_and_variables, one_member_abstracts, prefer_final_locals, avoid_equals_and_hash_code_on_mutable_classes, avoid_positional_boolean_parameters

void generics() {
  //? Generics (Обобщения)
  //* Параметрический полиморфизм (Дженерики) - еще один вид полиморфизма и еще один способ абстракции.
  //* Дженерики способствуют расширению области повторного использования определений классов,
  //* потому что позволяют вашим определениям работать со многими типами.
  //* В отличии от Object или dynamic, дженерики не меняют типы во время выполнения программы
  //* и во время выполнения имеют КОНКРЕТНЫЙ тип.

  //; Дженерики - способность использовать один интерфейс и реализацию для многих типов

  //? Преимущества
  //* 1. Безопасность типов
  //* 2. Повторное использование кода

  //? Разбор преимуществ
  //* 1. Безопасность типов
  final list = [1, 2, 3];
  // list.add('4'); //! Error: The argument type 'String' can't be assigned to the parameter type 'int'.

  //* 2. Повторное использование кода
  //* См. примеры ниже (ObjectCache)
  //* Ранее для расширений (extensions) чтобы использовать не только один конкретный тип, но и множество типов
  //* приходилось использовать Object, что приводило к необходимости приведения типов и потенциальным ошибкам во время выполнения
  //* Если не использовать Object тогда пришлось бы писать несколько одинарных реализаций для каждого типа
  //* Например ObjectCache, StringCache, IntCache, sum для int и double и т.д.
  //* Дженерики решают проблему как дублирования кода, так и безопасности типов (не нужно приведение типов и использование Object)
}

abstract interface class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}

abstract interface class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}

abstract interface class IntCache {
  int getByKey(String key);
  void setByKey(String key, int value);
}

void generics2() {
  //? Область использования
  //* 1. Функции
  //* 2. Классы (включая enum, mixin, typedef и т.д.)

  //? Синтаксис
  //* <T> - где T - это тип, который будет использоваться внутри класса или функции
  //* Использовать можно любую букву или даже слова, но принято использовать заглавные буквы, например:
  //* T - (Тип)
  //* E - (Элемент)
  //* K - (Ключ)
  //* V - (Значение)
  //* S - (Состояние)
  //* R - (Результат)
  //* I - (Входной)
  //* O - (Выходной)
  //* И др.
  //* Чтобы можно было использовать несколько типов, нужно использовать запятую, например:
  //* <K, V> (см. Map)
  //* Приписывать эту конструкцию нужно справа от имени класса или функции, например:
  //* class Cache<T> {}
  //* void execute<T>(T value) {}
  //* При использовании нужно ставить алмазные скобки (если это необходимо)

  //? Пример (Cache)
  final intMapCache = MapCache<int>();
  intMapCache.setByKey('key', 1);
  // intMapCache.setByKey('key', 'string'); //! Error: The argument type 'String' can't be assigned to the parameter type 'int'.

  final stringMapCache = MapCache<String>();
  stringMapCache.setByKey('key', 'string');
  // stringMapCache.setByKey('key', 1); //! Error: The argument type 'int' can't be assigned to the parameter type 'String'.

  // ignore: inference_failure_on_instance_creation
  final objectMapCache = MapCache(); //! Ошибка новичка (не указан тип) = MapCache<dynamic>
  //* Если и нужен общий тип, то используйте Object или Object?
  final realObjectMapCache = MapCache<Object>();
  realObjectMapCache.setByKey('key', 1);
  realObjectMapCache.setByKey('key2', 'string');

  //? Пример c функцией
  final twoInts = returnTwo<int>(1);
  final twoBools = returnTwo(true); //; Можно и не ставить тип, так как Dart сам поймет
  final twoStrings = returnTwo('string');

  final list = ['some', 'list', 'of', 'strings'];
  forEachIndexed(list, (index, element) {
    print('$index: $element');
  });

  //? Пример с расширениями
  final list2 = ['some', 'list', 'of', 'strings'];
  list2.forEachIndexed((index, element) {
    print('$index: $element');
  });

  final list3 = [1, 2, 3];
  final list4 = [5, 6, 7, 8];
  final zippedList34 = list3.zip(list4);
  print(zippedList34);

  zippedList34.printAll();

  final list5 = [1, 2, 3];
  final list6 = list5.mapIndexed((i, e) => '$i: $e');

  final list7 = ['some', 'list', 'of', 'strings'];
  final list8 = list7.mapIndexed((i, e) => '$i: $e');

  //? Посмотрим код dart
  //* 1. List
  //* 2. Map
  //* 3. fold
  //* 4. reduce
  List;
  Map;
  <void>[].fold;
  <void>[].reduce;
}

abstract interface class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}

final class MapCache<T> implements Cache<T> {
  final _cache = <String, T>{};

  @override
  T getByKey(String key) => _cache[key]!;

  @override
  void setByKey(String key, T value) => _cache[key] = value;
}

(T first, T second) returnTwo<T>(T value) => (value, value);

void forEachIndexed<T>(List<T> list, void Function(int index, T element) action) {
  for (var i = 0; i < list.length; i++) {
    action(i, list[i]);
  }
}

extension ListExtensions<T> on List<T> {
  void forEachIndexed(void Function(int index, T element) action) {
    for (var i = 0; i < length; i++) {
      action(i, this[i]);
    }
  }

  //* Старая версия (вспоминаем проблему cast)
  // List<List<Object>> zip(List<Object> other) {
  //   final result = <List<Object>>[];
  //   for (var i = 0; i < length; i++) {
  //     result.add([this[i], other[i]]);
  //   }
  //   return result;
  // }

  List<List<T>> zip(List<T> other) {
    final result = <List<T>>[];
    for (var i = 0; i < length; i++) {
      result.add([this[i], other[i]]);
    }
    return result;
  }

  void printAll() => forEach(print);

  Iterable<E> mapIndexed<E>(E Function(int index, T e) toElement) sync* {
    for (var i = 0; i < length; ++i) {
      yield toElement(i, this[i]);
    }
  }
}

void generics3() {
  //? Ограничения типов
  //* 1. Просмотрите класс LootBox ниже

  //* Лутбоксы правильно определяют типы
  final fedoraLootBox = LootBox(Fedora(name: 'A fedora'));
  final coinLootBox = LootBox(Coin(value: 1));
  final stringLootBox = LootBox('hello world!');

  print(fedoraLootBox.fetch());
  fedoraLootBox.open = true;
  print(fedoraLootBox.fetch());

  //* Нам захотелось сделать fetchCoin, но мы не можем, так как не все типы поддерживают поле value
  //* Если обобщать, то нам захотелось сдвинуть рамки возможных типов, для того чтобы поддерживать некий желаемый интерфейс
  //* Это достигается при помощи ограничений типов
  //* Синтаксис: <T extends SomeType> - где SomeType - это тип, которым мы хотим ограничить T
  //* См. пример RestrictedLootBox

  final newFedoraLootBox = RestrictedLootBox(Fedora(name: 'A fedora'));
  //* Лутбокс по прежнему правильно определяет конкретный тип
  newFedoraLootBox.open = true;
  print(newFedoraLootBox.fetchCoin());
  //* И теперь у нас работает fetchCoin
  //* Но раз мы ограничили T до Item, то не сможем теперь сделать так:
  // final newStringLootBox = RestrictedLootBox('hello world!');
  //! Tried to infer 'String' for 'T' which doesn't work:
  //! Type parameter 'T' is declared to extend 'Item' producing 'Item'.

  //; А разве не лучше было бы использовать интерфейс?
  //* См InterfaceLootBox
  final newFedoraLootBox2 = InterfaceLootBox(Fedora(name: 'A fedora'));
  newFedoraLootBox2.open = true;
  print(newFedoraLootBox2.fetchCoin());
  //* Все работает отлично, НО мы потеряли конечный тип (Fedora)

  //; Вывод:
  //; 1. Используйте дженерики и ограничения типов, если вам нужно ограничить типы, но не терять конечный тип
  //; 2. Используйте дженерики если вам не нужно знать конечный тип, но нужна типобезопасность
}

final class LootBox<T> {
  LootBox(T loot) : _loot = loot;

  final T _loot;
  bool open = false;

  T? fetch() => open ? _loot : null;

  //* Ошибка новичка - не все типы поддерживают поле value
  // Coin? fetchCoin() => open ? Coin(value: _loot.value) : null;
}

abstract base class Item {
  Item({
    required this.name,
    required this.value,
  });

  final String name;
  final int value;

  @override
  String toString() => 'D&D Item ($name: $value)';
}

final class Fedora extends Item {
  Fedora({required super.name}) : super(value: 15);
}

final class Coin extends Item {
  Coin({required super.value}) : super(name: 'A coin');
}

final class RestrictedLootBox<T extends Item> {
  RestrictedLootBox(T loot) : _loot = loot;

  final T _loot;
  bool open = false;

  T? fetch() => open ? _loot : null;

  //* Все работает отлично
  Coin? fetchCoin() => open ? Coin(value: _loot.value) : null;
}

final class InterfaceLootBox {
  InterfaceLootBox(Item loot) : _loot = loot;

  final Item _loot;
  bool open = false;

  Item? fetch() => open ? _loot : null;

  //* Все работает отлично
  Coin? fetchCoin() => open ? Coin(value: _loot.value) : null;
}

void generics4() {
  //? Продвинутый пример ограничений типов
  //* Когда же все таки может понадобиться знание конечного типа?

  //* Представим, что у нас есть интерфейс Identifiable, который требует, чтобы любой объект,
  //* его реализующий, имел идентификатор (id).
  //* см Identifiable внизу

  //* Теперь создадим класс Repository, который будет работать с любыми типами, реализующими интерфейс Identifiable.
  //* Этот класс должен предоставлять метод для получения объекта по его идентификатору.
  //* Важно, чтобы при этом мы не теряли конечный тип (например, User или Product).
  //* см IdentifiableRepository внизу

  final userRepository = IdentifiableRepository<User>();
  userRepository.add(User(1, 'Alice'));
  userRepository.add(User(2, 'Bob'));

  final user = userRepository.getById(1);
  print('User: ${user.name}');

  final productRepository = IdentifiableRepository<Product>();
  productRepository.add(Product(1, 'Laptop'));
  productRepository.add(Product(2, 'Smartphone'));

  final product = productRepository.getById(1);
  print('Product: ${product.productName}');

  //* Используя общий интерфейс мы не смогли бы гарантировать что в репозитории хранится лишь 1 реализатор интерфейса

  //; Интересности...
  var userR = IdentifiableRepository<User>();
  var identR = IdentifiableRepository(); //* 1. Extends сам справится с типом

  identR = userR;
  //userR = identR; // Ошибка

  var a = <Object>[];
  var b = <int>[];

  a = b;
  // b = a; // Ошибка
}

abstract interface class Identifiable {
  int get id;
}

final class User implements Identifiable {
  User(this.id, this.name);

  @override
  final int id;
  final String name;
}

final class Product implements Identifiable {
  Product(this.id, this.productName);

  @override
  final int id;
  final String productName;
}

final class IdentifiableRepository<T extends Identifiable> {
  final List<T> items = [];

  void add(T item) {
    items.add(item);
  }

  T getById(int id) {
    return items.firstWhere((item) => item.id == id);
  }
}

void covariant$() {
  //? Ключевое слово covariant
  //* Некоторые (редко используемые) шаблоны проектирования полагаются на ужесточение типа путем переопределения типа
  //* параметра подтипом, что недопустимо. В этом случае вы можете использовать ключевое слово covariant,
  //* чтобы сообщить анализатору, что вы делаете это намеренно.
  //* Это устраняет статическую ошибку и вместо этого проверяет недопустимый тип аргумента во время выполнения.

  //* Пример
  final cat = Cat();
  final mouse = Mouse();

  // cat.chase(cat); //* Логичная ошибка, все нормально
  cat.chase(mouse); //* То что мы хотели

  //* Но...
  // (cat as Animal).chase(cat);

  //* Так что использовать covariant стоит очень осторожно и точно не в таком примере
  //* Хороший пример см с Widget.

  renderWidgets();

  //; см. поиск по covariant в телеграмме
  //; Т.е. covariant реально необходим когда нужно узнать про старый объект (который должен быть того же типа)
}

abstract base class Animal {
  void chase(Animal x);
}

final class Mouse extends Animal {
  final tail = 20;

  @override
  void chase(Animal x) {}
}

final class Cat extends Animal {
  @override
  void chase(covariant Mouse x) {}
  //void chase(Mouse x) {} //! Ошибка новичка
}
//* Хотя в этом примере показано использование covariant в подтипе, ключевое слово covariant можно разместить
//* как в методе суперкласса, так и в методе подкласса.
//* Обычно лучше всего поместить ключевое слово covariant в метод суперкласса.
//* Ключевое слово covariant применяется к одному параметру и также поддерживается для сеттеров и полей.

abstract base class Widget {
  Widget copy();
  void didUpdateWidget(covariant Widget oldWidget);
}

final class StatefulWidget extends Widget {
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {}

  @override
  StatefulWidget copy() => StatefulWidget();
}

final class StatelessWidget extends StatefulWidget {
  @override
  void didUpdateWidget(StatelessWidget oldWidget) {}

  @override
  StatelessWidget copy() => StatelessWidget();
}

void renderWidgets() {
  //* Тут мы можем гарантировать, что didUpdateWidget будет вызван с правильным типом!

  final widgets = <Widget>[StatefulWidget(), StatelessWidget()];

  for (final widget in widgets) {
    final copy = widget.copy();
    //- Some Dark Magic
    copy.didUpdateWidget(widget);
  }
}

void operators() {
  //? Переопределение операторов
  //* Большинство операторов - это методы объекта с специальными именами.
  //* Dart позволяет вам определять операторы с следующими именами:
  // <	>	<=	>=	==	~
  // -	+	/	~/	*	%
  // |	ˆ	&	<<	>>>	>>
  // []=	[]
  //* Некоторые операторы отсутствуют, например, ++ -- != и др. это связано с тем,
  //* что поведение этих операторов встроенно в Dart, и мы не можем переопределить их

  //* Из всего списка наиболее часто переопределяются операторы: == [] []= + - * / & ^
  //* Переопределение операторов позволяет вам определить собственное поведение для операторов,
  //* когда они используются с экземплярами вашего класса.

  //? Синтаксис
  //* Переопределение операторов происходит внутри класса
  //* Type operator +(args) => obj;
  //* Все типы можно менять, неизменным остается только количество аргументов

  // Пример
  const v = Vector(2, 3);
  const w = Vector(2, 2);

  print(v + w); // Vector(4, 5)
  print(v - w); // Vector(0, 1)

  // Пример 2
  //* Пример показывает не только возможность использовать оператор но и
  //* вред таких операторов, потому что они могут быть непонятными, лучше использовать обычные методы
  final a = ConditionA(); // true
  final b = ConditionB(); // false
  final c = ConditionC(); // false (in operator true)
  print(a & b); // false
  print(a & c); // false
  print(c & a); // true
  print(b & c); // false
  print(c & b); // true

  // Пример 3
  final cache = Cache2<int, String>();
  cache[1] = 'one';
  cache[2] = 'two';
  cache[2] = 'three';
  print(cache['three']); // null
  print(cache['two']); // 2
  print(cache['one']); // 1
  // print(cache[1]); // The argument type 'int' can't be assigned to the parameter type 'String'.

  //* Исходя из примеров выше, и из опыта, советуется переопределять только следующие операторы:
  // == [] []=
  //* Если вам нужны остальные уже нужно задуматься, нужно ли это делать
  //* В реальной разработке другие операторы тоже используются, но также редко как и covariant
  // https://drift.simonbinder.eu/docs/getting-started/expressions/
}

final class Vector {
  const Vector(this.x, this.y);

  final int x;
  final int y;

  //* @override - не нужен, так как это не переопределение метода, а создание нового
  //* Оператора + и - у Object не было, поэтому переопределение не нужно
  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  @override
  bool operator ==(Object other) => other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Vector($x, $y)';
}

abstract base class Condition {
  Condition(bool state) : _state = state;

  final bool _state;

  bool operator &(Condition t) {
    return _state && t._state;
  }
}

final class ConditionA extends Condition {
  ConditionA() : super(true);
}

final class ConditionB extends Condition {
  ConditionB() : super(false);
}

final class ConditionC extends Condition {
  ConditionC() : super(false);

  @override
  bool operator &(Condition t) {
    return true;
  }
}

extension IterableX<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

final class Cache2<K, V> {
  final Map<K, V> _cache = {};

  //* Инвертирование ключей и значений
  K? operator [](V value) => _cache.keys.firstWhereOrNull((key) => _cache[key] == value);

  //* Не меняем значение, а только добавляем
  void operator []=(K key, V value) => _cache.putIfAbsent(key, () => value);
}

void conclusion() {
  //? Выводы
  //* 1. Дженерики - это способность использовать один интерфейс и реализацию для многих типов
  //* 2. Дженерики позволяют расширить область повторного использования определений классов
  //* 3. Дженерики обеспечивают безопасность типов и повторное использование кода

  //? Дженерики против интерфейсов
  //* Дженерики это не панацея, они помогают расширить потенциал интерфейсов, но не заменяют их
  //* Если вам важен конечный тип интерфейса - то лучше использовать дженерики с ограничениями
  //* Если не важен конечный тип интерфейса - то лучше использовать интерфейсы
  //* Если вы хотите использовать любой НО конкретный тип - то используем дженерики (см. List<int>, List<String>)

  //? Ковариантность
  //* Ковариантность - это способность использовать конечный тип против интерфейса
  //* Это очень похоже на ограничение дженериков, но без разных типов
  //* Ковариантность используется очень редко и почти всегда (99%) можно обойтись без нее
  //; Используйте осторожно! (может привести к ошибкам во время выполнения)

  //? Переопределение операторов
  //* Переопределение операторов позволяет вам определить собственное поведение для операторов
  //; Помните, что методы почти всегда (99%) лучше чем операторы (не считая ==)
  //; Так как не всегда понятно, что делает оператор, так как он не имеет имени.

  //? Вопросы для проверки
  //* 1. Как можно улучшить LinearStructure (Stack, Queue)? (см. лекцию 12)
  //* 2. Как можно улучшить sum и average для разных типов? (см. лекцию 10)

  final a = [1].sum;
  final b = [2.4].sum;
  final c = [1, 2.3].sum;
}

//; LinearStructure
//; sum average

extension NumIterableExtension<T extends num> on Iterable<T> {
  double get average => isEmpty ? 0 : reduce((value, element) => (value + element) as T) / length;

  T get sum {
    num sum = 0;
    for (final el in this) {
      sum += el;
    }
    return sum as T;
  }
}

void main() {
  final labels = {
    'generics': generics,
    'generics2': generics2,
    'generics3': generics3,
    'generics4': generics4,
    'covariant': covariant$,
    'operators': operators,
  };

  final divider = '=' * 20;

  for (final MapEntry(key: title, value: action) in labels.entries) {
    print('$divider $title $divider');
    action();
    print('\n');
  }
}

// Домашка
//? 1. Кэш система
//* Создайте универсальную кэш-систему, которая может хранить и извлекать данные любых типов с определённым временем жизни
//* (TTL - Time to Live).
//* Пример работы:
/*
import 'dart:io';

void main() {
  final cache = CacheTtl<String, double>();
  cache.set(('pi', 3.14, ttl: const Duration(milliseconds: 500)));
  cache.set(('e', 2.17, ttl: const Duration(seconds: 10)));

  print(cache.get('pi')) // 3.14
  print(cache.get('e')) // 2.17

  sleep(const Duration(seconds: 1));

  print(cache.get('pi')) // null
  print(cache.get('e')) // 2.17
}
*/

//? 2. Система управления задачами
//* Абстрактная задача (Task) имеет поля id, title (интерпретируйте её как задачу для планирования проекта),
//* Task должен быть способен конвертироваться в строку.
//
//* Создайте конкретные задачи: FeatureTask, BugTask, TestTask
//* Каждая конкретная задача должна иметь свои поля и методы, которые отличаются от других задач.
//
//* TaskManager - класс который управляет задачами, причем может управлять как общими задачами, так и конкретными
//* TaskManager должен уметь:
//* 1. Добавлять одну задачу
//* 2. Удалять все задачи по заданному id
//* 3. Получать все задачи по заданному id (sync* метод)
//* 4. Получить все задачи определенного типа (sync* метод)
//* 5. Вывести все задачи на экран

//? 3. Пагинация
//* Создайте универсальный класс для пагинации Paginator (разбиения на страницы) данных.
//* Класс будет принимать список данных и размер страницы.
//* Реализуйте методы для получения данных для конкретной страницы, а также для перехода на следующую и предыдущую страницы.
//* Реализуйте геттер для получения общего количества страниц.
//* Добавьте метод для фильтрации данных по заданному критерию (sync*).
//
//; P.s не забудьте про выходы за границы - в таком случае просто не переходите на следующую или предыдущую страницу
//* Пример использования:
/*
void main() {
  final items = List.generate(25, (index) => index + 1); // Список чисел от 1 до 25
  final paginator = Paginator(items, pageSize: 5);

  print('Total Pages: ${paginator.totalPages}');

  print('Page 1: ${paginator.getPage(0)}'); // [1, 2, 3, 4, 5]
  print('Page 2: ${paginator.nextPage()}'); // [6, 7, 8, 9, 10]
  print('Page 3: ${paginator.nextPage()}'); // [11, 12, 13, 14, 15]
  print('Page 2: ${paginator.previousPage()}'); // [6, 7, 8, 9, 10]
  print('Page 4: ${paginator.getPage(4)}'); // [21, 22, 23, 24, 25]
  print('Page 4: ${paginator.nextPage()}'); // [21, 22, 23, 24, 25]
  print('Page 3: ${paginator.previousPage()}'); // [16, 17, 18, 19, 20]

  print('Filtered Items: ${paginator.filter((item) => item % 2 == 0 && item > 10)}'); // (12, 14, 16, 18, 20, 22, 24)
}
*/

//? 4. Комплексные числа
//* Создайте класс ComplexNumber, который представляет комплексное число.
//* У класса должны быть два поля: действительная часть (real) и мнимая часть (imaginary).
//* Класс должен уметь складываться, вычитаться, умножаться и делиться на другие комплексные числа (объекты ComplexNumber).
//* То есть вам нужно переопределить арифметические операторы.
//
//* Также комплексные числа могут быть константами, и должны уметь сравниваться между собой.
//* Помимо сравнения на эквивалентность (==), вам нужно реализовать сравнение на больше и меньше (< <= > >=).
//* Больше и меньше реализуйте через использование их модулей (корень из суммы квадратов действительной и мнимой частей).
//* Класс также должен быть способен красиво конвертироваться в строку. например: "1 + 2i".
//
//; P.s помимо сравнений, объекты класса должны быть способны к сортировке (если находятся в списке) (используйте Comparable)
//
//; Q: Вы переопределили операторы (< <= > >=) через модули, но как вы думаете - можно ли было бы сделать это иначе?
//; Может быть использовать compareTo?
//; И раз класс реализующий Comparable имеет compareTo, а операторы (< <= > >=) работают через compareTo, то зачем переопределять их?
//; Сможете ли вы додуматься как для всех реализаторов Comparable (не только для комплексных чисел)
//; автоматически переопределить операторы (< <= > >=)?
