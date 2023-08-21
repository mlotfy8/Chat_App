part of 'singin_cubit.dart';

@immutable
abstract class SinginState {}

class SinginInitial extends SinginState {}
class SinginSuccess extends SinginState {}
class SinginFaluier extends SinginState {}
class SinginLoading extends SinginState {}
