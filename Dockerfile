FROM python:3-alpine
WORKDIR .
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
COPY . .
RUN pip install --upgrade pip \
  && pip install -r requirements.txt \
  && python manage.py collectstatic --noinput --clear
CMD gunicorn oc_lettings_site.wsgi:application