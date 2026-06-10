from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from .models import UserProfile, Package, Staff, TrackingHistory
from django.db.models import Count
from django.db.models.functions import TruncMonth
import json
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib import messages
import re
from django.utils import timezone
from datetime import timedelta

def register_view(request):
    if request.method == "POST":
        username = request.POST.get("username", "").strip()
        email = request.POST.get("email", "").strip()
        password = request.POST.get("password", "").strip()
        phone = request.POST.get("phone", "").strip()
        address = request.POST.get("address", "").strip()
        city = request.POST.get("city", "").strip()
        pincode = request.POST.get("pincode", "").strip()

        # Username validation
        if len(username) < 3:
            messages.error(request, "Username must be at least 3 characters.")
            return redirect("register")

        if User.objects.filter(username=username).exists():
            messages.error(request, "Username already exists.")
            return redirect("register")

        # Email validation
        email_pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
        if not re.match(email_pattern, email):
            messages.error(request, "Enter a valid email address.")
            return redirect("register")

        if User.objects.filter(email=email).exists():
            messages.error(request, "Email already registered.")
            return redirect("register")

        # Password validation
        if len(password) < 6:
            messages.error(request, "Password must be at least 6 characters.")
            return redirect("register")

        # Phone validation
        if not phone.isdigit() or len(phone) != 10:
            messages.error(request, "Phone number must be 10 digits.")
            return redirect("register")

        # Pincode validation
        if not pincode.isdigit() or len(pincode) != 6:
            messages.error(request, "Pincode must be 6 digits.")
            return redirect("register")

        user = User.objects.create_user(
            username=username,
            email=email,
            password=password
        )

        UserProfile.objects.create(
            user=user,
            phone=phone,
            address=address,
            city=city,
            pincode=pincode
        )

        messages.success(request, "Registration successful! Please login.")
        return redirect("login")

    return render(request, "register.html")


def login_view(request):
    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")

        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)

            # ADMIN LOGIN
            if user.is_superuser:
                messages.success(request, "Welcome Admin")
                return redirect("admin_dashboard")

            # STAFF LOGIN
            elif Staff.objects.filter(user=user).exists():
                messages.success(request, "Welcome Staff")
                return redirect("staff_dashboard")

            # NORMAL USER LOGIN
            else:
                messages.success(request, "Login successful")
                return redirect("dashboard")

        else:
            messages.error(request, "Invalid username or password")

    return render(request, "login.html")
def logout_view(request):
    logout(request)
    return redirect("login")


def dashboard_view(request):
    packages = Package.objects.filter(user=request.user)

    total_packages = packages.count()
    delivered_packages = packages.filter(status="Delivered").count()
    pending_packages = packages.exclude(status="Delivered").count()

    recent_packages = packages.order_by("-id")[:5]

    return render(request, "dashboard.html", {
        "total_packages": total_packages,
        "delivered_packages": delivered_packages,
        "pending_packages": pending_packages,
        "recent_packages": recent_packages,
    })


@login_required
def profile_view(request):
    profile, created = UserProfile.objects.get_or_create(user=request.user)

    if request.method == "POST":
        # Update User model fields
        request.user.username = request.POST.get("username")
        request.user.email = request.POST.get("email")
        request.user.save()

        # Update Profile model fields
        profile.phone = request.POST.get("phone")
        profile.address = request.POST.get("address")
        profile.city = request.POST.get("city")
        profile.pincode = request.POST.get("pincode")

        # Update profile image if uploaded
        if request.FILES.get("profile_image"):
            profile.profile_image = request.FILES["profile_image"]

        profile.save()

        messages.success(request, "Profile updated successfully!")
        return redirect("profile")

    return render(request, "profile.html", {
        "profile": profile
    })


@login_required
def packages_view(request):
    packages = Package.objects.filter(user=request.user)
    return render(request, "packages.html", {"packages": packages})

import random


