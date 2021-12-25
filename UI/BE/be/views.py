from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import pyodbc
import json

server_name = 'OLDLAP'  


def get_conn_cursor():
    conn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
                          f"Server={server_name};"
                          "Database=QLDatChuyenHang;"
                          "Trusted_Connection=yes;")
    return (conn, conn.cursor())

@csrf_exempt
def layTatCaDonHang(request):
    cursor = get_conn_cursor()[1]
    cursor.execute(
        f"select MaDH, PhiVC, MaTaiXe from DONHANG"
    )
    columns = [column[0] for column in cursor.description]
    results = []
    for row in cursor.fetchall():
        results.append(dict(zip(columns, row)))
    return JsonResponse({'res': results})

@csrf_exempt
def layDonHangChuaDuocNhan(request):
    cursor = get_conn_cursor()[1]
    cursor.execute("select MaDH from DONHANG where MaTaiXe is null")
    columns = [column[0] for column in cursor.description]
    results = []
    for row in cursor.fetchall():
        results.append(dict(zip(columns, row)))
    return JsonResponse({'res': results})

@csrf_exempt
def nhanHoaDon(request):
    data = json.loads(request.body)
    conn, cursor = get_conn_cursor()
    if data['type'] == '1':
        sp = 'sp_NhanDonHang'
    if data['type'] == '2':
        sp = 'sp_NhanDonHangFix'
    if data['type'] == '3':
        sp = 'sp_NhanDonHangKhongCoTestTime'
    try:
        cursor.execute(f"exec {sp} @MaTX = '{data['matx']}', @MaDH = '{data['madh']}'")
        conn.commit()
    except Exception:
        print("Some errors occur!!!")
        return JsonResponse({'msg': 'Có lỗi xảy ra!!!'}) 
    return JsonResponse({'msg': 'Đã nhận'})

@csrf_exempt
def layMaTaiXe(request):
    cursor = get_conn_cursor()[1]
    cursor.execute('select MaTX from TAIXE')
    columns = [column[0] for column in cursor.description]
    results = []
    for row in cursor.fetchall():
        results.append(dict(zip(columns, row)))
    return JsonResponse({'res': results})

@csrf_exempt
def layThongTin(request):
    data = json.loads(request.body)
    cursor = get_conn_cursor()[1]
    sp = 'sp_LayThongTinTX'
    if data['isfix']:
        sp = 'sp_LayThongTinTXFix'
    cursor.execute(f'''declare @TongThuNhap int
declare @TongSoDonHangNhan int
exec {sp} '{data['matx']}', @TongThuNhap out, @TongSoDonHangNhan out
select @TongThuNhap as tongtien, @TongSoDonHangNhan as sldonhang''')
    x = cursor.fetchone()
    return JsonResponse({'tongtien': x[0], 'sldonhang':  x[1]})

@csrf_exempt
def doiGiaSP(request):
    data = json.loads(request.body)
    conn, cursor = get_conn_cursor()
    cursor.execute(f"exec sp_CapNhatSanPham '{data['masp']}', {data['gia']}")
    conn.commit()
    msg = u'Đổi thành công'
    if int(data['gia']) > 100000000:
        msg = u'Đổi không thành công'
    return JsonResponse({'msg': msg})

@csrf_exempt
def xemGiaSP(request):
    data = json.loads(request.body)
    cursor = get_conn_cursor()[1]
    sp = 'sp_XemSanPham'
    if data['isfix']:
        sp = 'sp_XemSanPhamFix'
    cursor.execute(f'''declare @Gia int
exec {sp} '{data['masp']}', @Gia out
select @Gia as Gia''')
    return JsonResponse({'gia': cursor.fetchone()[0]})

# @csrf_exempt
# def gethoadon(request, page):
#     page = int(page)
#     hoadonperpage = 10
#     cursor = get_conn_cursor()[1]
#     cursor.execute(
#         f"select top({hoadonperpage}) * from HoaDon where MaHD not in (select top({page * hoadonperpage}) MaHD from HoaDon order by MaHD) order by MaHD"
#     )
#     columns = [column[0] for column in cursor.description]
#     results = []
#     for row in cursor.fetchall():
#         results.append(dict(zip(columns, row)))
#     return JsonResponse({'hoadons': results})


# @csrf_exempt
# def posthoadon(request):
#     data = json.loads(request.body)
#     hoadon = data['hoadon']
#     chitiets = data['cthoadon']
#     conn, cursor = get_conn_cursor()
#     cursor.execute(
#         f"insert into HoaDon(MaHD, MaKH, NgayLap, TongTien) values ('{hoadon['MaHD']}','{hoadon['MaKH']}','{hoadon['NgayLap']}', {int(hoadon['TongTien'])})"
#     )
#     for i in range(len(chitiets)):
#         cursor.execute(
#             f"insert into CT_HoaDon(MaHD,MaSP,SoLuong,GiaBan,GiaGiam,ThanhTien) values ('{chitiets[i]['MaHD']}','{chitiets[i]['MaSP']}',{chitiets[i]['SoLuong']}, {chitiets[i]['GiaBan']},{chitiets[i]['GiaGiam']},{chitiets[i]['ThanhTien']})"
#         )
#     conn.commit()
#     return JsonResponse({"msg": "OK"})


# @csrf_exempt
# def getRequest(request):
#     results = request.GET.get('month_year')
#     parse = results.split('/')
#     month = int(parse[0])
#     year = int(parse[1])
#     cursor = get_conn_cursor()[1]
#     cursor.execute(
#         f"select * from HoaDon where Month(NgayLap) = {month} and Year(NgayLap) = {year}"
#     )
#     dictionary = {
#         'mahd': '',
#         'makh': '',
#         'ngaylap': '',
#         'tongtien': '',
#         'tongdoanhthu': 0
#     }
#     count = 1
#     for row in cursor:
#         dictionary['mahd'] += row.MaHD + " "
#         dictionary['makh'] += row.MaKH + " "
#         dictionary['ngaylap'] += row.NgayLap.strftime(
#             "%Y/%m/%d, %H:%M:%S") + "; "
#         dictionary['tongtien'] += str(row.TongTien) + " "
#         dictionary['tongdoanhthu'] += row.TongTien
#         count += 1
#     dictionary['soluong'] = count - 1
#     return render(request, 'statistic_detail.html', dictionary)