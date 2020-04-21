FROM pincher95/pymysql-flask:latest

WORKDIR /app
COPY source_code/ /app


ENTRYPOINT ["python", "server.py"]
