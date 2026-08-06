from rest_framework import serializers

from .models import CustomerCar

class CustomerCarSerializer(serializers.ModelSerializer):

    class Meta:
        model = CustomerCar
        fields = [
            "car_model",
            "registration_number",
        ]


        