from django.contrib.auth.models import User
from .models import Message

def unread_admin_messages(request):
    if request.user.is_authenticated:
        admin_user = User.objects.filter(is_superuser=True).first()

        if admin_user:
            count = Message.objects.filter(
                sender=admin_user,
                receiver=request.user,
                is_read=False
            ).count()

            return {"unread_admin_count": count}

    return {"unread_admin_count": 0}