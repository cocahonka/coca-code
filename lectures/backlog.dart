// ignore_for_file: no_runtimetype_tostring, cascade_invocations, avoid_equals_and_hash_code_on_mutable_classes, use_to_and_as_if_applicable, curly_braces_in_flow_control_structures, prefer_foreach

import 'dart:io';
import 'dart:math';

base mixin Equatable {
  List<Object?> get props;

  //; props.hashCode неверно - это будет хэш код листа (просто листа)
  //; а Object.hashAll(props); - хэш код всех полей
  @override
  int get hashCode => Object.hashAll(props);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Equatable &&
        other.runtimeType == runtimeType &&
        _listEquals(props, other.props);
  }

  bool _isObjectsEquals(Object? object1, Object? object2) {
    if (identical(object1, object2))
      return true; // Сравнение по участку в памяти P.S два nulls тут тоже будут равны
    if (object1 == null || object2 == null)
      return false; // Исходя из прошлого, если один нул тогда капут
    if (object1.runtimeType != object2.runtimeType)
      return false; // Типы рантайма
    if (object1 is List && object2 is List && !_listEquals(object1, object2))
      return false; // Если лист
    if (object1 is Map && object2 is Map && !_mapEquals(object1, object2))
      return false; // Если карта

    // Если Iterable (Set является подтипом, наследником Iterable, поэтому таким образом можно проверить Set)
    // Это менее эффективно, но демонстрирует полиморфизм
    // Почему для List также не сделали - это менее эффективно
    if (object1 is Iterable &&
        object2 is Iterable &&
        !_listEquals(object1.toList(), object2.toList()))
      return false;

    return object1 == object2;
  }

  bool _listEquals(List<Object?> list1, List<Object?> list2) {
    if (list1.length != list2.length) return false;

    for (var i = 0; i < list1.length; i++) {
      final (unit1, unit2) = (list1[i], list2[i]);

      if (!_isObjectsEquals(unit1, unit2)) return false;
    }

    return true;
  }

  bool _mapEquals(Map<Object?, Object?> map1, Map<Object?, Object?> map2) {
    if (map1.length != map2.length) return false;

    for (final key1 in map1.keys) {
      if (!map2.containsKey(key1)) return false;

      final (value1, value2) = (map1[key1], map2[key1]);

      if (!_isObjectsEquals(value1, value2)) return false;
    }

    return true;
  }

  @override
  String toString() {
    final propsString = props.map((e) => e.toString()).join(', ');

    return '$runtimeType: ($propsString)';
  }
}

