part of 'app_bloc.dart';

@immutable
abstract class AppBlocState {}

class AppState extends AppBlocState {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  AppState({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  AppState.empty()
      : isLoading = false,
        data = null,
        error = null;

  @override
  String toString() => {
        'isisLoading': isLoading,
        'hasData': data,
        'error': error,
      }.toString();
  @override
  bool operator ==(covariant AppState other) =>
      isLoading == other.isLoading &&
      (data ?? []).isEqualTo(other.data ?? []) &&
      error == other.error;

  @override
  int get hashCode => Object.hash(
        isLoading,
        data,
        error,
      );
}

extension Comparison<E> on List<E> {
  bool isEqualTo(List<E> other) {
    if (identical(this, other)) {
      return true;
    }
    if (length != other.length) {
      return false;
    }
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}
