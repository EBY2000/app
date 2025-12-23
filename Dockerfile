# ---------- test stage ----------
FROM python:3.11-slim AS test

WORKDIR /app
COPY app.py test_app.py ./

RUN pip install pytest

CMD ["pytest", "test_app.py"]

# ---------- runtime stage ----------
FROM python:3.11-slim

WORKDIR /app
COPY app.py ./

EXPOSE 8081
CMD ["python", "app.py"]