base class EqualityTest with Equatable {
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

enum AudioPlayerState { locked, ready, playing }

class Locker {
  static final _random = Random();

  /// return true if player is successfully unlocked
  bool tryUnlock() => _random.nextDouble() >= 0.25;
}

class AudioPlayer {
  AudioPlayerState _currentState = AudioPlayerState.locked;

  final Locker _locker = Locker();

  void clickLock() {
    switch (_currentState) {
      case AudioPlayerState.locked:
        if (_locker.tryUnlock()) {
          print('Player Unlocked!');
          _currentState = AudioPlayerState.ready;
        } else {
          print('Invalid unlock attempt');
        }
      case AudioPlayerState.ready:
      case AudioPlayerState.playing:
        print('Lock player');
        _currentState = AudioPlayerState.locked;
    }
  }

  void clickPlay() {
    switch (_currentState) {
      case AudioPlayerState.locked:
        print('Player is locked! Unlock it first!');
      case AudioPlayerState.ready:
        print('Playing...');
        _currentState = AudioPlayerState.playing;
      case AudioPlayerState.playing:
        print('Already playing');
    }
  }

  void clickNext() {
    switch (_currentState) {
      case AudioPlayerState.locked:
        print('Player is locked! Unlock it first!');
      case AudioPlayerState.ready:
        print('Switch to next track, but not playing');
      case AudioPlayerState.playing:
        print('Switch to next track and continue playing');
    }
  }

  void clickStop() {
    switch (_currentState) {
      case AudioPlayerState.locked:
        print('Player is locked! Unlock it first!');
      case AudioPlayerState.ready:
        print('Playing is already stopped');
      case AudioPlayerState.playing:
        print('Stop playing');
        _currentState = AudioPlayerState.ready;
    }
  }
}

class Widget {
  Widget({this.child});

  final Widget? child;

  Widget? build() => throw UnimplementedError();
}

class Text extends Widget {
  Text({required this.data, super.child});

  final String data;

  @override
  Widget? build() {
    print('Text: $data');
    return child?.build();
  }
}

class Picture extends Widget {
  Picture({required this.url, super.child});

  final String url;

  @override
  Widget? build() {
    print('Picture: $url');
    return child?.build();
  }
}

class Column extends Widget {
  Column({required this.contents, super.child});

  final List<Widget> contents;

  @override
  Widget? build() {
    print('Column');
    for (final child in contents) {
      child.build();
    }
    return child?.build();
  }
}

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

final class Weather {
  const Weather({
    required this.date,
    required this.temperature,
    required this.description,
  });

  factory Weather.fromLine(String line) {
    final parts = line.split(' ');
    return Weather(
      date: DateTime.parse(parts[0]),
      temperature: double.parse(parts[1]),
      description: parts[2],
    );
  }

  final DateTime date;
  final double temperature;
  final String description;

  @override
  String toString() => 'Weather: $date, $temperature, $description';
}

abstract interface class WeatherRepository {
  void add(Weather weather);
  Weather? get(DateTime date);
  void remove(DateTime date);
  void clear();
  void syncDataTo(WeatherRepository other);
}

final class InMemoryWeatherRepository implements WeatherRepository {
  final _weathers = <DateTime, Weather>{};

  @override
  void add(Weather weather) {
    _weathers[weather.date] = weather;
  }

  @override
  Weather? get(DateTime date) => _weathers[date];

  @override
  void remove(DateTime date) {
    _weathers.remove(date);
  }

  @override
  void clear() {
    _weathers.clear();
  }

  @override
  void syncDataTo(WeatherRepository other) {
    other.clear();
    for (final weather in _weathers.values) {
      other.add(weather);
    }
  }
}

final class FileWeatherRepository implements WeatherRepository {
  FileWeatherRepository(String path) : _file = File(path);

  final File _file;

  @override
  void add(Weather weather) {
    final line =
        '${weather.date.toIso8601String()} ${weather.temperature} ${weather.description}\n';
    _file.writeAsStringSync(line, mode: FileMode.append);
  }

  @override
  Weather? get(DateTime date) {
    final line = _file.readAsLinesSync().firstWhere(
      (line) => line.startsWith(date.toIso8601String()),
      orElse: () => '',
    );
    if (line.isEmpty) return null;

    return Weather.fromLine(line);
  }

  @override
  void remove(DateTime date) {
    final lines = _file.readAsLinesSync();
    final newLines = lines.where(
      (line) => !line.startsWith(date.toIso8601String()),
    );
    _file.writeAsStringSync(newLines.join('\n'));
  }

  @override
  void clear() {
    _file.writeAsStringSync('');
  }

  @override
  void syncDataTo(WeatherRepository other) {
    other.clear();
    for (final line in _file.readAsLinesSync()) {
      final weather = Weather.fromLine(line);
      other.add(weather);
    }
  }
}

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

final class Good {
  const Good({required this.name, required this.price, required this.amount});

  final String name;
  final double price;
  final int amount;

  double get total => price * amount;

  Good copyWith({String? name, double? price, int? amount}) {
    return Good(
      name: name ?? this.name,
      price: price ?? this.price,
      amount: amount ?? this.amount,
    );
  }

  @override
  int get hashCode => Object.hashAll([name, price, amount]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Good &&
        other.runtimeType == runtimeType &&
        other.name == name &&
        other.price == price &&
        other.amount == amount;
  }
}

abstract interface class GoodsWrapper {
  void add(Good good);
  void remove(Good good);
  void clear();
  double get total;
  FreezedGoodsWrapper freeze();
}

final class FreezedGoodsWrapper implements GoodsWrapper {
  const FreezedGoodsWrapper(this._delegatedWrapper);

  final GoodsWrapper _delegatedWrapper;

  @override
  void add(Good good) => throw UnimplementedError();

  @override
  void remove(Good good) => throw UnimplementedError();

  @override
  void clear() => throw UnimplementedError();

  @override
  FreezedGoodsWrapper freeze() => _delegatedWrapper.freeze();

  @override
  double get total => _delegatedWrapper.total;
}

final class StackGoodsWrapper implements GoodsWrapper {
  StackGoodsWrapper() : _goods = [];

  final List<Good> _goods;

  @override
  void add(Good good) {
    if (_goods.contains(good)) return;

    _goods.add(good);
  }

  @override
  void remove(Good good) {
    _goods.remove(good);
  }

  @override
  void clear() {
    _goods.clear();
  }

  @override
  double get total => _goods.fold(0, (total, good) => total + good.total);

  @override
  FreezedGoodsWrapper freeze() => FreezedGoodsWrapper(this);
}

final class SetGoodsWrapper implements GoodsWrapper {
  SetGoodsWrapper() : _goods = {};

  final Set<Good> _goods;

  @override
  void add(Good good) {
    _goods.add(good);
  }

  @override
  void remove(Good good) {
    _goods.remove(good);
  }

  @override
  void clear() {
    _goods.clear();
  }

  @override
  double get total => _goods.fold(0, (total, good) => total + good.total);

  @override
  FreezedGoodsWrapper freeze() => FreezedGoodsWrapper(this);
}

abstract base class Wallet {
  Wallet() : _balance = 0;
  double _balance;

  double get balance => _balance;

  void add(double amount) {
    if (amount < 0) throw ArgumentError('Amount must be positive');
    _balance += amount;
  }

  void remove(double amount) {
    if (amount < 0) throw ArgumentError('Amount must be positive');
    if (_balance < amount) throw ArgumentError('Not enough money');
    _balance -= amount;
  }
}

final class StandardWallet extends Wallet {}

final class CashbackWallet extends Wallet {
  @override
  void add(double amount) {
    super.add(amount);
    _balance += amount * 0.1;
  }
}

abstract base class PaymentSystem {
  PaymentSystem(this.wallet);

  Wallet wallet;

  int processPayment(GoodsWrapper goods);
  bool refundPayment(int orderId);
}

final class SberPaymentSystem extends PaymentSystem {
  SberPaymentSystem(super.wallet);

  final _transactions = <int, GoodsWrapper>{};
  final _generator = Random.secure();

  @override
  int processPayment(GoodsWrapper goods) {
    final total = goods.total;
    if (total > wallet.balance) throw ArgumentError('Not enough money');

    wallet.remove(total);
    final paymentId = _generator.nextInt(-1 >>> 1);
    _transactions[paymentId] = goods;

    return paymentId;
  }

  @override
  bool refundPayment(int orderId) {
    final goods = _transactions.remove(orderId);
    if (goods == null) return false;

    wallet.add(goods.total);
    return true;
  }
}

void main() {
  final longWidgetTree = Column(
    contents: [
      Text(data: 'Hello'),
      Column(
        contents: [
          Text(data: 'World'),
          Picture(url: 'https://example.com/image.png'),
        ],
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

  const test = EqualityTest(
    a: 'a',
    b: 1,
    c: [1, 2, 3],
    d: [1, 2.5, 'd'],
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
      ],
    ],
    f: {
      1: [
        {
          [
            {'1': 1},
            {'2': 2},
          ],
        },
        {
          [
            {'3': 3},
            {'4': 4},
          ],
        },
      ],
      2: [
        {
          [
            {'5': 5},
            {'6': 6},
          ],
        },
        {
          [
            {'7': 7},
            {'8': 8},
          ],
        },
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
          ],
        },
        {
          [
            {
              ['3']: 3,
            },
            {
              ['4']: 4,
            },
          ],
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
          ],
        },
        {
          [
            {
              ['7']: 7,
            },
            {
              ['8']: 8,
            },
          ],
        },
      ],
    },
  );
  print(test);
  print(test == test.copyWith()); // true
  print(test == test.copyWith(a: 'Z')); // false

  final list = <int>[];
  print(list.hashCode);
  list.add(5);
  print(list.hashCode);
  list.add(8);
  print(list.hashCode);

  print(-1 >>> 1);

  final player = AudioPlayer();
  while (true) {
    final input = stdin.readLineSync()!.trim().toLowerCase();
    switch (input) {
      case 'lock':
        player.clickLock();
      case 'play':
        player.clickPlay();
      case 'next':
        player.clickNext();
      case 'stop':
        player.clickStop();
      case 'exit':
        return;
      default:
        print('Unknown command');
    }
  }
}

final class ComplexNumber implements Comparable<ComplexNumber> {
  const ComplexNumber({this.real = 0, this.imaginary = 0});

  final double real; // Зачем здесь num было?
  final double imaginary; // Зачем здесь num было?

  double get modulus => sqrt(real * real + imaginary * imaginary);

  @override
  String toString() => '$real + ${imaginary}i';

  //* В помойку
  //bool operator <(ComplexNumber other) => modulus < other.modulus;
  //bool operator <=(ComplexNumber other) => modulus <= other.modulus;
  //bool operator >(ComplexNumber other) => modulus > other.modulus;
  //bool operator >=(ComplexNumber other) => modulus >= other.modulus;

  @override
  int compareTo(ComplexNumber other) => modulus.compareTo(other.modulus);
}

extension OilMansExtension<T> on Comparable<T> {
  bool operator <(T other) => compareTo(other) < 0;
  bool operator <=(T other) => compareTo(other) <= 0;
  bool operator >(T other) => compareTo(other) > 0;
  bool operator >=(T other) => compareTo(other) >= 0;
}
