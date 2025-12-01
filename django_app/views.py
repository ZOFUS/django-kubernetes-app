from django.http import HttpResponse
import socket

def home(request):
    # Эта функция возвращает имя хоста (имя пода)
    return HttpResponse(f"Я работаю на Pod Hostname: {socket.gethostname()}")
