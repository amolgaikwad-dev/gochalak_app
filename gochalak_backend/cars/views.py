from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from customer.models import Customer

from .models import CustomerCar
from .serializers import CustomerCarSerializer


class AddCustomerCarAPIView(APIView):

    def post(self, request):


        serializer = CustomerCarSerializer(data=request.data)

        if not serializer.is_valid():
            return Response(
                serializer.errors,
                status=status.HTTP_400_BAD_REQUEST,
            )

        user = request.user

        customer = Customer.objects.get(
            user=user,
        )


        car_model = serializer.validated_data["car_model"]
        registration_number = serializer.validated_data["registration_number"]   

        CustomerCar.objects.create(
            customer=customer,
            car_model=car_model,
            registration_number=registration_number,
        )


        return Response(
        {
        "message": "Car added successfully",
        },
        status=status.HTTP_201_CREATED,
        )