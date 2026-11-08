import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/main.dart';

void main() {
  testWidgets('TaskFlow muestra el listado y una tarea completada', (
    tester,
  ) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('Mis tareas'), findsOneWidget);

    final completedTask = demoTasks.firstWhere((task) => task.isCompleted);
    final card = find.widgetWithText(TaskCard, completedTask.title);

    await tester.scrollUntilVisible(card, 200);

    expect(card, findsOneWidget);
    expect(
      find.descendant(of: card, matching: find.byIcon(Icons.check_circle)),
      findsOneWidget,
    );
  });
}
