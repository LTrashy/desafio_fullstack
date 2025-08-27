from rest_framework import generics
from rest_framework.pagination import PageNumberPagination
from django_filters.rest_framework import DjangoFilterBackend

from .models import Event
from .serializers import EventSerializer
from .filters import EventFilter  # lo defines en filters.py


class SizeQueryPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = "size"
    max_page_size = 100


class EventListView(generics.ListAPIView):
    queryset = Event.objects.all().order_by("date")
    serializer_class = EventSerializer
    pagination_class = SizeQueryPagination
    filter_backends = [DjangoFilterBackend]
    filterset_class = EventFilter


class EventDetailView(generics.RetrieveAPIView):
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    lookup_field = "pk"
