from django.urls import path

from . import views

urlpatterns = [

path("profile/", views.driver_profile),
path("documents/", views.driver_documents),
#path("login/", views.LoginAPIView.as_view(), name="driver-login"),


]