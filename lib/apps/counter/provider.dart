import 'dart:async';

abstract class Provider {
  void dispose();
  Function(int) get onTapCounter;
  Stream<int> get counter;
}

class ProviderImplementation implements Provider {
  final StreamController _counterController = StreamController<int>();

  Function(int) get onTapCounter => _counterController.sink.add;
  Stream<int> get counter => _counterController.stream;

  @override
  void dispose() {
    _counterController?.close();
  }
}
