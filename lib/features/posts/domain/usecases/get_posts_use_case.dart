import 'package:fpdart/fpdart.dart';
import 'package:init/core/error/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository _repository;

  GetPostsUseCase(this._repository);

  Future<Either<Failure, List<PostEntity>>> call({bool forceRefresh = false}) {
    return _repository.getPosts(forceRefresh: forceRefresh);
  }
}
