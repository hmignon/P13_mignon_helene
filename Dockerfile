FROM python:3
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY . /app/
CMD gunicorn oc_lettings_site.wsgi:application