import 'package:fpdart/fpdart.dart';
import 'package:flutter_init/core/error/failures.dart';
import 'package:flutter_init/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_init/features/posts/domain/repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository _repository;

  GetPostsUseCase(this._repository);

  Future<Either<Failure, List<PostEntity>>> call({bool forceRefresh = false}) {
    return _repository.getPosts(forceRefresh: forceRefresh);
  }
}
