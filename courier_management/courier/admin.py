from django.contrib import admin
from .models import UserProfile, Package

admin.site.register(UserProfile)
admin.site.register(Package)

# Username : admin
# Email address: admin@gmail.com
# Password: admin@1234