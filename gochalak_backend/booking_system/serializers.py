from rest_framework import serializers

from .models import Booking

#CREATE BOOKING
class BookingSerializer(serializers.ModelSerializer):

    class Meta:
        model = Booking
        fields = [
            "customer_car",
            "pickup_location",
            "drop_location",
        ]

#AVAILABLE BOOKING
class AvailableBookingSerializer(serializers.ModelSerializer):

    class Meta:
        model = Booking
        fields = [
            "id",
            "pickup_location",
            "drop_location",
            "status",
        ]

#ACCEPT BOOKINGS
class AcceptBookingSerializer(serializers.Serializer):

    booking_id = serializers.IntegerField()     