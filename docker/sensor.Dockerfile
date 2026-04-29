FROM python:3.11-slim

RUN useradd -m -u 1000 appuser

WORKDIR /app

COPY app/sensor/sensor.py .

RUN pip install --no-cache-dir requests

RUN chown -R appuser:appuser /app

USER appuser

CMD ["python", "sensor.py"]