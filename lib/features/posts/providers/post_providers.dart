import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/post_cache_data_source.dart';
import '../data/datasources/post_remote_data_source.dart';
import '../data/repositories/post_repository_impl.dart';
import '../domain/repositories/post_repository.dart';
import '../domain/usecases/get_posts_use_case.dart';

part 'post_providers.g.dart';

/// 数据层依赖注入提供者
/// 这些提供者负责创建和管理数据层实例

// --- Repository ---
@Riverpod(keepAlive: true)
PostRepository postRepository(Ref ref) {
  return PostRepositoryImpl(
    ref.watch(postRemoteDataSourceProvider),
    ref.watch(postCacheDataSourceProvider),
  );
}

// --- Use Cases ---
@Riverpod(keepAlive: true)
GetPostsUseCase getPostsUseCase(Ref ref) {
  return GetPostsUseCase(ref.watch(postRepositoryProvider));
}
