from rest_framework import serializers
from .models import Event


class EventSerializer(serializers.ModelSerializer):
    location = serializers.SerializerMethodField()

    class Meta:
        model = Event
        fields = ["id", "title", "description", "date", "location"]

    def get_location(self, obj):
        return {
            "lat": obj.lat,
            "lng": obj.lng,
            "address": obj.address,
        }
