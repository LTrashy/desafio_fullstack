import django_filters
from .models import Event


class EventFilter(django_filters.FilterSet):
    from_date = django_filters.DateFilter(field_name="date", lookup_expr="date__gte")
    to_date = django_filters.DateFilter(field_name="date", lookup_expr="date__lte")

    class Meta:
        model = Event
        fields = ["from_date", "to_date"]
