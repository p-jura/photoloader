import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

part 'app_bloc_event.dart';
part 'app_bloc_state.dart';

typedef AppBlockRandomUrlPicker = String Function(Iterable<String> allUrl);
typedef UrlLoader = Future<Uint8List> Function(String url);

extension RandomIterableElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}

class ApplicationBloc extends Bloc<AppBlocEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  Future<Uint8List> _loadUrl(String url) => NetworkAssetBundle(Uri.parse(url))
      .load(url)
      .then((byteData) => byteData.buffer.asUint8List());

  ApplicationBloc({
    Duration? waitBeforeLoading,
    required Iterable<String> urls,
    AppBlockRandomUrlPicker? urlPicker,
    UrlLoader? urlLoader,
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

          final data = await (urlLoader ?? _loadUrl)(url);
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


