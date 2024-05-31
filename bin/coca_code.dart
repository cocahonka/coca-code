const greetings = [
  'Hello',
  'Привет',
  'Hola',
  'Bonjour',
  'Ciao',
  '안녕하세요',
  'こんにちは',
  '你好',
  'Olá',
  'Xin chào',
  'สวัสดี',
  'Hallå',
  'Hoi',
  'Salut',
  'שלום',
  'مرحبا',
  'नमस्ते',
  'Cześć',
  'Γειά σας',
];

void main(List<String> args) {
  final greeting = ([...greetings]..shuffle()).first;

  print('$greeting, ${args.first}');
}
