part of 'app_bloc.dart';

@immutable
abstract class AppBlocEvent {}

@immutable
class LoadNextUrlEvent implements AppBlocEvent {}
