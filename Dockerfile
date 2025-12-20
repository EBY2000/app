FROM python:3.11-slim

WORKDIR /app
COPY app.py /app
COPY test_app.py /app

RUN pip install pytest

CMD ["python", "app.py"]