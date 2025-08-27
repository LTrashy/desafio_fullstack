import pytest
from django.urls import reverse
from events.models import Event
from datetime import datetime, timezone

@pytest.mark.django_db
def test_event_list(client):
    Event.objects.create(
        title="Concierto",
        description="Rock en vivo",
        date=datetime(2025, 9, 1, 20, 0, tzinfo=timezone.utc),
        lat=4.711,
        lng=-74.072,
        address="Parque Simón Bolívar, Bogotá",
        organizer="Steven"
    )

    url = reverse("event-list")
    response = client.get(url)
    assert response.status_code == 200
    data = response.json()
    assert len(data["results"]) == 1
    assert data["results"][0]["title"] == "Concierto"

@pytest.mark.django_db
def test_event_detail(client):
    event = Event.objects.create(
        title="Festival",
        description="Música electrónica",
        date=datetime(2025, 10, 5, 18, 0, tzinfo=timezone.utc),
        lat=4.65,
        lng=-74.05,
        address="Movistar Arena, Bogotá",
        organizer="DJ Test"
    )

    url = reverse("event-detail", args=[event.id])
    response = client.get(url)
    assert response.status_code == 200
    data = response.json()
    assert data["title"] == "Festival"
    assert data["address"] == "Movistar Arena, Bogotá"
