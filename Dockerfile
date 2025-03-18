# syntax=docker/dockerfile:1.4

FROM python:3.9-alpine3.13
LABEL maintainer="Oliver Tepper"
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
EXPOSE 8000
WORKDIR /app
COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user
