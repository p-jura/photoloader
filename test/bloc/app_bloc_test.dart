import 'package:bloc_multi_provider/bloc/app_bloc.dart';
import "package:bloc_test/bloc_test.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  blocTest<ApplicationBloc, AppState>(
    'initial state of bloc should be empty',
    build: () => ApplicationBloc(urls: []),
    verify: (bloc) => expect(bloc.state, AppState.empty()),
  );
}
