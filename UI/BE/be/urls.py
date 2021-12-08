"""be URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from . import views
from django.conf.urls import url

urlpatterns = [
    path('admin/', admin.site.urls),
    path('lay-don-hang/', views.layTatCaDonHang),
    path('lay-don-hang-chua-nhan/', views.layDonHangChuaDuocNhan),
    path('nhan-don-hang/', views.nhanHoaDon),
    path('lay-ma-tai-xe/', views.layMaTaiXe),
    path('lay-thong-tin/', views.layThongTin)
    # url(r'^hoadon/([0-9]+)$', views.gethoadon),
    # url(r'^hoadon/', views.posthoadon),
    # path('statistic_detail/', views.getRequest)
]
