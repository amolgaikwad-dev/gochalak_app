from django.db import models
from customer.models import Customer


class CarCompany(models.Model):

    name = models.CharField(
        max_length=100,
        unique=True,
    )

    def __str__(self):
        return self.name

class CarModel(models.Model):

    company = models.ForeignKey(
        CarCompany,
        on_delete=models.CASCADE,
    )

    model_name = models.CharField(
        max_length=100,
    )

    def __str__(self):
        return f"{self.company.name} {self.model_name}"


class CustomerCar(models.Model):

    customer = models.ForeignKey(
        Customer,
        on_delete=models.CASCADE,
    )

    car_model = models.ForeignKey(
        CarModel,
        on_delete=models.CASCADE,
    )

    registration_number = models.CharField(
        max_length=20,
        unique=True,
    )

    def __str__(self):
        return f"{self.customer.full_name} - {self.car_model}"


    