@login_required
def add_package_view(request):
    if request.method == "POST":
        sender_name = request.POST.get("sender_name")
        sender_address = request.POST.get("sender_address")
        sender_phone = request.POST.get("sender_phone")

        receiver_name = request.POST.get("receiver_name")
        receiver_address = request.POST.get("receiver_address")
        receiver_phone = request.POST.get("receiver_phone")

        package_weight = request.POST.get("package_weight")

        tracking_id = "TRK" + str(random.randint(10000, 99999))

        package_image = request.FILES.get("package_image")
        weight = float(request.POST.get("package_weight"))

        amount = weight * 50

        package = Package.objects.create(
            user=request.user,

            sender_name=sender_name,
            sender_address=sender_address,
            sender_phone=sender_phone,

            receiver_name=receiver_name,
            receiver_address=receiver_address,
            receiver_phone=receiver_phone,

            package_weight=package_weight,
            package_image=package_image,

            tracking_id=tracking_id,
            status="Booked",
            amount=amount,
            payment_status="Pending",
        )
        TrackingHistory.objects.create(
            package=package,
            status="Booked",
            city="Origin City"
        )

        return redirect("payment", package_id=package.id)

    return render(request, "add_package.html")

@login_required
def edit_package_view(request, package_id):
    package = Package.objects.get(id=package_id, user=request.user)

    if package.status != "Booked":
        return redirect("packages")

    if request.method == "POST":
        package.sender_name = request.POST.get("sender_name")
        package.sender_address = request.POST.get("sender_address")
        package.sender_phone = request.POST.get("sender_phone")

        package.receiver_name = request.POST.get("receiver_name")
        package.receiver_address = request.POST.get("receiver_address")
        package.receiver_phone = request.POST.get("receiver_phone")

        package.package_weight = request.POST.get("package_weight")

        if request.FILES.get("package_image"):
            package.package_image = request.FILES["package_image"]

        package.save()

        return redirect("packages")

    return render(request, "edit_package.html", {
        "package": package
    })

@login_required
def delete_package_view(request, package_id):
    package = Package.objects.get(id=package_id, user=request.user)

    if package.status == "Booked":
        package.delete()

    return redirect("packages")

@staff_member_required
def admin_packages_view(request):
    packages = Package.objects.all().order_by('-booking_date')
    return render(request, "admin_packages.html", {"packages": packages})


@staff_member_required
def update_status_view(request, package_id):
    package = Package.objects.get(id=package_id)

    if request.method == "POST":
        package.status = request.POST.get("status")
        package.current_city = request.POST.get("city")
        package.save()

        TrackingHistory.objects.create(
            package=package,
            status=package.status,
            city=package.current_city
        )

        return redirect("admin_packages")

    return render(request, "update_status.html", {
        "package": package
    })


@staff_member_required
def manage_users_view(request):
    staff_user_ids = Staff.objects.values_list("user_id", flat=True)

    users = User.objects.filter(
        is_staff=False
    ).exclude(
        id__in=staff_user_ids
    )

    return render(request, "manage_users.html", {
        "users": users
    })

@staff_member_required
def add_user_view(request):
    if request.method == "POST":
        username = request.POST.get("username")
        email = request.POST.get("email")
        password = request.POST.get("password")

        User.objects.create_user(
            username=username,
            email=email,
            password=password
        )

        return redirect("manage_users")

    return render(request, "add_user.html")

@staff_member_required
def edit_user_view(request, user_id):
    user = User.objects.get(id=user_id)

    # Safe profile creation
    profile, created = UserProfile.objects.get_or_create(
        user=user,
        defaults={
            "phone": "",
            "address": "",
            "city": "",
            "pincode": ""
        }
    )

    if request.method == "POST":
        user.username = request.POST.get("username")
        user.email = request.POST.get("email")
        user.save()

        profile.phone = request.POST.get("phone")
        profile.address = request.POST.get("address")
        profile.city = request.POST.get("city")
        profile.pincode = request.POST.get("pincode")
        profile.save()

        return redirect("manage_users")

    return render(request, "edit_user.html", {
        "user": user,
        "profile": profile
    })


@staff_member_required
def delete_user_view(request, user_id):
    user = User.objects.get(id=user_id)
    user.delete()

    return redirect("manage_users")

