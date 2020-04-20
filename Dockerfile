FROM python:3.5-alpine

WORKDIR /app
COPY source_code/ /app


ENTRYPOINT ["python", "server.py"]
