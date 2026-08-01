# Import Django's base manager used for creating
# and managing custom user models.
from django.contrib.auth.base_user import BaseUserManager


# ---------------------------------------------------------
# Custom User Manager
# ---------------------------------------------------------
# This manager is responsible for creating regular users
# and superusers for the custom User model.
#
# Instead of using Django's default username field,
# this project authenticates users with their mobile number.
# ---------------------------------------------------------
class UserManager(BaseUserManager):

    # Create and save a regular user.
    def create_user(self, mobile, full_name, email, password=None):

        # Ensure that a mobile number is provided.
        # A user cannot be created without a unique
        # mobile number because it is the login identifier.
        if not mobile:
            raise ValueError("10 DIGIT PHONE NUMBER IS REQUIRED")

        # Create a new user instance.
        # At this point, the password is NOT saved yet.
        user = self.model(
            mobile=mobile,
            full_name=full_name,
            email=email,

        )

        # Hash the plain text password before storing it
        # in the database for security.
        user.set_password(password)

        # Save the user using the configured database.
        user.save(using=self._db)

        return user


    # Create and save a superuser (Administrator).
    def create_superuser(self, mobile, full_name, email, password=None):

        # First, create a normal user using the
        # create_user() method to avoid code duplication.
        user = self.create_user(
            mobile=mobile,
            full_name=full_name,
            email=email,
            password=password,
        )

        # Grant access to Django Admin.
        user.is_staff = True

        # Give the user all administrative permissions.
        user.is_superuser = True

        # Save the updated user.
        user.save(using=self._db)

        return user