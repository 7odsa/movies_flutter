sealed class StateUi<Data, Error> {
  final Data? data;
  final Error? error;

  StateUi({this.data, this.error});
}

class SuccessState<Data, Error> extends StateUi<Data, Error> {
  SuccessState(Data data) : super(data: data);
}

class ErrorState<Data, Error> extends StateUi<Data, Error> {
  ErrorState(Error e) : super(error: e);
}

class LoadingState<Data, Error> extends StateUi<Data, Error> {}

void main(List<String> args) {
  StateUi<int, String>? stateUi = LoadingState();
  stateUi = SuccessState(1);
  print(stateUi.data);
}
