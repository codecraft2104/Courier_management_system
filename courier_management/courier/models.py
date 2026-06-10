from django.db import models
from django.contrib.auth.models import User
from django.core.validators import RegexValidator, EmailValidator
from django.core.exceptions import ValidationError

phone_validator = RegexValidator(
    regex=r'^[6-9]\d{9}$',
    message="Phone number must be 10 digits and start with 6, 7, 8, or 9."
)

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.CharField(max_length=10, validators=[phone_validator])    
    address = models.TextField()
    city = models.CharField(max_length=100)
    pincode = models.CharField(max_length=10)
    profile_image = models.ImageField(
    upload_to='profile_images/',
    default='defaults/default-user.png',
    blank=True
)

    def __str__(self):
        return self.user.username


class Package(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    # Sender details
    sender_name = models.CharField(max_length=100)
    sender_address = models.TextField()
    sender_phone = models.CharField(max_length=10)

    # Receiver details
    receiver_name = models.CharField(max_length=100)
    receiver_address = models.TextField()
    receiver_phone = models.CharField(max_length=10)

    package_weight = models.DecimalField(max_digits=5, decimal_places=2)
    package_image = models.ImageField(upload_to='package_images/', blank=True, null=True)

    tracking_id = models.CharField(max_length=20, unique=True)
    status = models.CharField(max_length=50, default="Booked")

    booking_date = models.DateTimeField(auto_now_add=True)
    current_city = models.CharField(max_length=100, default="Bangalore")
    last_updated = models.DateTimeField(auto_now=True)
    assigned_staff = models.ForeignKey(
    'Staff',
    on_delete=models.SET_NULL,
    null=True,
    blank=True
)
    payment_status = models.CharField(
        max_length=20,
        default="Pending"
)

    amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0
)

    payment_date = models.DateTimeField(
        null=True,
        blank=True
)
    def __str__(self):
        return self.tracking_id

class TrackingHistory(models.Model):
    package = models.ForeignKey(
        Package,
        on_delete=models.CASCADE,
        related_name="tracking_history"
    )
    status = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    updated_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.package.tracking_id} - {self.status}"

from django.db import models
from django.contrib.auth.models import User


class Feedback(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    subject = models.CharField(max_length=200)
    message = models.TextField()
    rating = models.IntegerField()
    reply = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.subject

from django.contrib.auth.models import User
from django.db import models

class Staff(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    staff_id = models.CharField(max_length=20, unique=True)

    phone = models.CharField(
        max_length=10,
        validators=[phone_validator],
        blank=True,
        null=True
    )

    address = models.TextField(blank=True, null=True)

    city = models.CharField(max_length=100, blank=True, null=True)

    email = models.EmailField(
        unique=True,
        blank=True,
        null=True
    )

    role = models.CharField(max_length=100, default="Delivery Staff")

    profile_image = models.ImageField(
        upload_to="staff_profiles/",
        blank=True,
        null=True
    )

    def __str__(self):
        return self.user.username

from django.db import models
from django.contrib.auth.models import User

class Message(models.Model):
    sender = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='sent_messages'
    )
    receiver = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='received_messages'
    )
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.sender.username} -> {self.receiver.username}"