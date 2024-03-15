from django.db import models
from accounts.models import User

# Create your models here.
class Task(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE, null=False)
    title = models.CharField(max_length=50, null=False)
    description = models.CharField(max_length=500, null=False)
    date = models.DateTimeField()
    completed = models.BooleanField(default=False)
    created_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "task"
