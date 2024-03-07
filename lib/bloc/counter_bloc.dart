import 'dart:async';

enum CounterEvent { Increment, Decrement }

class CounterBloc {
  int counter = 0;

  final StreamController<CounterEvent> _eventController =
      StreamController<CounterEvent>();

  StreamSink get eventSink => _eventController.sink;

  final StreamController<int> _counterController = StreamController<int>();
  StreamSink get counterSink => _counterController.sink;
  Stream<int> get counterStream => _counterController.stream;

  CounterBloc() {
    _eventController.stream.listen((data) { // langganan stream data dulu
      _mapEventToState(data);
    });
  }

  void _mapEventToState(CounterEvent event) {
    if (event == CounterEvent.Increment) {
      counter++;
    } else {
      counter--;
    }
    _counterController.add(counter);
  }

  void dispose() {
    _eventController.close();
    _counterController.close();
  }
}
