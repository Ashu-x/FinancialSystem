from django.shortcuts import render, redirect
from .models import Transaction

def index(request):
    if request.method == "POST":
        t_type = request.POST.get("type")
        amount = request.POST.get("amount")
        description = request.POST.get("description")

        if t_type and amount and description:
            Transaction.objects.create(
                type=t_type,
                amount=int(amount),
                description=description
            )
            return redirect("/")

    transactions = Transaction.objects.all()

    total_balance = 0
    for t in transactions:
        if t.type == "Credit":
            total_balance += t.amount
        else:
            total_balance -= t.amount

    context = {
        "transactions": transactions,
        "total_balance": total_balance,
        "abs_balance": abs(total_balance),  # 👈 YAHI FIX
    }

    return render(request, "index.html", context)