@login_required
def update_profile_view(request):
    try:
        profile = request.user.userprofile
    except UserProfile.DoesNotExist:
        messages.error(request, "Profile not found. Please contact support.")
        return redirect("profile")

    if request.method == "POST":
        phone = request.POST.get("phone", "").strip()
        address = request.POST.get("address", "").strip()
        city = request.POST.get("city", "").strip()
        pincode = request.POST.get("pincode", "").strip()

        # Phone validation
        if not phone.isdigit() or len(phone) != 10 or not phone.startswith(('6', '7', '8', '9')):
            messages.error(request, "Phone number must be 10 digits and start with 6, 7, 8, or 9.")
            return redirect("update_profile")

        # Address validation
        if not address:
            messages.error(request, "Address is required.")
            return redirect("update_profile")

        # City validation
        if not city:
            messages.error(request, "City is required.")
            return redirect("update_profile")

        # Pincode validation
        if not pincode.isdigit() or len(pincode) != 6:
            messages.error(request, "Pincode must be 6 digits.")
            return redirect("update_profile")

        profile.phone = phone
        profile.address = address
        profile.city = city
        profile.pincode = pincode

        if request.FILES.get("profile_image"):
            profile.profile_image = request.FILES["profile_image"]

        profile.save()
        messages.success(request, "Profile updated successfully.")
        return redirect("profile")

    return render(request, "update_profile.html", {"profile": profile})

from .models import Feedback


from django.contrib import messages
from .models import Feedback


from django.contrib import messages
from .models import Feedback

from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from .models import Feedback


@login_required
def feedback_view(request):
    if request.method == "POST":
        subject = request.POST.get("subject")
        message = request.POST.get("message")
        rating = request.POST.get("rating")

        Feedback.objects.create(
            user=request.user,
            subject=subject,
            message=message,
            rating=rating
        )

        return redirect("feedback")

    feedbacks = Feedback.objects.filter(
        user=request.user
    ).order_by("created_at")

    return render(request, "feedback.html", {
        "feedbacks": feedbacks
    })

from django.shortcuts import render, redirect, get_object_or_404
from .models import Feedback

@staff_member_required
def feedback_list_view(request):
    feedbacks = Feedback.objects.all().order_by("-id")

    return render(request, "feedback_list.html", {
        "feedbacks": feedbacks
    })

@staff_member_required
def delete_feedback_view(request, id):
    feedback = get_object_or_404(Feedback, id=id)
    feedback.delete()
    return redirect("feedback_list")

@login_required
def reply_feedback_view(request, feedback_id):
    feedback = Feedback.objects.get(id=feedback_id)

    if request.method == "POST":
        feedback.reply = request.POST.get("reply")
        feedback.save()

        return redirect("feedback_list")   # use your actual URL name

    return render(request, "reply_feedback.html", {
        "feedback": feedback
    })

@login_required
def track_package_view(request):
    package = None
    history = None
    error = None

    if request.method == "POST":
        tracking_id = request.POST.get("tracking_id")

        try:
            package = Package.objects.get(
                tracking_id=tracking_id,
                user=request.user
            )

            history = package.tracking_history.all().order_by("updated_at")

        except Package.DoesNotExist:
            error = "Package not found"

    return render(request, "track_package.html", {
        "package": package,
        "history": history,
        "error": error
    })

from django.contrib.auth.models import User
from .models import Package

