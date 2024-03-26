from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.core.validators import RegexValidator
from todolist.utils import Validation
from .models import User


class NameMixins(serializers.Serializer):
    name = serializers.CharField(
        max_length=40,
        required=True,
        error_messages={
            "max_length": "Name should be less than 40 characters.+D1003",
            "blank": "Name cannot blank.+D1001",
            "required": "Name is required.+D1001",
        },
        validators=[
            RegexValidator(
                Validation.name_validation(), message="Enter a valid name.+D1000"
            )
        ],
    )


class EmailMixins(serializers.Serializer):
    email = serializers.EmailField(
        max_length=100,
        required=True,
        validators=[
            UniqueValidator(
                queryset=User.objects.all(),
                message="This email address is already in use.+D1002",
            )
        ],
        error_messages={
            "invalid": "Enter a valid email address.+D1000",
            "blank": "Email cannot be blank.+D1001",
            "required": "Email address is required.+D1001",
        },
    )


class PasswordMixins(serializers.Serializer):

    password = serializers.CharField(
        max_length=20,
        required=True,
        error_messages={
            "max_length": "Password should be less than 20 characters.+D1003",
            "blank": "Password cannot be blank.+D1001",
            "required": "Password is required.+D1001",
        },
        validators=[
            RegexValidator(
                Validation.password_validation(),
                message="Enter a valid password.+D1000",
            )
        ],
    )


class RegistrationSerializer(
    NameMixins, EmailMixins, PasswordMixins, serializers.ModelSerializer
):

    class Meta:
        model = User
        fields = "__all__"


class ProfileUpdateSerializer(NameMixins, EmailMixins, serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ("name", "email")


class LoginSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(
        max_length=100,
        required=True,
        error_messages={
            "invalid": "Enter a valid email address.+D1000",
            "blank": "Email cannot be blank.+D1001",
            "required": "Email address is required.+D1001",
        },
    )

    password = serializers.CharField(
        max_length=20,
        required=True,
        error_messages={
            "max_length": "Password should be less than 20 characters.+D1003",
            "blank": "Password cannot be blank.+D1001",
            "required": "Password is required.+D1001",
        },
    )

    class Meta:
        model = User
        fields = ("email", "password")


class PasswordUpdateSerializer(PasswordMixins, serializers.Serializer):
    old_password=serializers.CharField(
        max_length=20,
        required=True,
        error_messages={
            "max_length": "Password should be less than 20 characters.+D1003",
            "blank": "Password cannot be blank.+D1001",
            "required": "Password is required.+D1001",
        },
    )
