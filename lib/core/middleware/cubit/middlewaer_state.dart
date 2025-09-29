part of 'middlewaer_cubit.dart';

@immutable
sealed class MiddlewaerState {}

final class MiddlewaerInitial extends MiddlewaerState {}

class AppInitial extends MiddlewaerState {}

class AppLoading extends MiddlewaerState {}

class AppGoHome extends MiddlewaerState {}

class AppGoLogin extends MiddlewaerState {}

class AppGoOnBoarding extends MiddlewaerState {}
