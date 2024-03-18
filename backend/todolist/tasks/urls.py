from django.urls import path
from . import views

urlpatterns = [
    path("create/", views.CreateTask.as_view(), name="create"),
    path("list/", views.ListTask.as_view(), name="list"),
    path("delete/<int:task_id>/",views.DeleteTask.as_view(), name="delete"),
    path("complete/<int:task_id>/",views.CompleteTask.as_view(), name="complete"),
]
