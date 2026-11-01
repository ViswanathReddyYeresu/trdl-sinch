FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1

WORKDIR /srv

RUN useradd --uid 10001 --no-create-home appuser

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY app ./app

USER 10001
EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "2", "--graceful-timeout", "20", "--access-logfile", "-", "app.app:create_app()"]
