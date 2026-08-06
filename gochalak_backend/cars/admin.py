from django.contrib import admin

from .models import CarCompany, CarModel, CustomerCar

admin.site.register(CarCompany)
admin.site.register(CarModel)
admin.site.register(CustomerCar)