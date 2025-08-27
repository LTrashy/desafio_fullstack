import pytest
from django.urls import reverse
from django.utils import timezone
from datetime import datetime

from events.models import Event


@pytest.mark.django_db
def test_events_list_pagination(client):
    # crea 15 eventos
    for i in range(15):
        Event.objects.create(
            title=f"E{i}",
            description="d",
            date=timezone.make_aware(datetime(2025, 8, (i % 28) + 1, 12, 0)),
            lat=4.7, lng=-74.07, address="A"
        )

    url = reverse("events-list") + "?page=2&size=10"
    resp = client.get(url)
    assert resp.status_code == 200
    data = resp.json()
    # DRF por defecto retorna estructura con resultados si usas pagination class global.
    # Aquí, usando PageNumberPagination en la vista, el formato es:
    # { "count": N, "next": "...", "previous": "...", "results": [ ... ] }
    assert "results" in data
    assert len(data["results"]) == 5  # 15 totales -> página 2 con size 10 = 5


@pytest.mark.django_db
def test_events_list_date_range_filter(client):
    # dentro del rango (agosto)
    Event.objects.create(
        title="In", description="d",
        date=timezone.make_aware(datetime(2025, 8, 10, 10, 0)),
        lat=4.7, lng=-74.07, address="A"
    )
    # fuera del rango (septiembre)
    Event.objects.create(
        title="Out", description="d",
        date=timezone.make_aware(datetime(2025, 9, 1, 10, 0)),
        lat=4.7, lng=-74.07, address="A"
    )

    url = reverse("events-list") + "?from=2025-08-01&to=2025-08-31"
    resp = client.get(url)
    assert resp.status_code == 200
    data = resp.json()["results"]
    titles = {e["title"] for e in data}
    assert "In" in titles
    assert "Out" not in titles


@pytest.mark.django_db
def test_events_detail(client):
    ev = Event.objects.create(
        title="Concierto en el Parque",
        description="Música en vivo al aire libre",
        date=timezone.make_aware(datetime(2025, 9, 1, 20, 0)),
        lat=4.711, lng=-74.072, address="Parque Simón Bolívar, Bogotá"
    )
    url = reverse("events-detail", args=[ev.id])
    resp = client.get(url)
    assert resp.status_code == 200
    data = resp.json()
    assert data["id"] == ev.id
    assert data["location"]["lat"] == 4.711
    assert data["location"]["address"].startswith("Parque Simón")
