from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('reset_balance/', views.reset_balance, name='reset_balance'),
    path('reset_history/', views.reset_history, name='reset_history'),
]
