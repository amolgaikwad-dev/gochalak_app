from django.urls import path

from .views import AddCustomerCarAPIView

urlpatterns = [
    path("add/",AddCustomerCarAPIView.as_view(),name="add-customer-car",),
]