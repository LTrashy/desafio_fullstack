import random
from datetime import datetime, timedelta
from django.core.management.base import BaseCommand
from events.models import Event


class Command(BaseCommand):
    help = "Seed the database with random events"

    def add_arguments(self, parser):
        parser.add_argument('--total', type=int, default=100, help='Number of events to create')

    def handle(self, *args, **kwargs):
        total = kwargs['total']

        if Event.objects.exists():
            self.stdout.write(self.style.WARNING("Events already seeded, skipping..."))
            return

        titles = [
            "Concierto", "Conferencia", "Feria", "Exposicion", "Festival",
            "Reunion", "Taller", "Seminario", "Charla", "Presentacion"
        ]

        addresses = [
            "Calle 123 #45-67", "Carrera 7 #89-10", "Plaza Central",
            "Auditorio Principal", "Parque del Centro", "Biblioteca Nacional"
        ]

        for i in range(total):
            title = random.choice(titles) + f" {i+1}"
            description = f"Descripcion del evento {i+1}."
            date = datetime.now() + timedelta(days=random.randint(-100, 100))
            lat = random.uniform(-90, 90)
            lng = random.uniform(-180, 180)
            address = random.choice(addresses)

            Event.objects.create(
                title=title,
                description=description,
                date=date,
                lat=lat,
                lng=lng,
                address=address
            )

        self.stdout.write(self.style.SUCCESS(f"Successfully seeded {total} events!"))
