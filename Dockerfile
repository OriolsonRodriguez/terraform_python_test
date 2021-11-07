FROM alpine:3.14

RUN apk add --no-cache python3-dev \
    && pip install --upgrade pip

WORKDIR /app

COPY ./src /app

RUN pip3 --no-cache-dir install -r requirements.txt

CMD ["python3", "-m", "flask", "run", "--port 8888"]