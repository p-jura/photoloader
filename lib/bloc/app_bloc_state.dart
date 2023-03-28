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
}
