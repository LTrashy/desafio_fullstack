# Proyecto Full Stack: Django + Flutter

Este proyecto es una solución full stack que integra un **backend en Django** y un **frontend en Flutter**, diseñados para ser ejecutados en un entorno de desarrollo usando **Docker** y **Docker Compose**.

El servicio de backend ha sido configurado para simular la obtención de datos de eventos, utilizando **seeders de prueba**. Esto te permite tener datos de prueba al iniciar el servicio, ideal para el desarrollo y la validación inicial del frontend sin necesidad de un set de datos real.

---

## Requisitos

Para levantar y gestionar el proyecto, necesitas tener instaladas las siguientes herramientas:

* **Docker**: El motor principal para los contenedores.
* **Docker Compose**: Para la orquestación y gestión de los múltiples servicios (Django y Flutter).
* **Make**: (Opcional) Una herramienta para simplificar la ejecución de los comandos de Docker.

---

## Levantar el proyecto

Puedes levantar el proyecto de dos maneras: usando los comandos de `make` para mayor simplicidad, o directamente con `docker-compose`.

### Con Comandos `make`

El proyecto incluye un `Makefile` con comandos predefinidos para agilizar el desarrollo:

| Comando | Descripción |
| :--- | :--- |
| `make up` | Levanta los contenedores de Docker y reconstruye las imágenes si es necesario. |
| `make down` | Detiene los contenedores y elimina los volúmenes asociados. |
| `make test` | Ejecuta los tests del backend de Django dentro del contenedor del servicio `web`. |

### Con Comandos `docker-compose`

Si prefieres no usar `make`, aquí están los comandos equivalentes:

* Para levantar los contenedores:
    ```bash
    sudo docker compose up --build
    ```
* Para detener y eliminar los contenedores y sus volúmenes:
    ```bash
    sudo docker compose down -v
    ```
* Para ejecutar los tests del backend:
    ```bash
    sudo docker compose run --rm web pytest -v
    ```

---

## Acceso y Pruebas

Una vez que los contenedores estén en funcionamiento, puedes interactuar con el backend y el frontend usando las siguientes rutas:

* **Backend Django**: http://localhost:8000
* **Frontend Flutter (Web)**: http://localhost:8080

Para probar los endpoints de la API, usa la siguiente ruta:

* **API de eventos**: http://localhost:8000/api/events/

Puedes utilizar una herramienta como **Postman** para enviar solicitudes y validar el funcionamiento de los endpoints. La colección de Postman estará disponible después de tener el servicio corriendo, permitiéndote probar `GET /events` y `GET /events/{id}` de manera sencilla.