from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Booking
from .serializers import BookingSerializer

from customer.models import Customer

from .models import Booking, BookingStatus
from .serializers import AvailableBookingSerializer
from drivers.models import Driver
from .serializers import AcceptBookingSerializer

#API
class CreateBookingAPIView(APIView):
    def post(self, request):

        serializer = BookingSerializer(data=request.data)

        if not serializer.is_valid():
            return Response(
                serializer.errors,
                status=status.HTTP_400_BAD_REQUEST,
                )

        user = request.user

        customer = Customer.objects.get(
            user=user,
        )

        customer_car = serializer.validated_data["customer_car"]
        pickup_location = serializer.validated_data["pickup_location"]
        drop_location = serializer.validated_data["drop_location"]

        booking = Booking.objects.create(
            customer=customer,
            customer_car=customer_car,
            pickup_location=pickup_location,
            drop_location=drop_location,
        )


        return Response(
        {
            "message": "Booking created successfully",
        },
            status=status.HTTP_201_CREATED,
        )

#API
class AvailableBookingsAPIView(APIView):

    def get(self, request):

        bookings = Booking.objects.filter(
            status=BookingStatus.PENDING,
        )

        serializer = AvailableBookingSerializer(
            bookings,
            many=True,
        )

        return Response(
            serializer.data,
            status=status.HTTP_200_OK,
        )


#API
class AcceptBookingAPIView(APIView):

    def post(self, request):
        serializer = AcceptBookingSerializer(data=request.data)

        if not serializer.is_valid():
            return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST,
        )


        booking_id = serializer.validated_data["booking_id"]


        user = request.user

        driver = Driver.objects.get(
            user=user,
        )


        booking = Booking.objects.get(
            id=booking_id,
        )


        if booking.status != BookingStatus.PENDING:
            return Response(
        {
            "message": "Booking is no longer available",
        },
        status=status.HTTP_400_BAD_REQUEST,
        )

        booking.driver = driver
        booking.status = BookingStatus.ACCEPTED
        booking.save()


        return Response(
        {
        "message": "Booking accepted successfully",
        },
            status=status.HTTP_200_OK,
        )