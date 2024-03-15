# Generated by Django 5.0.3 on 2024-03-12 09:38

from django.db import migrations, models


class Migration(migrations.Migration):
    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="Task",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("title", models.CharField(max_length=50)),
                ("description", models.CharField(max_length=500)),
                ("date", models.DateTimeField()),
                ("completed", models.BooleanField()),
                ("created_date", models.DateTimeField(auto_now_add=True)),
            ],
            options={
                "db_table": "task",
            },
        ),
    ]
