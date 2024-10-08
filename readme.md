# Marco Teórico

Elaborado por:
1. Iván Jared Álvarez De Uña
2. Kevin Eduardo Peralta Diaz
3. Tania Lizeth Tavera Alanis

### Módulo `gen_server`

El módulo `chat_server` implementa el comportamiento de un `gen_server`, un patrón estándar en Erlang para construir servidores genéricos.

Un `gen_server` encapsula la gestión de estado, comunicación síncrona (con `call`) y asíncrona (con `cast`), y el manejo de eventos externos mediante callbacks.

El uso de `gen_server` simplifica la implementación de servidores concurrentes al proporcionar una estructura clara para manejar eventos.
- gen_server:call/2: Esta función permite realizar una llamada síncrona, es decir, el proceso solicitante espera una respuesta antes de continuar. Se utiliza, por ejemplo, en el registro o eliminación de usuarios.
- gen_server:cast/2: La función cast realiza una llamada asíncrona. En este caso, el proceso solicitante envía un mensaje sin esperar una respuesta. Esto es útil para acciones como enviar un mensaje de chat desde un cliente al servidor, donde no se necesita respuesta inmediata.

### Gestión con `global`
Los módulos hacen uso del sistema de nombres globales de Erlang para que los clientes puedan encontrar y comunicarse con el servidor de chat desde cualquier nodo en un sistema distribuido. La función `global:register_name/2` asegura que el servidor esté registrado bajo un nombre conocido globalmente, lo que permite a los clientes referirse a este servidor utilizando `{global, chat_server}` en sus llamadas.

### Estado del Servidor (`state`)
El servidor utiliza un registro definido como `#state{}` para gestionar tanto la lista de usuarios conectados como los mensajes. Este registro permite llevar un control estructurado de las entidades importantes del sistema (usuarios y mensajes), asegurando una gestión eficiente y consistente del estado.

- La función `handle_call/3` actualiza el estado del servidor según las acciones solicitadas (agregar/eliminar usuarios).
- `handle_cast/2` añade nuevos mensajes al historial de chat y los muestra en la consola del servidor.

### Características
- **Distribución y Nodosa**: Erlang facilita la creación y comunicación entre procesos en diferentes nodos de una red distribuida, permitiendo la escalabilidad horizontal de sistemas como servidores de chat.

- **Concurrencia y Paralelismo**: Cada cliente y servidor en Erlang es un proceso independiente. Esto permite manejar múltiples usuarios simultáneamente, evitando bloqueos y optimizando el rendimiento.

- **Tolerancia a Fallos**: Erlang está diseñado para sistemas robustos, donde los procesos fallidos pueden ser reiniciados automáticamente sin afectar al sistema global, manteniendo la estabilidad y continuidad del servicio.

### Experiencias y dificultades

- **No es un lenguaje muy popular**.

- **Variaciones entre versiones**.

- **Sinatxis particular**.
