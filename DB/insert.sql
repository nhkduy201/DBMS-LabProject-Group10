use QLDatChuyenHang
go
insert into TAIKHOAN(TenTK,MatKhau,PhanLoai)
values ('ad1','123','AD'),
		('nv1','123','NV'),
		('dt1','123','DT'),
		('kh1','123','KH'),
		('tx1','123','TX')

insert into ADMINISTRATOR(MaAdministrator,HoTen,TenTaiKhoan)
values ('AD0001','admin1','ad1')

insert into NHANVIEN(MaNV,HoTen,TenTaiKhoan)
values ('NV0001','nhanvien1','nv1')

insert into DOITAC(MaDT,TenDoiTac,NguoiDaiDien,ThanhPho,Quan,TenTaiKhoan)
values ('DT0001','doitac1','A','TP HCM','Quan 1','dt1')

insert into HOPDONG(MaHD,MaDoiTac)
values ('HD0001','DT0001')

insert into CHINHANH(MaDoiTac,STT,MaHopDong)
values ('DT0001',1,'HD0001'),
		('DT0001',2,'HD0001')

insert into KHACHHANG(MaKH,HoTen,TenTaiKhoan)
values ('KH0001','khachhang1','kh1')

insert into TAIXE(MaTX,HoTen,KhuVucHoatDong,TenTaiKhoan)
values ('TX0001','taixe1','Quan 1','tx1')

insert into SANPHAM(MaSP,TenSanPham,Gia,MaDoiTac,STT)
values ('SP0001','sanpham1',100,'DT0001',1),
		('SP0002','sanpham2',200,'DT0001',2)

insert into DONHANG(MaDH,PhiVC,TinhTrangVanChuyen,MaKhachHang,MaTaiXe,MaDoiTac)
values ('DH0001',1000,N'Đang đóng gói','KH0001',NULL,'DT0001'),
		('DH0002',2000,N'Đang chờ tài xế','KH0001',NULL,'DT0001')

insert into CT_DONHANG(MaDonHang,MaSanPham,SoLuong)
values ('DH0001','SP0001',1),
		('DH0001','SP0002',2),				
		('DH0002','SP0001',3),
		('DH0002','SP0002',4)


		