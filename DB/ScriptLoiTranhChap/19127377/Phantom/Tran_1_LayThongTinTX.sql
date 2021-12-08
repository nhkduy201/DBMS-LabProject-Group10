declare @TongThuNhap int
declare @TongSoDonHangNhan int
exec sp_LayThongTinTX 'TX0002', @TongThuNhap out, @TongSoDonHangNhan out
select @TongThuNhap as tongtien, @TongSoDonHangNhan as sldonhang