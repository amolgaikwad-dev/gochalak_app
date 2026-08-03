from django.db import models

from customer.models import Customer
from drivers.models import Driver
from cars.models import CustomerCar





class BookingStatus(models.TextChoices):
    PENDING = "Pending", "Pending"
    ACCEPTED = "Accepted", "Accepted"
    STARTED = "Started", "Started"
    COMPLETED = "Completed", "Completed"
    CANCELLED = "Cancelled", "Cancelled"


class Booking(models.Model):
    customer = models.ForeignKey(
        Customer,
        on_delete=models.CASCADE, #delete customer booking history
    )
    driver = models.ForeignKey(
        Driver,
        on_delete= models.SET_NULL, #driver set null
        null=True,
        blank=True,
    )
    customer_car = models.ForeignKey(
        CustomerCar,
        on_delete=models.CASCADE,
    )
    pickup_location = models.CharField(  # pickup location
        max_length=255,
    )
    drop_location = models.CharField(   #drop location
        max_length=255,
    )
    status = models.CharField(
        max_length=20,
        choices=BookingStatus.choices,
        default=BookingStatus.PENDING,
    )
    created_at = models.DateTimeField(
        auto_now_add=True,
    )
    updated_at = models.DateTimeField(
        auto_now=True,
    )

        
    class Meta:
        ordering = ["-created_at"]

    def __str__(self):
        return f"Booking #{self.id}"