@staff_member_required
def admin_dashboard_view(request):
    total_users = User.objects.filter(is_staff=False).count()
    total_staff = Staff.objects.count()
    total_packages = Package.objects.count()

    ordered_count = Package.objects.filter(status="Booked").count()
    shipped_count = Package.objects.filter(status="In Transit").count()
    collected_count = 0  # Since "In Transit" combines shipped and collected
    delivered_packages = Package.objects.filter(status="Delivered").count()

    # Chart data
    booked_count = ordered_count
    transit_count = shipped_count + collected_count
    delivered_count = delivered_packages

    # Monthly package bookings
    monthly_data = Package.objects.annotate(month=TruncMonth('booking_date')).values('month').annotate(count=Count('id')).order_by('month')
    months = [entry['month'].strftime('%B %Y') for entry in monthly_data]
    monthly_counts = [entry['count'] for entry in monthly_data]

    # Staff performance data
    staff_performance = Staff.objects.annotate(
        package_count=Count('package')
    ).values('user__username', 'package_count')[:10]  # Top 10 staff
    staff_names = [entry['user__username'] for entry in staff_performance]
    staff_packages = [entry['package_count'] for entry in staff_performance]

    # Daily activity (last 7 days)
    today = timezone.now().date()
    daily_data = []
    daily_labels = []
    for i in range(6, -1, -1):
        date = today - timedelta(days=i)
        # Use date range to be more inclusive
        start_date = timezone.datetime.combine(date, timezone.datetime.min.time())
        end_date = timezone.datetime.combine(date, timezone.datetime.max.time())
        count = Package.objects.filter(booking_date__range=(start_date, end_date)).count()
        daily_data.append(count)
        daily_labels.append(date.strftime('%a'))

    # If no data, provide sample data for testing
    if sum(daily_data) == 0:
        daily_data = [5, 8, 12, 7, 15, 9, 11]
        daily_labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

    # System metrics for radar chart
    system_metrics = {
        'Users': total_users,
        'Staff': total_staff,
        'Packages': total_packages,
        'Delivered': delivered_packages,
        'In Transit': transit_count,
        'Booked': booked_count
    }

    # Ensure system metrics have some data for radar chart
    if all(v == 0 for v in system_metrics.values()):
        system_metrics = {
            'Users': 25,
            'Staff': 8,
            'Packages': 45,
            'Delivered': 32,
            'In Transit': 10,
            'Booked': 3
        }

    recent_packages = Package.objects.order_by("-id")[:5]

    return render(request, "admin_dashboard.html", {
        "total_users": total_users,
        "total_staff": total_staff,
        "total_packages": total_packages,
        "ordered_count": ordered_count,
        "shipped_count": shipped_count,
        "collected_count": collected_count,
        "delivered_packages": delivered_packages,
        "booked_count": booked_count,
        "transit_count": transit_count,
        "delivered_count": delivered_count,
        "months": json.dumps(months) if months else json.dumps([]),
        "monthly_counts": json.dumps(monthly_counts) if monthly_counts else json.dumps([]),
        "staff_names": json.dumps(staff_names) if staff_names else json.dumps([]),
        "staff_packages": json.dumps(staff_packages) if staff_packages else json.dumps([]),
        "daily_labels": json.dumps(daily_labels),
        "daily_data": json.dumps(daily_data),
        "system_metrics": json.dumps(list(system_metrics.values())),
        "system_labels": json.dumps(list(system_metrics.keys())),
        "recent_packages": recent_packages,
    })

@staff_member_required
def add_staff_view(request):
    if request.method == "POST":
        username = request.POST.get("username")
        email = request.POST.get("email")
        password = request.POST.get("password")
        phone = request.POST.get("phone")
        city = request.POST.get("city")
        role = request.POST.get("role")

        user = User.objects.create_user(
            username=username,
            email=email,
            password=password
        )

        staff = Staff.objects.create(
            user=user,
            staff_id="STF" + str(user.id),
            phone=phone,
            city=city,
            role=role
        )

        return redirect("manage_staff")

    return render(request, "add_staff.html")

@staff_member_required
def manage_staff_view(request):
    staff_members = Staff.objects.all()
    return render(request, "manage_staff.html", {
        "staff_members": staff_members
    })

@login_required
def staff_dashboard_view(request):
    staff = request.user.staff

    packages = Package.objects.filter(assigned_staff=staff)

    context = {
        "total_packages": packages.count(),
        "delivered_count": packages.filter(status="Delivered").count(),
        "pending_count": packages.exclude(status="Delivered").count(),
        "packages": packages[:5]
    }

    return render(request, "staff_dashboard.html", context)

from .models import Package, Staff
from django.contrib.admin.views.decorators import staff_member_required


from .models import Package, Staff


from .models import Staff, Package
from django.contrib.admin.views.decorators import staff_member_required


