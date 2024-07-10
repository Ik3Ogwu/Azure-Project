FROM python:3.9-slim

WORKDIR /app

RUN pip install --no-cache-dir requests pandas openpyxl

COPY F1QualiResults.py .
COPY config.ini .

CMD ["python", "F1QualiResults.py"]
