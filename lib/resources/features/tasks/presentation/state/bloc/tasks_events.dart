part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvents {}

class PaginatedFetchTasks extends TasksEvents {}

class AddTask extends TasksEvents {
  final TaskModel task;

  AddTask({required this.task});
}

class DeleteTask extends TasksEvents {
  final int id;
  final int index;

  DeleteTask({
    required this.id,
    required this.index,
  });
}

class NoImages extends TasksEvents {}

class UploadOfflineTasks extends TasksEvents {}

class DeleteOfflineTasks extends TasksEvents {}

class SerializationEvent extends TasksEvents {}

class TasksLogout extends TasksEvents {}
