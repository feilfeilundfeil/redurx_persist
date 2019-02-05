import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:redurx/redurx.dart';
import 'package:redurx_persist/redurx_persist.dart';
import 'package:redurx_persist_flutter/redurx_persist_flutter.dart';

void main() async {
  // Create Persistor
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Load initial state
  final initialState = await persistor.load();

  final store = Store<AppState>(initialState ?? AppState(counter: 0))
    ..add(PersistorMiddleware<AppState>(persistor));

  runApp(App(store: store));
}

// Redux
class AppState {
  final int counter;

  AppState({this.counter = 0});

  AppState copyWith({int counter}) => AppState(counter: counter ?? this.counter);

  static AppState fromJson(dynamic json) => AppState(counter: json["counter"] as int);

  dynamic toJson() => {'counter': counter};
}

class IncrementCounter extends Action<AppState> {
  @override
  AppState reduce(AppState state) => state.copyWith(counter: state.counter + 1);
}

// App
class App extends StatelessWidget {
  final Store<AppState> store;

  const App({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      store: store,
      child: MaterialApp(title: 'Redux Persist Demo', home: HomePage()),
    );
  }
}

// Counter example
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redux Persist demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Connect<AppState, String>(
              convert: (state) => state.counter.toString(),
              where: (prev, next) => prev != next,
              builder: (count) => Text('$count',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.dispatch<AppState>(context, IncrementCounter()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
