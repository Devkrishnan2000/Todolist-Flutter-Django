from rest_framework import serializers
from .models import Task

class TaskCreateSerializer(serializers.ModelSerializer):
    title = serializers.CharField(
        max_length=50,
        min_length=4,
        required=True,
        allow_blank=False,
        error_messages={
            "required": "Title field is required+D1001",
            "blank": "Title field cannot be blank+D1001",
            "max_length": "Maximum 50 characters allowed in title+D1003",
            "min_length": "Minimum 4 characters are required in title+D1006"
        },
    )
    description = serializers.CharField(
        max_length=500,
        required=True,
        allow_blank=False,
        error_messages={
            "required": "Title field is required+D1001",
            "blank": "Title field cannot be blank+D1001",
            "max_length": "Maximum 500 characters allowed in description+D1003",
            "min_length": "Minimum 4 characters are required in description+D1006"
        },    
    )
    class Meta:
        model = Task
        fields =("title","description","date","user")
        
class TaskViewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Task
        fields = "__all__"
                
