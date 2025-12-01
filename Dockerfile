FROM python:3.11-slim

WORKDIR /app

# Установка зависимостей
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копирование приложения
COPY . .

# Заглушки для сборки
ENV DJANGO_SETTINGS_MODULE=django_app.settings
ENV DB_NAME=dummy
ENV DB_USER=dummy
ENV DB_PASSWORD=dummy
ENV DB_HOST=dummy
ENV SECRET_KEY=django-insecure-build-key-123

# Сбор статики
RUN python manage.py collectstatic --noinput

# Очистка
ENV DB_NAME=
ENV DB_USER=
ENV DB_PASSWORD=
ENV DB_HOST=

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "django_app.wsgi:application"]
EXPOSE 8000
