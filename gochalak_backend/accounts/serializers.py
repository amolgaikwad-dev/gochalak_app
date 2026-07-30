from rest_framework import serializers

from rest_framework import serializers


class LoginSerializer(serializers.Serializer):
    mobile = serializers.CharField(max_length=10)
    password = serializers.CharField(write_only=True)