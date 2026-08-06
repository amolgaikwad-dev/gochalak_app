from django.urls import path

from .views import CreateBookingAPIView,AvailableBookingsAPIView, AcceptBookingAPIView


urlpatterns = [
    path("create/",CreateBookingAPIView.as_view(),name="create-booking",),
    path("available/",AvailableBookingsAPIView.as_view(),name="available-bookings",),
    path("accept/",AcceptBookingAPIView.as_view(),name="accept-booking",),



]