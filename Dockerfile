FROM python:3.9.6-alpine
#LABEL "https://github.com/108806"
ENV PYTHONUNBUFFERED=1


COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN adduser -D user
RUN mkdir /app
COPY ./app /app
RUN chown user /app 
WORKDIR /app

USER user
