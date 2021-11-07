FROM alpine:3.14

RUN apk add --no-cache python3-dev py3-pip

WORKDIR /app

COPY . /app

RUN pip3 --no-cache-dir install -r requirements.txt

EXPOSE 4000

CMD ["python3", "app.py"]