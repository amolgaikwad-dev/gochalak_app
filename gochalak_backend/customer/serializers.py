from accounts.serializers import LoginSerializer
from rest_framework import serializers
from accounts.models import User

class CustomerRegisterSerializer(serializers.Serializer):
    full_name = serializers.CharField(max_length=255)
    mobile = serializers.CharField(max_length=10)
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True)
    confirm_password = serializers.CharField(write_only=True)

def validate(self, data):
    if data["password"] != data["confirm_password"]:
        raise serializers.ValidationError(
            {"confirm_password": "Passwords do not match"}
        )

    if User.objects.filter(mobile=data["mobile"]).exists():
        raise serializers.ValidationError(
        {
            "message": "Mobile number already registered. Please login or reset your password."
        }
    )

    return data

    if User.objects.filter(mobile=data["mobile"]).exists():
        raise serializers.ValidationError(
         {"mobile": "Mobile number already registered"}
    )