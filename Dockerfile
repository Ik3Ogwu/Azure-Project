FROM python:3.9-slim

WORKDIR /app

COPY F1QualiResults.py .
COPY config.ini .

CMD ["python", "F1QualiResults.py"]
