# ---------- test stage ----------
FROM python:3.11-slim AS test

WORKDIR /app
COPY app.py test_app.py ./

RUN pip install --no-cache-dir pytest

CMD ["pytest", "test_app.py"]

# ---------- runtime stage ----------
FROM python:3.11-slim

# создаём не-root пользователя
RUN useradd -m appuser

WORKDIR /app

# копируем только нужное
COPY app.py ./

# меняем владельца файлов
RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 8080

# healthcheck (предполагаем, что в app.py есть /health)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8081/health')" || exit 1


CMD ["python", "app.py"]
