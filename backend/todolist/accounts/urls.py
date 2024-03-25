from django.urls import path
from . import views

urlpatterns = [
    path("register/", views.UserRegistration.as_view(), name="register"),
    path("login/", views.Login.as_view(), name="login"),
    path("detail/",views.GetUserDetails.as_view(),name="details"),
]
