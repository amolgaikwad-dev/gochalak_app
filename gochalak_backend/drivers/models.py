from django.db import models
from accounts.models import User


class Driver(models.Model):
    # Link with User account
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
    )




    #PROFILE SECTION
    # Driver status
    is_verified = models.BooleanField(default=False)

    #profile photo
    profile_photo = models.ImageField(
    upload_to="drivers/profile/",
    blank=True,
    null=True,
    )

    #DRIVER DOB
    date_of_birth = models.DateField(
    blank=True,
    null=True,
    )

    #DRIVER ADDRESS
    address = models.TextField(
    blank=True,
    )  


    #DRIVER EMERGENCY CONTACT
    emergency_contact = models.CharField(
    max_length=10,
    blank=True,
    ) 


    #DRIVER GENDER
    gender = models.CharField(
    max_length=10,
    blank=True,
    )

    #DRIVER BLOOD GROUP
    blood_group = models.CharField(
    max_length=5,
    blank=True,
    )







    #DOCUMENTATION SECTION


    #DRIVERS LICENCE
    driving_licence = models.ImageField(
    upload_to="drivers/licence/",
    blank=True,
    null=True,
    )

    #DRIVERS ADHAR CARD
    aadhaar_front = models.ImageField(
    upload_to="drivers/aadhaar/",
    blank=True,
    null=True,
    )

    aadhaar_back = models.ImageField(
    upload_to="drivers/aadhaar/",
    blank=True,
    null=True,
    )

    #DRIVERS PAN CARD
    pan_card = models.ImageField(
    upload_to="drivers/pan/",
    blank=True,
    null=True,
    )

    #DRIVERS POLICE VERIFICATION
    police_verification = models.ImageField(
    upload_to="drivers/police_verification/",
    blank=True,
    null=True,
    )



    # Record timestamps
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.user.full_name