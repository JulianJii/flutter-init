# 离线优先架构指南

本指南介绍如何在 Flutter Riverpod Clean Architecture 模板中使用离线优先架构，以创建在有无网络连接时都能无缝运行的应用。

## 目录

- [概述](#introduction)
- [核心组件](#key-components)
- [基本用法](#basic-usage)
- [冲突解决](#conflict-resolution)
- [UI 集成](#ui-integration)
- [高级用法](#advanced-usage)
- [最佳实践](#best-practices)

## 概述

离线优先的方法意味着设计你的应用在默认情况下无需网络连接即可工作，然后在连接可用时同步数据。这提供了几个好处：

- 在连接较差的区域提供更好的用户体验
- 更快的应用性能（无需等待网络响应）
- 减少数据使用
- 更具弹性的应用

## 核心组件

离线优先架构由几个核心组件组成：

- `OfflineSyncService`：管理离线数据和同步的核心服务
- `OfflineChange`：表示需要同步的待处理更改
- `ConflictResolutionStrategy`：解决本地和远程数据之间冲突的接口
- `OfflineStatusIndicator`：显示同步状态的 UI widget

## 基本用法

### 设置

模板中已设置好 providers。要使用它们，只需注入服务：

```dart
final offlineSyncService = ref.watch(offlineSyncServiceProvider);
```

### 排队更改

当进行需要同步到服务器的更改时：

```dart
// Create a new entity
await offlineSyncService.queueChange(
  entityType: 'task',
  operationType: OfflineOperationType.create,
  data: {
    'title': 'Buy groceries',
    'completed': false,
    'dueDate': DateTime.now().add(Duration(days: 1)).toIso8601String(),
  },
);

// Update an existing entity
await offlineSyncService.queueChange(
  entityType: 'task',
  entityId: '123',
  operationType: OfflineOperationType.update,
  data: {
    'completed': true,
  },
);

// Delete an entity
await offlineSyncService.queueChange(
  entityType: 'task',
  entityId: '123',
  operationType: OfflineOperationType.delete,
);
```

### 同步更改

当设备上线时会自动进行同步。你也可以手动触发：

```dart
await offlineSyncService.syncChanges();
```

### 检查同步状态

检查实体的状态：

```dart
final status = await offlineSyncService.getSyncStatus('task', '123');
if (status == SyncStatus.pending) {
  // This entity has pending changes
}
```

## 冲突解决

当同一实体在本地和远程都被修改时，可能会发生冲突。模板提供了三种策略：

### 客户端优先

本地更改覆盖服务器更改：

```dart
final clientWinsStrategy = ClientWinsStrategy();
```

### 服务器优先

服务器更改覆盖本地更改：

```dart
final serverWinsStrategy = ServerWinsStrategy();
```

### 智能合并

根据字段优先级智能合并更改：

```dart
final smartMergeStrategy = SmartMergeStrategy({
  'id': false, // Server wins for IDs
  'title': true, // Client wins for titles
  'updatedAt': true, // Client wins for update timestamps
});
```

### 自定义解决

手动解决冲突：

```dart
await offlineSyncService.resolveConflict(
  changeId, 
  mergedData, // Combined data after resolving conflicts
);
```

## UI 集成

### 显示同步状态

使用 `OfflineStatusIndicator` widget 显示当前同步状态：

```dart
AppBar(
  title: Text('My App'),
  actions: [
    OfflineStatusIndicator(),
  ],
)
```

### 显示待处理更改

在 UI 中显示待处理更改：

```dart
final pendingChanges = ref.watch(pendingChangesProvider);

return pendingChanges.when(
  data: (changes) {
    final entityChanges = changes.where(
      (c) => c.entityType == 'task'
    ).toList();
    
    return ListView.builder(
      itemCount: entityChanges.length,
      itemBuilder: (context, index) {
        final change = entityChanges[index];
        return ListTile(
          title: Text(change.data?['title'] ?? 'Untitled'),
          trailing: _buildSyncIndicator(change.status),
        );
      },
    );
  },
  loading: () => CircularProgressIndicator(),
  error: (_, __) => Text('Error loading changes'),
);
```

## 高级用法

### 与 Repository 模式结合

与你的 domain repositories 集成：

```dart
class TaskRepository {
  final OfflineSyncService _offlineSyncService;
  final ApiService _apiService;
  
  // In-memory cache for quick access
  final Map<String, Task> _localCache = {};
  
  Future<Task> createTask(Task task) async {
    // Store locally
    final newTask = task.copyWith(id: const Uuid().v4());
    _localCache[newTask.id] = newTask;
    
    // Queue for sync
    await _offlineSyncService.queueChange(
      entityType: 'task',
      entityId: newTask.id,
      operationType: OfflineOperationType.create,
      data: newTask.toJson(),
    );
    
    return newTask;
  }
  
  Future<List<Task>> getAllTasks() async {
    // Try to get from API if online
    if (await _offlineSyncService.isOnline()) {
      try {
        final remoteTasks = await _apiService.getTasks();
        _localCache.clear();
        for (final task in remoteTasks) {
          _localCache[task.id] = task;
        }
      } catch (_) {
        // Fall back to cache if API fails
      }
    }
    
    // Return cached tasks
    return _localCache.values.toList();
  }
}
```

### 后台同步

> **现状**：`lib/core/background/background_task_service.dart` 对 workmanager 做了真实封装，但**没有与离线同步接线**：回调只把"最后运行时间"写进 SharedPreferences，`main.dart` 也未调用 `initialize()`（目前仅 `examples/integrations/background_tasks_example_screen.dart` 在用）。要做真正的后台同步需自行补回调逻辑。

真实 API 形态（供参考）：

```dart
// 从 provider 取得服务（使用前需先 await initialize()）
final service = ref.read(backgroundTaskServiceProvider);
await service.initialize();
await service.registerPeriodicTask(
  uniqueName: 'sync',
  taskName: 'periodicSync',
  frequency: const Duration(minutes: 15), // Android 强制最低 15 分钟
);

// 任务体写在顶层入口点里（后台隔离区无法访问 provider 容器，只能读持久化数据）
@pragma('vm:entry-point')
void backgroundTaskCallbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    // 目前这里只持久化"运行过"的标记；真正的同步逻辑需要在此实现
    return true;
  });
}
```

## 最佳实践

1. **存储最小数据**：仅缓存离线功能所需的内容
2. **使用乐观更新**：立即更新 UI，然后在后台同步
3. **显示同步状态**：让用户了解更改的状态
4. **优雅处理冲突**：提供清晰的 UI 用于解决冲突
5. **添加时间戳**：包含创建/更新时间戳以帮助解决冲突
6. **优先同步**：优先同步关键操作
7. **节流同步**：不要每次更改都同步，批量处理操作
8. **测试离线场景**：定期在飞行模式下测试你的应用

通过遵循这些模式，你可以创建一个健壮的离线优先应用，无论连接状态如何都能提供无缝体验。
