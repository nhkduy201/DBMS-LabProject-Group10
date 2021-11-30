declare @TongThuNhap int
declare @TongSoDonHangNhan int
exec sp_LayThongTinTX 'TX0002', @TongThuNhap out, @TongSoDonHangNhan out
print @TongThuNhap
print @TongSoDonHangNhan