@staff_member_required
def assign_package_view(request, package_id):
    package = Package.objects.get(id=package_id)

    if request.method == "POST":
        staff_id = request.POST.get("staff_id")
        staff = Staff.objects.get(id=staff_id)

        package.assigned_staff = staff
        package.save()

        return redirect("admin_packages")

    staffs = Staff.objects.all()

    return render(request, "assign_package.html", {
        "package": package,
        "staffs": staffs
    })

@login_required
def staff_update_status_view(request, package_id):
    staff = Staff.objects.get(user=request.user)

    package = Package.objects.get(
        id=package_id,
        assigned_staff=staff
    )

    if request.method == "POST":
        new_status = request.POST.get("status")
        current_city = request.POST.get("current_city")

        package.status = new_status
        package.current_city = current_city
        package.save()

        # auto create timeline history
        TrackingHistory.objects.create(
            package=package,
            status=new_status,
            city=current_city
        )

        return redirect("staff_packages")

    return render(request, "staff_update_status.html", {
        "package": package
    })


from django.contrib import messages
from django.contrib.auth.models import User
from .models import Staff


import re
from django.contrib import messages

from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.contrib import messages
from .models import Staff
import random

@staff_member_required
def add_staff_view(request):
    if request.method == "POST":
        username = request.POST.get("username")
        email = request.POST.get("email")
        phone = request.POST.get("phone")
        password = request.POST.get("password")
        city = request.POST.get("city")
        address = request.POST.get("address")

        # username validation
        if User.objects.filter(username=username).exists():
            messages.error(request, "Username already exists.")
            return redirect("add_staff")

        # email validation
        if User.objects.filter(email=email).exists():
            messages.error(request, "Email already exists.")
            return redirect("add_staff")

        # create user
        user = User.objects.create_user(
            username=username,
            email=email,
            password=password
        )

        # auto staff id
        staff_id = "STF" + str(random.randint(1000, 9999))

        # create staff
        Staff.objects.create(
            user=user,
            staff_id=staff_id,
            email=email,
            phone=phone,
            city=city,
            address=address
        )

        messages.success(request, "Staff added successfully.")
        return redirect("manage_staff")

    # IMPORTANT FOR GET REQUEST
    return render(request, "add_staff.html")

@staff_member_required
def edit_staff_view(request, staff_id):
    staff = Staff.objects.get(id=staff_id)

    if request.method == "POST":
        staff.user.username = request.POST.get("username")
        staff.user.save()

        staff.phone = request.POST.get("phone")
        staff.city = request.POST.get("city")
        staff.role = request.POST.get("role")
        staff.save()

        return redirect("manage_staff")

    return render(request, "edit_staff.html", {
        "staff": staff
    })

@staff_member_required
def delete_staff_view(request, staff_id):
    staff = Staff.objects.get(id=staff_id)

    if request.method == "POST":
        staff.user.delete()
        return redirect("manage_staff")

    return render(request, "delete_staff.html", {
        "staff": staff
    })

@login_required
def staff_packages_view(request):
    staff = Staff.objects.get(user=request.user)

    packages = Package.objects.filter(
        assigned_staff=staff
    )

    return render(request, "staff_packages.html", {
        "packages": packages
    })

@staff_member_required
def assign_package_list_view(request):
    packages = Package.objects.all().order_by('-booking_date')
    return render(request, "assign_package_list.html", {
        "packages": packages
    })

from .models import TrackingHistory

@login_required
def staff_history_view(request):
    try:
        staff = request.user.staff
        history = TrackingHistory.objects.filter(
            package__assigned_staff=staff
        ).order_by('-updated_at')

        return render(request, "staff_history.html", {
            "history": history
        })

    except:
        return redirect("staff_packages")


from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from .models import Staff


import re
from django.contrib import messages


