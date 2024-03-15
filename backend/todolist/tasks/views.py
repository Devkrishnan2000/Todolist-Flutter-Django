from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.generics import ListAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from todolist.utils import ErrorHandling
from .serializer import TaskCreateSerializer,TaskViewSerializer
from .pagination import CustomPagination
from  .models import Task

import logging

logger = logging.getLogger("django")


class CreateTask(APIView):
    permission_classes = [
        IsAuthenticated,
    ]

    def post(self, request):
        data = request.data.copy()
        data["user"] = request.user.id
        serialized_data = TaskCreateSerializer(data=data)
        if serialized_data.is_valid():
            serialized_data.save()
            logger.info("Task created :" + str(serialized_data.data))
            return Response({"message": "task created"}, status=201)
        else:
            logger.warn("Validation failed")
            return Response(
                ErrorHandling.error_message_handling(self, serialized_data.errors),
                status=400,
            )

class ListTask(ListAPIView):
    permission_classes = [IsAuthenticated,]
    queryset = Task.objects.filter()
    serializer_class = TaskViewSerializer
    pagination_class = CustomPagination
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['completed']
    
    def get_queryset(self):
        user_id = self.request.user.id
        queryset = Task.objects.filter(user_id=user_id)
        return queryset