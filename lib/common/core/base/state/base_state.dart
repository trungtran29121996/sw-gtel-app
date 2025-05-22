import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  final bool isLoading;
  final int timeStamp;
  final String baseError;

  const BaseState(
      {this.timeStamp = 1, this.isLoading = true, this.baseError = ''})
      : super();

  @override
  List<Object?> get props => [isLoading, timeStamp];
}