@login_required
def staff_profile_view(request):
    staff = Staff.objects.get(user=request.user)

    if request.method == "POST":
        phone = request.POST.get("phone")
        email = request.POST.get("email")

        if not re.match(r'^[6-9]\d{9}$', phone):
            messages.error(request, "Enter valid 10-digit phone number.")
            return redirect("staff_profile")

        if "@" not in email or "." not in email:
            messages.error(request, "Enter valid email address.")
            return redirect("staff_profile")

        staff.phone = phone
        staff.email = email
        staff.address = request.POST.get("address")
        staff.city = request.POST.get("city")
        staff.role = request.POST.get("role")

        if request.FILES.get("profile_image"):
            staff.profile_image = request.FILES["profile_image"]

        staff.save()

        messages.success(request, "Profile updated successfully.")
        return redirect("staff_profile")

    return render(request, "staff_profile.html", {
        "staff": staff
    })




from .models import Message, Staff
from django.contrib.auth.decorators import login_required

@login_required
def admin_staff_chat_view(request, staff_id):
    staff = Staff.objects.get(id=staff_id)

    messages_list = Message.objects.filter(
        sender__in=[request.user, staff.user],
        receiver__in=[request.user, staff.user]
    ).order_by('created_at')

    if request.method == "POST":
        text = request.POST.get("message")

        Message.objects.create(
            sender=request.user,
            receiver=staff.user,
            message=text
        )

        return redirect('admin_staff_chat', staff_id=staff.id)

    return render(request, "admin_staff_chat.html", {
        "staff": staff,
        "messages": messages_list
    })

from .models import Staff

def staff_chat_list_view(request):
    staffs = Staff.objects.all()

    return render(request, "staff_chat_list.html", {
        "staffs": staffs
    })

@login_required
def staff_admin_chat_view(request):
    admin_user = User.objects.filter(is_superuser=True).first()

    return render(request, "staff_admin_chat.html", {
        "admin_user": admin_user
    })

@login_required
def staff_chat_list_view(request):
    staffs = Staff.objects.all()

    staff_data = []

    for staff in staffs:
        unread_count = Message.objects.filter(
            sender=staff.user,
            receiver=request.user,
            is_read=False
        ).count()

        staff_data.append({
            "staff": staff,
            "unread_count": unread_count
        })

    return render(request, "staff_chat_list.html", {
        "staff_data": staff_data
    })

@login_required
def admin_open_chat_view(request, staff_id):
    staff = Staff.objects.get(id=staff_id)

    Message.objects.filter(
        sender=staff.user,
        receiver=request.user,
        is_read=False
    ).update(is_read=True)

    chats = Message.objects.filter(
        sender__in=[request.user, staff.user],
        receiver__in=[request.user, staff.user]
    ).order_by('created_at')

    if request.method == "POST":
        text = request.POST.get("message")

        Message.objects.create(
            sender=request.user,
            receiver=staff.user,
            message=text
        )

        return redirect("admin_open_chat", staff_id=staff.id)

    return render(request, "admin_open_chat.html", {
        "staff": staff,
        "chats": chats
    })

@login_required
def staff_admin_chat_view(request):
    admin_user = User.objects.filter(is_superuser=True).first()

    # mark admin messages as read
    Message.objects.filter(
        sender=admin_user,
        receiver=request.user,
        is_read=False
    ).update(is_read=True)

    chats = Message.objects.filter(
        sender__in=[request.user, admin_user],
        receiver__in=[request.user, admin_user]
    ).order_by('created_at')

    if request.method == "POST":
        text = request.POST.get("message")

        Message.objects.create(
            sender=request.user,
            receiver=admin_user,
            message=text
        )

        return redirect("staff_admin_chat")

    unread_admin_count = Message.objects.filter(
        sender=admin_user,
        receiver=request.user,
        is_read=False
    ).count()

    return render(request, "staff_admin_chat.html", {
        "chats": chats,
        "unread_admin_count": unread_admin_count
    })

@login_required
def payment_view(request, package_id):
    package = Package.objects.get(id=package_id, user=request.user)

    if request.method == "POST":
        package.payment_status = "Paid"
        package.payment_date = timezone.now()
        package.save()

        return redirect("receipt", package_id=package.id)

    return render(request, "payment.html", {"package": package})

@login_required
def receipt_view(request, package_id):
    package = Package.objects.get(
        id=package_id,
        user=request.user
    )

    return render(request, "receipt.html", {
        "package": package
    })