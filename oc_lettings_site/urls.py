from django.contrib import admin
from django.urls import path, include

from home import views

urlpatterns = [
    path('', views.index, name='lettings_index'),
    path('lettings/', include('lettings.urls')),
    path('profiles/', include('profiles.urls')),
    path('admin/', admin.site.urls),
]
