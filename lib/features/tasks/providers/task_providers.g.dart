// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 数据层依赖注入提供者
/// 这些提供者负责创建和管理数据层实例
// --- Repository ---

@ProviderFor(taskRepository)
final taskRepositoryProvider = TaskRepositoryProvider._();

/// 数据层依赖注入提供者
/// 这些提供者负责创建和管理数据层实例
// --- Repository ---

final class TaskRepositoryProvider
    extends $FunctionalProvider<TaskRepository, TaskRepository, TaskRepository>
    with $Provider<TaskRepository> {
  /// 数据层依赖注入提供者
  /// 这些提供者负责创建和管理数据层实例
  // --- Repository ---
  TaskRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskRepositoryHash();

  @$internal
  @override
  $ProviderElement<TaskRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskRepository create(Ref ref) {
    return taskRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskRepository>(value),
    );
  }
}

String _$taskRepositoryHash() => r'b2cad6b7f697aa4e6edd5ce29dbf68e0d14699e2';

@ProviderFor(getTasksUseCase)
final getTasksUseCaseProvider = GetTasksUseCaseProvider._();

final class GetTasksUseCaseProvider
    extends
        $FunctionalProvider<GetTasksUseCase, GetTasksUseCase, GetTasksUseCase>
    with $Provider<GetTasksUseCase> {
  GetTasksUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTasksUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTasksUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTasksUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTasksUseCase create(Ref ref) {
    return getTasksUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTasksUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTasksUseCase>(value),
    );
  }
}

String _$getTasksUseCaseHash() => r'8e2642b358f8117c10d66eff3cd21d011f590cd8';

@ProviderFor(addTaskUseCase)
final addTaskUseCaseProvider = AddTaskUseCaseProvider._();

final class AddTaskUseCaseProvider
    extends $FunctionalProvider<AddTaskUseCase, AddTaskUseCase, AddTaskUseCase>
    with $Provider<AddTaskUseCase> {
  AddTaskUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addTaskUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addTaskUseCaseHash();

  @$internal
  @override
  $ProviderElement<AddTaskUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddTaskUseCase create(Ref ref) {
    return addTaskUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddTaskUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddTaskUseCase>(value),
    );
  }
}

String _$addTaskUseCaseHash() => r'ebf423da8f3e86b1abef205dc7f972d720de1e19';

@ProviderFor(updateTaskUseCase)
final updateTaskUseCaseProvider = UpdateTaskUseCaseProvider._();

final class UpdateTaskUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateTaskUseCase,
          UpdateTaskUseCase,
          UpdateTaskUseCase
        >
    with $Provider<UpdateTaskUseCase> {
  UpdateTaskUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTaskUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTaskUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateTaskUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateTaskUseCase create(Ref ref) {
    return updateTaskUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateTaskUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateTaskUseCase>(value),
    );
  }
}

String _$updateTaskUseCaseHash() => r'3437bf6ed4e72695d3daefc09a19e5a5e9419885';

@ProviderFor(deleteTaskUseCase)
final deleteTaskUseCaseProvider = DeleteTaskUseCaseProvider._();

final class DeleteTaskUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteTaskUseCase,
          DeleteTaskUseCase,
          DeleteTaskUseCase
        >
    with $Provider<DeleteTaskUseCase> {
  DeleteTaskUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTaskUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTaskUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteTaskUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteTaskUseCase create(Ref ref) {
    return deleteTaskUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTaskUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTaskUseCase>(value),
    );
  }
}

String _$deleteTaskUseCaseHash() => r'8a4d5135c118bae832ddf1ed4893c0f8593d3961';

@ProviderFor(toggleTaskUseCase)
final toggleTaskUseCaseProvider = ToggleTaskUseCaseProvider._();

final class ToggleTaskUseCaseProvider
    extends
        $FunctionalProvider<
          ToggleTaskUseCase,
          ToggleTaskUseCase,
          ToggleTaskUseCase
        >
    with $Provider<ToggleTaskUseCase> {
  ToggleTaskUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toggleTaskUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toggleTaskUseCaseHash();

  @$internal
  @override
  $ProviderElement<ToggleTaskUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ToggleTaskUseCase create(Ref ref) {
    return toggleTaskUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToggleTaskUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToggleTaskUseCase>(value),
    );
  }
}

String _$toggleTaskUseCaseHash() => r'e9fe8fc94b8b2e40f34cd3140cb644d03365ffed';
