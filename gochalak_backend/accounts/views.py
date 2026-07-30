# Import Django's authentication function.
# It verifies the provided credentials and returns
# the authenticated user object if the login is valid.
from django.contrib.auth import authenticate

# Import HTTP status codes such as 200, 400, and 401.
from rest_framework import status

# Used to send JSON responses back to the client (Flutter app).
from rest_framework.response import Response

# Base class for creating class-based REST API views.
from rest_framework.views import APIView

# Used to generate JWT Access and Refresh tokens
# after successful authentication.
from rest_framework_simplejwt.tokens import RefreshToken

# Import the serializer responsible for validating
# the incoming login request data.
from .serializers import LoginSerializer


# ---------------------------------------------------------
# Login API
# ---------------------------------------------------------
# This API authenticates a user using a mobile number
# and password. If the credentials are valid, it returns
# JWT Access and Refresh tokens.
# ---------------------------------------------------------
class LoginAPIView(APIView):

    # Handle HTTP POST requests.
    # This method is called when the client sends
    # a POST request to the login endpoint.
    def post(self, request):

        # Create a serializer instance using the
        # incoming request data.
        serializer = LoginSerializer(data=request.data)

        # Validate the request data.
        # If validation fails, return a 400 Bad Request response.
        if not serializer.is_valid():
            return Response(
                serializer.errors,
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Extract validated data from the serializer.
        # Only validated data should be used for authentication.
        mobile = serializer.validated_data["mobile"]
        password = serializer.validated_data["password"]

        # Authenticate the user using the provided
        # mobile number and password.
        user = authenticate(
            request,
            mobile=mobile,
            password=password,
        )

        # Authentication failed.
        # Return 401 Unauthorized if the credentials are incorrect.
        if user is None:
            return Response(
                {"message": "Invalid mobile or password"},
                status=status.HTTP_401_UNAUTHORIZED,
            )

        # Generate a JWT Refresh Token for the authenticated user.
        # An Access Token can be obtained from the Refresh Token.
        refresh = RefreshToken.for_user(user)

        # Return the generated tokens to the client.
        # Flutter will store these tokens and use the
        # Access Token to access protected APIs.
        return Response(
            {
                "message": "Login successful",
                "access": str(refresh.access_token),
                "refresh": str(refresh),
            },
            status=status.HTTP_200_OK,
        )