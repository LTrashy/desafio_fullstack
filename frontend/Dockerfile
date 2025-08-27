FROM ghcr.io/cirruslabs/flutter:3.13.9

# Crear usuario no-root
RUN useradd -ms /bin/bash flutteruser

# Dar permisos al SDK para este usuario
RUN chown -R flutteruser:flutteruser /sdks/flutter

WORKDIR /app
USER flutteruser

# Evitar error de "dubious ownership"
RUN git config --global --add safe.directory /sdks/flutter

# Copiar dependencias y descargar
COPY --chown=flutteruser:flutteruser pubspec.* ./
RUN flutter pub get || true

COPY --chown=flutteruser:flutteruser . .

CMD ["flutter", "run", "-d", "web-server", "--web-port=8080", "--web-hostname=0.0.0.0"]
