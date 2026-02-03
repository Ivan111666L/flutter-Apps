# Documentación del Proyecto Flutter

Este documento proporciona una visión general de los conceptos clave de Flutter, explica cómo se construyeron las tres aplicaciones de ejemplo y detalla los pasos para ejecutarlas.

## 1. Conceptos Principales de Flutter

Flutter es el kit de herramientas de UI de Google para realizar aplicaciones compiladas nativamente, hermosas, y de escritorio desde una única base de código.

### Widgets
En Flutter, **todo es un Widget**. Desde un botón hasta el diseño de toda la pantalla.
- **StatelessWidget**: Widgets inmutables. Su apariencia no cambia una vez dibujados (ej. `Icon`, `Text`).
- **StatefulWidget**: Widgets que mantienen un estado mutable. Pueden redibujarse cuando cambian los datos (ej. `Checkbox`, `Slider`, o nuestro juego).

### Árbol de Widgets (Widget Tree)
Flutter construye la interfaz mediante una jerarquía de widgets. El método `build()` describe cómo debe verse la interfaz en función de la configuración y el estado actual.

### Gestión de Estado (State Management)
Es la forma en que los datos fluyen por la aplicación.
- **setState()**: La forma más básica. Le dice a Flutter que algo ha cambiado y debe reconstruir el widget.
- Para apps más grandes se usan soluciones como Provider, Riverpod, Bloc, etc.

### Hot Reload
Permite ver los cambios en el código casi instantáneamente sin perder el estado de la aplicación, acelerando enormemente el desarrollo.

---

## 2. Explicación de los Proyectos

### Proyecto 1: Galería de Imágenes (`simple_gallery`)
Una aplicación visual que consume imágenes de internet.

*   **Estructura**:
    *   `GridView.builder`: Crea una cuadrícula eficiente que solo renderiza los elementos visibles.
    *   `Image.network`: Carga imágenes desde una URL.
    *   `GestureDetector`: Detecta toques en las imágenes.
    *   `Navigator.push`: Maneja la navegación a la pantalla de detalle.
    *   `InteractiveViewer`: Permite hacer zoom y paneo en la imagen a pantalla completa.

### Proyecto 2: Cookie Clicker (`cookie_clicker`)
Un juego incremental que demuestra la interactividad y animaciones.

*   **Estructura**:
    *   **StatefulWidget**: Esencial para guardar el contador de galletas y mejoras.
    *   `setState()`: Se llama cada vez que se hace clic o el temporizador automático se ejecuta, actualizando la UI.
    *   `Timer.periodic`: Ejecuta código repetidamente (para el Auto Clicker).
    *   `AnimationController`: Controla la animación de "rebote" al hacer clic en la galleta.
    *   Lógica de juego: Variables simples (`_cookies`, `_cookiesPerClick`) que se modifican con reglas condicionales.

### Proyecto 3: App de Notas (`simple_notes`)
Una aplicación de productividad básica con operaciones CRUD (Crear, Leer, Actualizar, Borrar).

*   **Estructura**:
    *   **Modelo de Datos**: Una clase `Note` para estructurar la información.
    *   `ListView.builder`: Muestra la lista de notas desplazable.
    *   `Dismissible`: Permite deslizar un elemento de la lista para borrarlo.
    *   `FloatingActionButton`: El botón estándar para acciones principales (añadir nota).
    *   `TextField` y `TextEditingController`: Para capturar la entrada de texto del usuario.
    *   Paso de datos: Se envían datos entre pantallas usando el constructor de los Widgets y `Navigator.pop` para devolver resultados.

---

## 3. Cómo Ejecutar los Proyectos

### Requisitos Previos
*   Tener el **Flutter SDK** instalado y configurado en el PATH.
*   Un emulador (Android/iOS) corriendo o un dispositivo físico conectado.
*   (Opcional) Android Studio o VS Code configurados.

### Opción A: Desde la Terminal (Línea de Comandos)

1.  Abre tu terminal (PowerShell, CMD o Terminal).
2.  Navega a la carpeta del proyecto que deseas correr:
    ```bash
    cd c:\Users\Usuario\OneDrive\Documentos\flutter\simple_gallery
    # O cambia 'simple_gallery' por 'cookie_clicker' o 'simple_notes'
    ```
3.  Ejecuta el comando:
    ```bash
    flutter run
    ```
4.  Si tienes varios dispositivos, elige uno de la lista que aparecerá.

### Opción B: Desde Android Studio

1.  Abre Android Studio.
2.  Selecciona **File > Open** (Archivo > Abrir).
3.  Navega y selecciona la carpeta del proyecto (ej. `c:\Users\Usuario\OneDrive\Documentos\flutter\simple_notes`). **Importante**: Selecciona la carpeta raíz del proyecto específico, no la carpeta padre `flutter`.
4.  Espera a que el proyecto se sincronice (Gradle sync).
5.  Selecciona tu dispositivo en la barra superior.
6.  Haz clic en el botón verde de **Play** (Run).

### Solución de Problemas Comunes

*   **"Pub get failed"**: Ejecuta `flutter pub get` en la terminal dentro de la carpeta del proyecto para descargar las librerías.
*   **Dispositivo no encontrado**: Asegúrate de que tu emulador esté encendido o tu cable USB conectado correctamente. Ejecuta `flutter devices` para verificar.
