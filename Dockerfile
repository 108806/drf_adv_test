FROM python:3.9.5-slim-buster
ENV PYTHONUNBUFFERED=1

RUN pip install --upgrade pip

RUN apt update && apt upgrade -y
RUN apt install wget gnupg2 lsb-release -y

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt \
$(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt clean
RUN apt update
RUN apt install postgresql-13 gcc-7 libc-dev -y

#TODO: Remove at final ver:
# RUN apk add bash
# RUN apk add bash-completion

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN adduser user
RUN mkdir /app
COPY ./app /app
RUN chown user /app 
WORKDIR /app

USER user
