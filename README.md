# taskflow

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Alcance de TaskFlow

TaskFlow permite organizar actividades académicas, consultar sus detalles
y reconocer cuáles siguen pendientes.

El usuario objetivo es un estudiante universitario que organiza
exposiciones, lecturas, prácticas e informes semanales.

### Actividades de esta versión

- Preparar la exposición de auditoría.
- Resumir el primer capítulo de El Proyecto Fénix.
- Configurar Flutter y Android, registrada como completada.
- Documentar la práctica de servidores.
- Revisar la entrega de TaskFlow.

### Historias de usuario y criterios de aceptación

1. Como estudiante, quiero listar mis actividades académicas para
   identificar qué debo realizar.
   - Criterio: la lista muestra las cinco tareas con título, prioridad
     e icono de estado.

2. Como estudiante, quiero consultar una tarea para conocer sus instrucciones.
   - Criterio: al tocar una tarjeta, el detalle muestra el título,
     la descripción, la prioridad, el estado y el usuario correspondientes.

3. Como estudiante, quiero crear tareas para registrar nuevas entregas.
   - Criterio: al guardar un formulario con título y descripción no vacíos
     y una prioridad válida, la nueva tarea aparece en la lista.

4. Como estudiante, quiero editar una tarea para corregir su información.
   - Criterio: al guardar una nueva descripción o prioridad, el cambio
     aparece tanto en el listado como en el detalle.

5. Como estudiante, quiero eliminar tareas que ya no necesito conservar.
   - Criterio: después de confirmar la eliminación, la tarea desaparece
     del listado y su id deja de devolver un detalle válido.

Las historias 1 y 2 funcionan con datos locales. Las historias 3, 4 y 5
se implementarán en sesiones posteriores.

### Requisitos funcionales

- RF01: mostrar el listado de tareas.
- RF02: consultar una tarea mediante su id.
- RF03: permitir crear una tarea válida.
- RF04: permitir editar los datos de una tarea.
- RF05: permitir eliminar una tarea después de una confirmación.

### Modelo de datos

La entidad Task se define en lib/task.dart.

| Propiedad | Tipo | Regla |
|---|---|---|
| id | int | Identificador único de la tarea |
| title | String | Título breve y no vacío |
| description | String | Instrucciones de la actividad |
| priority | String | Alta, Media o Baja |
| isCompleted | bool | true para completada y false para pendiente |
| userId | int | Identificador del propietario; se usa 1 en esta práctica |

### Pantallas previstas

| Pantalla | Contenido y acciones |
|---|---|
| Lista | Tarjetas con título, prioridad y estado; acceso al detalle y futura acción para crear |
| Detalle | Descripción, prioridad, estado y usuario; regreso al listado y futuras acciones de edición y eliminación |
| Formulario futuro | Campos de título, descripción y prioridad para crear o editar una tarea |

### Requisitos no funcionales

- RNF01: los títulos, estados y mensajes deben estar escritos en español
  y describir claramente su función.
- RNF02: una ruta con un id inexistente o no numérico debe mostrar
  “No se encontró esta tarea.” sin cerrar la aplicación.
- RNF03: el listado debe permitir desplazarse hasta todas las tareas
  cuando el contenido supere el alto de la pantalla.

### Contrato de API previsto

| Método | Endpoint | Operación |
|---|---|---|
| GET | /tasks | Obtener la lista de tareas |
| GET | /tasks/:id | Consultar una tarea por su id |
| POST | /tasks | Crear una tarea |
| PATCH | /tasks/:id | Modificar parcialmente una tarea |
| DELETE | /tasks/:id | Eliminar una tarea |

La API se elegirá en una sesión posterior. Actualmente la aplicación
consulta demoTasks, una lista local.

Ejemplo del objeto JSON esperado al consultar una tarea:

```json
{
  "id": 1,
  "title": "Preparar exposición de auditoría",
  "description": "Revisar las diapositivas asignadas y practicar una intervención de un minuto.",
  "priority": "Alta",
  "isCompleted": false,
  "userId": 1
}
```

Task.fromJson convierte este objeto en una instancia de Task.
Las claves y los tipos del JSON deben coincidir con el modelo.