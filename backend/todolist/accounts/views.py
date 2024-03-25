from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.generics import UpdateAPIView
from rest_framework.response import Response
from rest_framework.authentication import authenticate
from rest_framework import permissions
from accounts.serializer import (
    RegistrationSerializer,
    LoginSerializer,
    ProfileUpdateSerializer,
)
from .models import User
from todolist.utils import ErrorHandling, Token
import logging

logger = logging.getLogger("django")


class UserRegistration(APIView):
    def post(self, request):
        serialized_data = RegistrationSerializer(data=request.data)
        if serialized_data.is_valid():
            User.objects.create_user(
                password=serialized_data.data.get("password"),
                name=serialized_data.data.get("name"),
                email=serialized_data.data.get("email"),
            )
            logger.info("Account created")
            return Response({"message": "Account created"}, status=201)
        else:
            logger.warn("Validation failed")
            return Response(
                ErrorHandling.error_message_handling(self, serialized_data.errors),
                status=400,
            )


class Login(APIView):
    def post(self, request):
        serialized_data = LoginSerializer(data=request.data)
        if serialized_data.is_valid():
            try:
                user = User.objects.get(email=serialized_data.validated_data["email"])
                is_user_authenticated = authenticate(
                    email=serialized_data.validated_data["email"],
                    password=serialized_data._validated_data["password"],
                )
                if is_user_authenticated:
                    logger.info("User with id" + str(user.id) + " has logged in")
                    return Response(Token.generate_token(self, user), status=200)
                else:
                    logger.warn("Invalid credentials")
                    return Response(
                        {"error_message": "Invalid credentials", "error_code": "D1005"},
                        status=400,
                    )
            except User.DoesNotExist:
                logger.warn("User doesn't exist")
                return Response(
                    {"error_message": "User doesn't exist", "error_code": "D1004"},
                    status=400,
                )
        else:
            logger.warn("Validation failed")
            return Response(
                ErrorHandling.error_message_handling(self, serialized_data.errors),
                status=400,
            )


class GetUserDetails(APIView):
    permission_classes = (permissions.IsAuthenticated,)

    def get(self, request):
        user_id = request.user.id
        try:
            user = User.objects.get(id=user_id)
            return Response({"name": user.name, "email": user.email}, status=200)
        except User.DoesNotExist:
            return Response(
                {"error_message": "User doesn't exist", "error_code": "D1004"},
                status=400,
            )


class UpdateUserProfile(UpdateAPIView):
    permission_classes = (permissions.IsAuthenticated,)

    def update(self, request):
        user_id = request.user.id
        try:
            user = User.objects.get(id=user_id)
            serialized_data = ProfileUpdateSerializer(user, request.data, partial=True)
            if serialized_data.is_valid():
                self.perform_update(serialized_data)
                logger.info("User with id" + str(user.id) + " info has been updated")
                return Response(
                    {"message": "User information updated successfully"}, status=200
                )
            else:
                logger.warn("Validation failed")
                return Response(
                    ErrorHandling.error_message_handling(self, serialized_data.errors),
                    status=400,
                )
        except User.DoesNotExist:
            return Response(
                {"error_message": "User doesn't exist", "error_code": "D1004"},
                status=400,
            )
