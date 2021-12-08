update DONHANG set MaTaiXe = null
update DONHANG set MaTaiXe = null where MaDH = 'DH000004'
select * from DONHANG
select MaTX from TAIXE
declare @TongThuNhap int
declare @TongSoDonHangNhan int
exec sp_LayThongTinTX 'TX0001', @TongThuNhap out, @TongSoDonHangNhan out
select @TongThuNhap as tongtien, @TongSoDonHangNhan as sldonhang
insert into DONHANG(MaDH,PhiVC,TinhTrangVanChuyen,MaKhachHang,MaTaiXe,MaDoiTac)
values ('DH000004',1000,N'Đang chờ tài xế','KH0001',NULL,'DT0001')