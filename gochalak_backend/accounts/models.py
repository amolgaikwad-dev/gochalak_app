from django.db import models

# Import Django's built-in base classes for creating
# a custom authentication model.
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin

# Import the custom user manager responsible for
# creating users and superusers.
from .managers import UserManager

# ---------------------------------------------------------
# Custom User Model
# ---------------------------------------------------------
# This model replaces Django's default User model.
# It uses the mobile number as the unique login
# identifier instead of the default username.
# ---------------------------------------------------------
class User(AbstractBaseUser, PermissionsMixin ):
    # User's unique mobile number.
    # This field is used as the login credential.
    mobile = models.CharField(max_length=10, unique= True)
    # Stores the user's full name.
    full_name = models.CharField(max_length=255)

    # Determines whether the user account is active.
    # Inactive users cannot authenticate.
    is_active = models.BooleanField(default=True)

    # Grants access to Django Admin when set to True.
    is_staff = models.BooleanField(default=False)

    # Automatically stores the date and time when
    # the user account is created.
    date_joined = models.DateTimeField(auto_now_add=True)

    # Attach the custom manager to handle user creation.
    objects= UserManager()

    # Specify the field used for authentication.
    # Django will use the mobile number instead of username.
    USERNAME_FIELD = "mobile"

    # Required fields when creating a superuser.
    REQUIRED_FIELDS = ["full_name"]


    # String representation of the model.
    # This value is displayed in Django Admin,
    # shell, and other places where the object
    # is converted to a string.
    def __str__(self):
        #return self.full_name
        return self.mobile