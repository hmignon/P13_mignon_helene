FROM python:3
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SECRET_KEY "$DJANGO_SECRET_KEY"
ENV SENTRY_DSN "$SENTRY_DSN"
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
COPY . /app/
RUN python manage.py collectstatic --noinput --clear
CMD gunicorn oc_lettings_site.wsgi:application