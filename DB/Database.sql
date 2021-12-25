-- Subject: DBMS

create database QLDatChuyenHang
go

use QLDatChuyenHang
go

-- Tạo bảng và khóa chính
create table KHACHHANG
(
	MaKH char(6),
	HoTen nvarchar(30),
	SoDT char(10),
	DiaChi nvarchar(100),
	EmailKH varchar(30),
	TenTaiKhoan varchar(20),
	constraint PK_KHACHHANG primary key(MaKH)
)

create table DONHANG
(
	MaDH char(8),
	HinhThucThanhToan nvarchar(20),
	DiaChiGiaoHang nvarchar(100),
	KhuVucGiaoHang nvarchar(30),
	PhiSP int,
	PhiVC int,
	TinhTrangVanChuyen nvarchar(20),
	MaKhachHang char(6),
	MaTaiXe char(6),
	MaDoiTac char(6),
	constraint PK_DONHANG primary key(MaDH)
)

create table CT_DONHANG
(
	MaDonHang char(8),
	MaSanPham char(6),
	SoLuong int,
	DonGia int,
	constraint PK_CT_DONHANG primary key(MaDonHang, MaSanPham)
)

create table DOITAC
(
	MaDT char(6),
	TenDoiTac nvarchar(30),
	NguoiDaiDien nvarchar(30),
	ThanhPho nvarchar(15),
	Quan nvarchar(15),
	SoChiNhanh int,
	SoDonHangMoiNgay int,
	LoaiHang nvarchar(20),
	DiaChiKD nvarchar(100),
	SDT char(10),
	Email varchar(30),
	TenTaiKhoan varchar(20),
	constraint PK_DOITAC primary key(MaDT)
)

create table HOPDONG
(
	MaHD char(6),
	MaSoThue varchar(10),
	SoChiNhanhDK int,
	TinhTrangPhiKichHoat bit,
	PhiHoaHong int,
	NgayBD date,
	NgayKT date,
	MaDoiTac char(6),
	TinhTrangDuyet bit,
	constraint PK_HOPDONG primary key(MaHD)
)

create table CHINHANH
(
	MaDoiTac char(6),
	STT int,
	DiaChi nvarchar(100),
	MaHopDong char(6),
	constraint PK_CHINHANH primary key(MaDoiTac,STT)
)

create table SANPHAM
(
	MaSP char(6),
	TenSanPham nvarchar(50),
	Gia int,
	MaDoiTac char(6),
	STT int,
	constraint PK_SANPHAM primary key(MaSP)
)


create table TAIXE
(
	MaTX char(6),
	HoTen nvarchar(30),
	CMND char(12),
	SoDT varchar(12),
	DiaChi nvarchar(100),
	BienSoXe varchar(10),
	KhuVucHoatDong nvarchar(30),
	Email varchar(64),
	MaTaiKhoanNganHang varchar(17),
	TenTaiKhoan varchar(20),
	constraint PK_TAIXE primary key(MaTX)
)

create table TAIKHOAN
(
	TenTK varchar(20),
	MatKhau varchar(20),
	PhanLoai char(2),
	TinhTrangKhoa varchar(8) DEFAULT 'Chua cap',
	constraint PK_TAIKHOAN primary key(TenTK)
)

create table NHANVIEN
(
	MaNV char(6),
	HoTen nvarchar(30),
	TenTaiKhoan varchar(20),
	constraint PK_NHANVIEN primary key(MaNV)
)

create table ADMINISTRATOR
(
	MaAdministrator char(6),
	HoTen nvarchar(30),
	TenTaiKhoan varchar(20),
	constraint PK_ADMIN primary key(MaAdministrator)
)


-- Tạo khóa ngoại
alter table KHACHHANG
add constraint FK_KHACHHANG_TAIKHOAN
foreign key(TenTaiKhoan)
references TAIKHOAN(TenTK)

alter table DONHANG
add constraint FK_DONHANG_KHACHHANG
foreign key(MaKhachHang)
references KHACHHANG(MaKH)

alter table DONHANG
add constraint FK_DONHANG_TAIXE
foreign key(MaTaiXe)
references TAIXE(MaTX)

alter table DONHANG
add constraint FK_DONHANG_DOITAC
foreign key (MaDoiTac)
references DOITAC(MaDT)

alter table CT_DONHANG
add constraint FK_CT_DONHANG_DONHANG
foreign key (MaDonHang)
references DONHANG(MaDH)

alter table CT_DONHANG
add constraint FK_CT_DONHANG_SANPHAM
foreign key (MaSanPham)
references SANPHAM(MaSP)

alter table DOITAC
add constraint FK_DOITAC_TAIKHOAN
foreign key(TenTaiKhoan)
references TAIKHOAN(TenTK)

alter table HOPDONG
add constraint FK_HOPDONG_DOITAC
foreign key(MaDoiTac)
references DOITAC(MaDT)

alter table CHINHANH
add constraint FK_CHINHANH_DOITAC
foreign key(MaDoiTac)
references DOITAC(MaDT)

alter table CHINHANH
add constraint FK_CHINHANH_HOPDONG
foreign key(MaHopDong)
references HOPDONG(MaHD)

alter table SANPHAM
add constraint FK_SANPHAM_CHINHANH
foreign key(MaDoiTac,STT)
references CHINHANH(MaDoiTac,STT)

alter table TAIXE
add constraint FK_TAIXE_TAIKHOAN
foreign key(TenTaiKhoan)
references TAIKHOAN(TenTK)

alter table NHANVIEN
add constraint FK_NHANVIEN_TAIKHOAN
foreign key(TenTaiKhoan)
references TAIKHOAN(TenTK)

alter table ADMINISTRATOR
add constraint FK_ADMINISTRATOR_TAIKHOAN
foreign key(TenTaiKhoan)
references TAIKHOAN(TenTK)

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
values ('DH000001',1000,N'Đang chờ tài xế','KH0001',NULL,'DT0001'),
		('DH000002',1000,N'Đang chờ tài xế','KH0001',NULL,'DT0001'),
		('DH000003',1000,N'Đang chờ tài xế','KH0001',NULL,'DT0001'),
		('DH000004',1000,N'Đang chờ tài xế','KH0001',NULL,'DT0001')

insert into CT_DONHANG(MaDonHang,MaSanPham,SoLuong)
values ('DH000001','SP0001',1),
		('DH000001','SP0002',2),				
		('DH000002','SP0001',3),
		('DH000002','SP0002',4)
		
/*use master
go
drop database QLDatChuyenHang*/
