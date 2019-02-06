import 'dart:io';

import 'package:redurx/redurx.dart';
import 'package:redurx_persist/redurx_persist.dart';

void main() async {
  final persistor = Persistor<State>(
    storage: FileStorage(File("state.json")),
    serializer: JsonSerializer<State>(State.fromJson),
  );

  // Load initial state
  final initialState = await persistor.load();

  final store = Store<State>(initialState ?? State(counter: 0));

  // ...
}

class State {
  final int counter;

  State({this.counter = 0});

  State copyWith({int counter}) => State(counter: counter ?? this.counter);

  static State fromJson(dynamic json) => State(counter: json["counter"] as int);

  dynamic toJson() => {'counter': counter};
}

class IncrementCounter extends Action<State> {
  @override
  State reduce(State state) => state.copyWith(counter: state.counter + 1);
}
