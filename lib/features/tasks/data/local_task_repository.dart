import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Preparar exposición de auditoría',
      description: 'Revisar las diapositivas asignadas y practicar una intervención de un minuto.',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Resumir El Proyecto Fénix',
      description: 'Escribir un resumen del primer capítulo y preparar respuestas para la clase.',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Configurar Flutter y Android',
      description: 'Instalar las herramientas y comprobar que TaskFlow se ejecuta en el teléfono.',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 4,
      title: 'Documentar la práctica de servidores',
      description: 'Organizar las capturas y explicar la configuración de los servicios instalados.',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 5,
      title: 'Revisar la entrega de TaskFlow',
      description: 'Comprobar el README, las capturas y el análisis antes de subir el avance.',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
  ];

  @override
  Future<List<Task>> getTasks() async => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
  }
}
