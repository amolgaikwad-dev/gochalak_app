from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response


from rest_framework.permissions import IsAuthenticated
from .models import Driver

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def driver_profile(request):
    driver = Driver.objects.get(user = request.user)
    

    return Response({
        "driver_id": driver.id,
        "full_name": driver.user.full_name,
        "mobile": driver.user.mobile,
        #"licence_number": driver.licence_number,
        "profile_photo": (
            driver.profile_photo.url
            if driver.profile_photo
            else None
        ),
    })


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def driver_documents(request):
    driver = Driver.objects.get(user = request.user)

    return Response({
    "driving_licence": (
        driver.driving_licence.url
        if driver.driving_licence
        else None
    ),


    "aadhaar_front": (
    driver.aadhaar_front.url
    if driver.aadhaar_front
    else None
    ),

    "aadhaar_back": (
    driver.aadhaar_back.url
    if driver.aadhaar_back
    else None
    ),


    "pan_card": (
    driver.pan_card.url
    if driver.pan_card
    else None
    ),

    "police_verification": (
    driver.police_verification.url
    if driver.police_verification
    else None
    ),
})
