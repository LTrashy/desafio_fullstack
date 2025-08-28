FROM ghcr.io/cirruslabs/flutter:3.13.9

RUN useradd -ms /bin/bash flutteruser

RUN chown -R flutteruser:flutteruser /sdks/flutter

WORKDIR /app
USER flutteruser

RUN git config --global --add safe.directory /sdks/flutter

COPY --chown=flutteruser:flutteruser pubspec.* ./
RUN flutter pub get || true

COPY --chown=flutteruser:flutteruser . .

CMD ["flutter", "run", "-d", "web-server", "--web-port=8080", "--web-hostname=0.0.0.0"]
