import 'dart:async';

enum CounterAction { increment, decrement, reset }

class CounterBloc {
  late int _counter;

  // state
  final _stateStreamController = StreamController<int>();

  StreamSink<int> get _counterSink =>
      _stateStreamController.sink; // counter input
  Stream<int> get counterStream =>
      _stateStreamController.stream; // counter output

  // event
  final _eventStreamController = StreamController<CounterAction>();

  StreamSink<CounterAction> get eventSink =>
      _eventStreamController.sink; // event input
  Stream<CounterAction> get _eventStream =>
      _eventStreamController.stream; // event output

  CounterBloc() {
    _counter = 0;

    _eventStream.listen((event) {
      if (event == CounterAction.increment) {
        _counter++;
      } else if (event == CounterAction.decrement) {
        _counter--;
      } else if (event == CounterAction.reset) {
        _counter = 0;
      }

      _counterSink.add(_counter);
    });
  }
}
