from django.db import models

class Transaction(models.Model):
    TYPE_CHOICES = (
        ('Credit', 'Credit'),
        ('Debit', 'Debit'),
    )

    type = models.CharField(max_length=10, choices=TYPE_CHOICES)
    amount = models.FloatField()
    description = models.CharField(max_length=200)

    def __str__(self):
        return f"{self.type} - {self.amount}"
