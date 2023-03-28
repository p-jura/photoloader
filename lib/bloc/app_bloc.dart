import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

part 'app_bloc_event.dart';
part 'app_bloc_state.dart';

typedef AppBlockRandomUrlPicker = String Function(Iterable<String> allUrl);

extension RandomIterableElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}

class ApplicationBloc extends Bloc<AppBlocEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  ApplicationBloc({
    Duration? waitBeforeLoading,
    required Iterable<String> urls,
    AppBlockRandomUrlPicker? urlPicker,
  }) : super(
          AppState.empty(),
        ) {
    on<LoadNextUrlEvent>(
      (event, emit) async {
        emit(
          AppState(
            isLoading: true,
            data: null,
            error: null,
          ),
        );
        final url = (urlPicker ?? _pickRandomUrl)(urls);
        try {
          if (waitBeforeLoading != null) {
            await Future.delayed(waitBeforeLoading);
          }
          final bundle = NetworkAssetBundle(Uri.parse(url));
          final data = (await bundle.load(url)).buffer.asUint8List();
          emit(
            AppState(
              isLoading: false,
              data: data,
              error: null,
            ),
          );
        } catch (e) {
          emit(
            AppState(
              isLoading: false,
              data: null,
              error: e,
            ),
          );
        }
      },
    );
  }
}
