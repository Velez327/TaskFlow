import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/app/taskflow_app.dart';
import 'package:taskflow/features/tasks/data/local_task_repository.dart';
import 'package:taskflow/features/tasks/presentation/tasks_view_model.dart';

void main() {
  testWidgets('Completar una tarea actualiza detalle y lista', (tester) async {
    final viewModel = TasksViewModel(LocalTaskRepository());
    await viewModel.loadTasks();
    final task = viewModel.tasks.firstWhere((task) => !task.isCompleted);

    appRouter.go('/');

    await tester.pumpWidget(
      ChangeNotifierProvider<TasksViewModel>(
        create: (_) => viewModel,
        child: const TaskFlowApp(),
      ),
    );
    await tester.pumpAndSettle();

    final tile = find.widgetWithText(ListTile, task.title);
    await tester.scrollUntilVisible(tile, 200);
    await tester.tap(tile);
    await tester.pumpAndSettle();

    expect(find.text('Estado: pendiente'), findsOneWidget);

    await tester.tap(find.text('Marcar como completada'));
    await tester.pumpAndSettle();

    expect(find.text('Estado: completada'), findsOneWidget);
    expect(find.text('Marcar como pendiente'), findsOneWidget);

    appRouter.pop();
    await tester.pumpAndSettle();

    final updatedTile = find.widgetWithText(ListTile, task.title);
    expect(
      find.descendant(
        of: updatedTile,
        matching: find.byIcon(Icons.check_circle),
      ),
      findsOneWidget,
    );
  });
}
