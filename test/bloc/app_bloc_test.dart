import 'dart:typed_data';

import 'package:bloc_multi_provider/bloc/app_bloc.dart';
import "package:bloc_test/bloc_test.dart";
import 'package:flutter_test/flutter_test.dart';

extension ToList on String {
  Uint8List toUint8List() => Uint8List.fromList(codeUnits);
}

final text1Data = 'test1'.toUint8List();
final text2Data = 'test2'.toUint8List();

enum Errors { dummy }

void main() {
  blocTest<ApplicationBloc, AppState>(
    'initial state of bloc should be empty',
    build: () => ApplicationBloc(urls: []),
    verify: (bloc) => expect(
      bloc.state,
      AppState.empty(),
    ),
  );
  blocTest<ApplicationBloc, AppState>(
    'load valid data, should return state with data',
    build: () => ApplicationBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text1Data),
    ),
    act: (bloc) => bloc.add(
      LoadNextUrlEvent(),
    ),
    expect: () => [
      AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text1Data,
        error: null,
      ),
    ],
  );

  blocTest<ApplicationBloc, AppState>(
    'should throw an error in url loader and catch it',
    build: () => ApplicationBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.error(Errors.dummy),
    ),
    act: (bloc) => bloc.add(
      LoadNextUrlEvent(),
    ),
    expect: () => [
      AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: null,
        error: Errors.dummy,
      ),
    ],
  );
  blocTest<ApplicationBloc, AppState>(
    'load valid data, should return state with data twice',
    build: () => ApplicationBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text2Data),
    ),
    act: (bloc) {
      bloc.add(
        LoadNextUrlEvent(),
      );
      bloc.add(
        LoadNextUrlEvent(),
      );
    },
    expect: () => [
      AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text2Data,
        error: null,
      ),
      AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text2Data,
        error: null,
      ),
    ],
  );
}
