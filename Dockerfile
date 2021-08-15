FROM python:3.9.5-alpine
#LABEL "https://github.com/108806"
ENV PYTHONUNBUFFERED=1

RUN pip install --upgrade pip

RUN apk add --update --no-cache postgresql libpg
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev 
RUN apk del .tmp-build-deps
RUN echo gcc-7 --version
#TODO: Remove at final ver:
# RUN apk add bash
# RUN apk add bash-completion

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN adduser -D user
RUN mkdir /app
COPY ./app /app
RUN chown user /app 
WORKDIR /app

USER user
