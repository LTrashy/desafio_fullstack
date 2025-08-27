import pytest
from events.models import Event
from datetime import datetime, timezone

@pytest.mark.django_db
def test_create_event():
    event = Event.objects.create(
        title="Concierto",
        description="Rock en vivo",
        date=datetime(2025, 9, 1, 20, 0, tzinfo=timezone.utc),
        lat=4.711,
        lng=-74.072,
        address="Parque Simón Bolívar, Bogotá"
    )
    assert event.id is not None
    assert event.title == "Concierto"
