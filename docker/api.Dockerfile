FROM python:3.11-slim

RUN useradd -m -u 1000 appuser

WORKDIR /app

COPY app/api/api.py .

RUN pip install --no-cache-dir flask prometheus-client

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

CMD ["python", "api.py"]