from django.shortcuts import render, redirect
from .models import Transaction

def home(request):
    transactions = Transaction.objects.all()

    total_balance = 0
    for t in transactions:
        if t.type == "Credit":
            total_balance += t.amount
        else:
            total_balance -= t.amount

    if request.method == "POST":
        type_ = request.POST.get("type")
        amount = request.POST.get("amount")
        description = request.POST.get("description")

        if type_ and amount:
            Transaction.objects.create(
                type=type_,
                amount=float(amount),
                description=description
            )
            return redirect("home")

    context = {
        "transactions": transactions,
        "total_balance": total_balance
    }

    return render(request, "index.html", context)


def reset_balance(request):
    Transaction.objects.all().delete()
    return redirect("home")


def reset_history(request):
    Transaction.objects.all().delete()
    return redirect("home")
