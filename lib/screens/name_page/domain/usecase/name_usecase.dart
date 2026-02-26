import 'package:application/core/failure/failure.dart';
import 'package:application/screens/name_page/domain/repository/name_repository.dart';
import 'package:dartz/dartz.dart';

class NameUsecase {
  final NameRepository repository;
  NameUsecase(this.repository);

  Future<Either<Failure, String>> call(String name, String phoneNumber) {
    return repository.createAccount(name,phoneNumber);
  }
}