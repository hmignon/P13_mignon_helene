<!--suppress HtmlUnknownAnchorTarget, HtmlDeprecatedAttribute -->
<p align="center">
  <img src="img/logo_light.png#gh-light-mode-only" alt="logo-light" />
  <img src="img/logo_dark.png#gh-dark-mode-only" alt="logo-dark" />
</p>

<p align="center">
  <a href="https://www.python.org">
    <img src="https://img.shields.io/badge/Python-3.6+-3776AB?style=flat&logo=python&logoColor=white" alt="python-badge">
  </a>
  <a href="https://www.djangoproject.com">
    <img src="https://img.shields.io/badge/Django-3.0-092E20?style=flat&logo=django&logoColor=white" alt="django-badge">
  </a>
  <a href="https://app.circleci.com/pipelines/github/hmignon/Python-OC-Lettings-FR">
    <img src="https://badgen.net/circleci/github/hmignon/Python-OC-Lettings-FR/master?icon=circleci" alt="circleci-badge">
  </a>
  <a href="https://www.docker.com">
    <img src="https://img.shields.io/badge/Docker-v20.10.13-2CA5E0?style=flat&logo=docker&logoColor=white" alt="docker-badge">
  </a>
  <a href="https://oc-lettings-mignonh.herokuapp.com/">
    <img src="https://img.shields.io/badge/Heroku-oc--lettings--mignonh-430098?style=flat&logo=heroku&logoColor=white" alt="heroku-badge">
  </a>
</p>

---

**![fr-flag](https://flagcdn.com/16x12/fr.png) [Documentation en français](README.fr.md)**

---
## Contents
#### 1. [About the project](#objectifs)
#### 2. [Local development](#dev)
#### 3. [Deployment](#deploiement)

---

<a name="objectifs"></a>
# About the project

**OpenClassrooms Python Developer Project #13: Scale a Django Application Using Modular Architecture**

_Tested on Windows 10 - Python 3.9.5 - Django 3.0_

Several areas of the **OC Lettings** app have been improved from 
the [Python-OC-Lettings-FR](https://github.com/OpenClassrooms-Student-Center/Python-OC-Lettings-FR) project:

1) Technical debt refactor

   - Fix linting errors
   - Fix model name pluralization across the admin site


2) Modular architecture refactor

   - Create 3 new apps: *lettings*, *profiles* and *home* to ensure the separation of their dedicated features
   - Convert *oc_lettings_site* to a Django project
   - Write a test suite


3) CI/CD pipeline using [CircleCI](https://circleci.com) and deployment to [Heroku](https://www.heroku.com)

   1) *Build and test*: run linting and test suite (for all branches)
   2) *Containerization*: build a [Docker](https://www.docker.com) image and push it to DockerHub (triggers if step i. passes, for *master* branch only)
   3) *Deployment*: deploy the site using Heroku (triggers if step ii. passes, for *master* branch only)


