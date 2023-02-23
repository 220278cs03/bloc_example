class MainState {
  final int counter;
  final String name;

  MainState({ this.counter = 0,  this.name = ""});

  MainState copyWith({String? n, int? c}) => MainState(counter: c ?? counter, name: n ?? name);
}