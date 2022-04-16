FROM python:3
WORKDIR .
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
COPY . .
RUN python manage.py collectstatic --noinput --clear
CMD gunicorn oc_lettings_site.wsgi:application