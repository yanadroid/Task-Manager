import 'package:equatable/equatable.dart';

abstract class CreateTaskState extends Equatable {

  const CreateTaskState();

  @override
  List<Object> get props => [];
}

class CreateTaskInitial extends CreateTaskState {}

class CreateTaskLoadingState extends CreateTaskState {}

class CreateTaskSuccessState extends CreateTaskState {}

class CreateTaskFailureState extends CreateTaskState {
  final String error;

  const CreateTaskFailureState({required this.error});

  @override
  List<Object> get props => [error];
}


