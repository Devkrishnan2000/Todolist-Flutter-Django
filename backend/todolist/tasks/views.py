from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.generics import ListAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from todolist.utils import ErrorHandling
from .serializer import TaskCreateSerializer, TaskViewSerializer
from .pagination import CustomPagination,LimitPagination

from .models import Task

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
            task = serialized_data.save()
            logger.info("Task created :" + str(serialized_data.data))
            return Response({"message": "task created","task_id":task.id}, status=201)
        else:
            logger.warn(serialized_data.errors)
            return Response(
                ErrorHandling.error_message_handling(self, serialized_data.errors),
                status=400,
            )


class ListTask(ListAPIView):
    permission_classes = [
        IsAuthenticated,
    ]
    queryset = Task.objects.filter()
    serializer_class = TaskViewSerializer
    pagination_class = LimitPagination
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ["completed"]

    def get_queryset(self):
        user_id = self.request.user.id
        queryset = Task.objects.filter(user_id=user_id).order_by("-id")
        return queryset


class DeleteTask(APIView):
    permission_classes = [
        IsAuthenticated,
    ]

    def delete(self, request, task_id):
        try:
            task = Task.objects.get(id=task_id, user=request.user.id)
            task.delete()
            return Response({"message": "Task Deleted"}, status=200)
        except Task.DoesNotExist:
            return Response({"error": "D1007", "error_message": "Task doesn't exist"})


class CompleteTask(APIView):
    permission_classes = [
        IsAuthenticated,
    ]

    def put(self, request, task_id):
        try:
            task = Task.objects.get(id=task_id, user=request.user.id)
            task.completed = True
            task.save()
            return Response({"message": "Task Completed"}, status=200)
        except Task.DoesNotExist:
            return Response({"error": "D1007", "error_message": "Task doesn't exist"})
