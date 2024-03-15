from django.urls import path
from . import views

urlpatterns = [
    path("create/", views.CreateTask.as_view(), name="create"),
    path("list/", views.ListTask.as_view(), name="list"),
]
