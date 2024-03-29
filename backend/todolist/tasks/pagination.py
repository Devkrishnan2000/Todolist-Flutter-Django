from rest_framework import pagination


class CustomPagination(pagination.PageNumberPagination):
    page_size = 5  # default page size
    page_size_query_param = "page_size"
    max_page_size = 50  # max page size

class LimitPagination(pagination.LimitOffsetPagination):
    default_limit = 5