4) Application and error monitoring via [Sentry](https://sentry.io/welcome/)

### Quick access links:
- **[CircleCI pipeline for this project](https://app.circleci.com/pipelines/github/hmignon/Python-OC-Lettings-FR)**
- **[Available Docker images](https://hub.docker.com/r/mignonh/oc_lettings/tags)**
- **[Deployed app on Heroku](https://oc-lettings-mignonh.herokuapp.com)**
- **[Error example on Sentry](https://sentry.io/share/issue/0d3464c341cb4269809496e18d7c78aa/)**

<a name="dev"></a>
# Local development

## Prerequisites

- GitHub account with read access to this repository
- Git CLI
- SQLite3 CLI
- Python interpreter, version 3.6 or higher

Throughout the local development documentation, it is assumed that the `python` command in your OS shell runs 
the above-mentioned Python interpreter (unless a virtual environment is activated).

## Clone the repository

- `cd /path/to/put/project/in`
- `git clone https://github.com/hmignon/Python-OC-Lettings-FR.git`

## Create the virtual environment

- `cd /path/to/Python-OC-Lettings-FR`
- `python -m venv venv`
- `apt-get install python3-venv` (If previous stop raises package not found error on Ubuntu)
- Activate the environment `source venv/bin/activate` (MacOS and Linux) or `venv\Scripts\activate` (Windows)
- Check if the `python` command now runs the Python interpreter in the virtual environment
`which python` (MacOS and Linux) or `(Get-Command python).Path` (Windows)
- Ensure the Python interpreter version is 3.6 or higher `python --version`
- Ensure the `pip` command runs the pip executable within the virtual environment, `which pip` (MacOS and Linux) or `(Get-Command pip).Path` (Windows)
- To deactivate the environment, `deactivate`

<a name="env"></a>
## Environment variables : *.env* file
To generate a *.env* file template, run `python setup_env.py`.

Example of a generated *.env* file:

```
DJANGO_SECRET_KEY=j%yuc7l_wwz5t8d=g)zxh6ol@$7*lwx6n0p)(k$dewlr0hf2u-
SENTRY_DSN= 
DEBUG=
```

The file can be edited by adding:
- the Sentry project URL after `SENTRY_DSN=` (empty by default, see [Sentry](#sentry))
- `DEBUG=0` (*False*) or `DEBUG=1` (*True*) (*False* by default)

## Run the site

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate` (MacOS and Linux) or `venv\Scripts\activate` (Windows)
- `pip install --requirement requirements.txt`
- Migrate database `python manage.py migrate`
- Load initial data `python manage.py loaddata data.json`
- Run server `python manage.py runserver`
- Go to http://127.0.0.1:8000/ in a web browser.
- Check if the site works properly by browsing (you should see several profiles and lettings).

## Linting

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate` (MacOS and Linux) or `venv\Scripts\activate` (Windows)
- `flake8`

## Unit tests

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate` (MacOS and Linux) or `venv\Scripts\activate` (Windows)
- `pytest`

## Database

- `cd /path/to/Python-OC-Lettings-FR`
- Open a shell session `sqlite3`
- Connect to the database `.open oc-lettings-site.sqlite3`
- View tables in the database `.tables`
- View columns in the profiles table, `pragma table_info(oc_lettings_site_profile);`
- Run a query on the profiles table, `select user_id, favorite_city from oc_lettings_site_profile where favorite_city like 'B%';`
- `.quit` to exit

## Admin panel

- Go to http://127.0.0.1:8000/admin/
- Login with username `admin`, password `Abc1234!`

## Docker

### Build a Docker image to run the app locally
- Download and install [Docker](https://docs.docker.com/get-docker/)
- Change to the project directory `cd /path/to/Python-OC-Lettings-FR`
- Make sure that the *.env* file has been previously created (see [Environment variables](#env))
- Build image `docker build -t <image-name> .` with the desired image name
- Use `docker run --rm -p 8080:8080 --env-file .env <image-name>` command, replacing *image-name* with the one built before

You can access the app in any web browser at http://127.0.0.1:8080/


### Pull an existing image from DockerHub to run the app locally
- Download and install [Docker](https://docs.docker.com/get-docker/)
- Go to the Docker repository: https://hub.docker.com/r/mignonh/oc_lettings/tags
- Copy the tag you would like to use (preferably the most recent)
- Use `docker run --rm -p 8080:8080 mignonh/oc_lettings:<image-tag>` command, replacing *image-tag* with the desired tag

You can access the app in any web browser at http://127.0.0.1:8080/


<a name="deploiement"></a>
# Deployment

## Prerequisites
In order to perform the deployment and continuous integration of the app, the following accounts are required:

- [GitHub](https://github.com/) account
- [CircleCI](https://circleci.com) account (linked to GitHub account)
- [Docker](https://www.docker.com) account
- [Heroku](https://www.heroku.com) account
- [Sentry](https://sentry.io/welcome/) account


## Summary
The deployment of the app is automated by the CircleCI pipeline.
When updates are pushed to the GitHub repository, the pipeline triggers the test suite and code linting for **all project branches**.
If updates are made on the **master branch**, and **if and only if** the tests and linting pass, the workflow:
- Builds a Docker image and pushes it to DockerHub
- **If and only if** the previous step passes, deploys the app on Heroku

## Configuration

### CircleCI

After cloning the project, setting up the local virtual environment (see [Local development](#dev)) and creating the required accounts,
set up a new project on CircleCI via *"Set Up Project"*.
Select the **master** branch as a source for the *.circleci/config.yml* file.

<p align="center">
    <img src="img/cirleci_setup.gif" alt="circleci-setup" />
    <em>CircleCI Configuration</em>
</p>

To run the CircleCI pipeline properly, set up the following environment variables (*Project Settings* > *Environment Variables*):

| CircleCI variable | Description                                                                                                                                                                                              |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| DJANGO_SECRET_KEY | Django secret key: generate a random key with [Djecrety](https://djecrety.ir) or with <br/> `python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'` |
| SENTRY_DSN        | Sentry project URL (see [Sentry](#sentry))                                                                                                                                                               |
| DOCKER_LOGIN      | Docker account username                                                                                                                                                                                  |
| DOCKER_PASSWORD   | Docker account password                                                                                                                                                                                  |
| DOCKER_REPO       | DockerHub repository name                                                                                                                                                                                |
| HEROKU_APP_NAME   | Heroku app name: the deployed app will be accessed via `https://<HEROKU_APP_NAME>.herokuapp.com/`                                                                                                        |
| HEROKU_TOKEN      | Heroku token, can be found in account settings (*Heroku API Key*)                                                                                                                                        |


### Docker

Create a DockerHub repository. The repository name must match the *DOCKER_REPO* variable set in CircleCI.

The CircleCI workflow will build and push the app image in the DockerHub repository.
All images are tagged with the CircleCI commit “hash” (*$CIRCLE_SHA1*).

### Heroku
To create an app in your Heroku account, several methods are available:

- **Method 1:** Create the app manually on the Heroku website. The name of the app must match the *HEROKU_APP_NAME* variable set in CircleCI. 
Install the [Heroku Postgres](https://elements.heroku.com/addons/heroku-postgresql) addon for the app.


- **Method 2:** Install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#install-the-heroku-cli). Use the 
command `heroku apps:create <app-name> --region eu --addons=heroku-postgresql` with the desired name for the app. 
The name of the app must match the *HEROKU_APP_NAME* variable set in CircleCI.


- **Method 3:** Edit the CircleCI pipeline configuration for the first commit > add one the following command lines to *[.circleci/config.yml](.circleci/config.yml)* 
whether you want to:

  - Create a new app from scratch with the Heroku Postgres addon:

   `HEROKU_API_KEY=${HEROKU_TOKEN} heroku apps:create $HEROKU_APP_NAME --region eu --addons=heroku-postgresql`

  - Install the Heroku Postgres addon to an existing app: 

   `HEROKU_API_KEY=${HEROKU_TOKEN} heroku addons:create heroku-postgresql -a $HEROKU_APP_NAME --confirm $HEROKU_APP_NAME`

   **Note: Leave the config file unchanged if your app already exists with the Heroku Postgres addon.**

   The first CircleCI workflow will create the app / install the addon automatically.
**Remember to remove the command line added to *[.circleci/config.yml](.circleci/config.yml)* for future commits.**


<a name="sentry"></a>
### Sentry

After creating a [Sentry](https://sentry.io/welcome/) account, set up a Django project. 
The SENTRY_DSN can be found under *Project Settings > Client Keys (DSN)*. Remember to add this variable to CircleCI and your *.env* file.

<p align="center">
    <img src="img/sentry_dashboard.png" alt="circleci-setup" />
    <em>Sentry Dashboard</em>
</p>

Sentry error logging can be tested via the `/sentry-debug/` endpoint, either locally (with `runserver` or from a Docker image) or on the deployed app at `https://<HEROKU_APP_NAME>.herokuapp.com/sentry-debug/`. 
The `/sentry-debug/` endpoint raises a *ZeroDivisionError* ([example](https://sentry.io/share/issue/0d3464c341cb4269809496e18d7c78aa/)).