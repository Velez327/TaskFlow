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

## API de tareas

TaskFlow consulta tareas de prueba de JSONPlaceholder mediante Dio.

### Endpoint y usuario elegido

- Método HTTP: GET.
- URL base: https://jsonplaceholder.typicode.com
- Recurso: /todos
- Parámetro de consulta: userId=2.
- URL exacta: https://jsonplaceholder.typicode.com/todos?userId=2

Elegí el usuario 2 para comprobar que cambiar el parámetro modifica
las tareas obtenidas. Su identificador está definido en la constante
userId de TaskApiService.

### Campos recibidos y conversión

| Campo recibido | Tipo | Propiedad en Task |
|---|---|---|
| userId | int | userId |
| id | int | id |
| title | String | title |
| completed | bool | isCompleted |

La API no entrega description ni priority. TaskFlow completa esos campos
con los valores "Sin descripción (API)" y "Sin prioridad (API)".
Estos textos se definen en la aplicación.

### Recorrido de los datos

TaskApiService consulta el endpoint mediante Dio y convierte la respuesta
en objetos Task con Task.fromJson.

RemoteTaskRepository obtiene las tareas del servicio y conserva una copia
en memoria. TasksViewModel espera el resultado mediante Future,
async y await, y notifica a las pantallas mediante notifyListeners.

### Cambios de estado

Marcar una tarea como completada o pendiente actualiza únicamente la copia
en memoria. Esta acción no envía cambios al servidor. Al reiniciar la
aplicación, se consultan nuevamente los estados originales de la API.

Las cinco tareas propias de la sesión anterior se conservan en
LocalTaskRepository como respaldo local.

### Comprobaciones realizadas

- La consulta del usuario 1 devuelve HTTP 200.
- El listado muestra las tareas remotas y el detalle indica Usuario: 2.
- Un cambio de estado aparece tanto en el listado como en el detalle.
- Al reiniciar la aplicación, se recupera el estado remoto.
- Sin internet aparece "No se pudieron cargar las tareas.".
- Al recuperar la conexión y reiniciar, vuelve a cargarse el listado.


Se actualizó TasksViewModel para controlar las peticiones asíncronas, evitar solicitudes simultáneas y diferenciar los resultados de la API.

Se modificó TaskListScreen para mostrar mensajes y acciones según el estado de la consulta.

Carga: se presenta un CircularProgressIndicator mientras se obtienen las tareas.

Éxito: se muestran las tareas remotas mediante tarjetas que permiten acceder al detalle.

Vacío: se presenta el mensaje "Todavía no hay tareas para mostrar." y el botón Actualizar.

Error: se muestra el mensaje "No se pudieron cargar las tareas." y el botón Reintentar.

También se incorporó RefreshIndicator para actualizar la lista deslizando hacia abajo.

Pruebas de funcionamiento

Estado de éxito: se configuró userId=1 en TaskApiService y se ejecutó la aplicación con conexión a internet. La lista mostró las tareas recibidas desde JSONPlaceholder.

Estado de carga: se pulsó el botón Actualizar y se observó el indicador circular durante la solicitud.

Estado vacío: se modificó temporalmente userId a 9999 y se reinició la aplicación. La API devolvió una lista sin elementos y TaskFlow mostró el mensaje correspondiente junto con el botón Actualizar.

Estado de error: se desactivó la conexión a internet del dispositivo y se pulsó Actualizar. La aplicación mostró el mensaje de error y el botón Reintentar.

Prueba de reintento: se restableció la conexión a internet y se pulsó Reintentar. Las tareas volvieron a aparecer sin necesidad de reiniciar TaskFlow.

Al finalizar las pruebas, se restauró userId=1.

Resultado

TaskFlow permite identificar y mostrar los cuatro estados de una petición asíncrona. Además, conserva la consulta remota, la navegación al detalle y la opción de marcar tareas como completadas localmente.

La actualización de la lista vuelve a consultar la API, por lo que las modificaciones locales del estado de las tareas pueden reemplazarse por los valores remotos.

Evidencias

Se realizaron las pruebas correspondientes a los estados de éxito, vacío, error, reintento y carga.