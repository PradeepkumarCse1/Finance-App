import 'package:equatable/equatable.dart';

enum NameStatus {
  initial,
  typing,
  valid,
  invalid,
  submitting,
  success,
  error,
}

class NameState extends Equatable {
  final String name;
  final NameStatus status;
  final String? errorMessage;

  const NameState({
    this.name = '',
    this.status = NameStatus.initial,
    this.errorMessage,
  });

  NameState copyWith({
    String? name,
    NameStatus? status,
    String? errorMessage,
  }) {
    return NameState(
      name: name ?? this.name,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [name, status, errorMessage];
}