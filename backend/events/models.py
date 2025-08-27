from django.db import models

class Event(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    date = models.DateTimeField(db_index=True)
    lat = models.FloatField()
    lng = models.FloatField()
    address = models.CharField(max_length=255)
    organizer = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.title
