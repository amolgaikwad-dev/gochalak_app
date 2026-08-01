#//login api  reqirements
from django.contrib.auth import authenticate

from rest_framework import status
from rest_framework.response import Response

from rest_framework.views import APIView

from rest_framework_simplejwt.tokens import RefreshToken
from .serializers import LoginSerializer


#//customer register reqierments api import
from accounts.models import User

from .models import Customer

from .serializers import CustomerRegisterSerializer



class CustomerLoginApiView(APIView):
    def post(self, request):
        serializer = LoginSerializer(data=request.data)

        if not serializer.is_valid():
            return Response(
                serializer.errors,
                status=status.HTTP_400_BAD_REQUEST,
            )
        mobile = serializer.validated_data["mobile"]
        password = serializer.validated_data["password"]

        
        user = authenticate(
        request,
        mobile=mobile,
        password=password,
        )

        if user is None:
            return Response(
                {"message": "Invalid mobile or password"},
                status=status.HTTP_401_UNAUTHORIZED,
                 )

        refresh = RefreshToken.for_user(user)

        return Response(
            {
            "message": "Login successful",
            "access": str(refresh.access_token),
            "refresh": str(refresh),
            },
            status=status.HTTP_200_OK,
        )




class CustomerRegisterAPIView(APIView):

    def post(self, request):
        serializer = CustomerRegisterSerializer(data=request.data)

        if not serializer.is_valid():
            return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST,
            )
        #validate data
        full_name = serializer.validated_data["full_name"]
        mobile = serializer.validated_data["mobile"]
        email = serializer.validated_data["email"]
        password = serializer.validated_data["password"]


        user = User.objects.create_user(
            mobile=mobile,
            full_name=full_name,
            email=email,
            password=password,
        )


        Customer.objects.create(user=user)

        return Response(
        {
        "message": "Account created successfully",
        },
        status=status.HTTP_201_CREATED,
        )