from django.urls import path
from .views import CustomerLoginApiView,CustomerRegisterAPIView

urlpatterns = [
    path("login/", CustomerLoginApiView.as_view()),
    path("register/", CustomerRegisterAPIView.as_view()),

    
]