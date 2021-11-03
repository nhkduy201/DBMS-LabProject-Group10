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
	MaDonHang char(8),
	HinhThucThanhToan nvarchar(20),
	DiaChiGiaoHang nvarchar(100),
	PhiSP int,
	PhiVC int,
	TinhTrangVanChuyen nvarchar(20),
	MaKH char(6),
	MaTaiXe char(6),
	MaDT char(6),
	STT int,
	constraint PK_DONHANG primary key(MaDonHang)
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
	TenTaiKhoan varchar(10),
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
	MaDT char(6),
	STT int,
	DiaChi nvarchar(100),
	MaHopDong char(6),
	constraint PK_CHINHANH primary key(MaDT,STT)
)

create table SANPHAM
(
	MaSP char(6),
	TenSP nvarchar(50),
	Gia int,
	constraint PK_SANPHAM primary key(MaSP)
)

create table CUNGCAP
(
	MaDT char(6),
	STT int,
	MaSP char(6),
	constraint PK_CUNGCAP primary key(MaDT,STT,MaSP)
)

create table TAIXE
(
	MaTX char(6),
	-- ô Khang bổ sung thêm mấy thuộc tính còn lại nha
	-- t tạo table với PK trước để viết cái FK của bên t
	TenTaiKhoan varchar(20),
	constraint PK_TAIXE primary key(MaTX)
)

create table TAIKHOAN
(
	TenTaiKhoan varchar(20),
	-- ô Khang bổ sung thêm mấy thuộc tính còn lại nha
	-- t tạo table với PK trước để viết cái FK của bên t
	constraint PK_TAIKHOAN primary key(TenTaiKhoan)
)

-- Tạo khóa ngoại
alter table KHACHHANG
add constraint FK_KHACHHANG_TAIKHOAN
foreign key(TenTaiKhoan)
references TAIKHOAN(TenTaiKhoan)

alter table DONHANG
add constraint FK_DONHANG_KHACHHANG
foreign key(MaKH)
references KHACHHANG(MaKH)

alter table DONHANG
add constraint FK_DONHANG_TAIXE
foreign key(MaTaiXe)
references TAIXE(MaTX)

alter table DONHANG
add constraint FK_DONHANG_CHINHANH
foreign key (MaDT,STT)
references CHINHANH(MaDT,STT)

alter table CT_DONHANG
add constraint FK_CT_DONHANG_DONHANG
foreign key (MaDonHang)
references DONHANG(MaDonHang)

alter table CT_DONHANG
add constraint FK_CT_DONHANG_SANPHAM
foreign key (MaSanPham)
references SANPHAM(MaSP)

alter table HOPDONG
add constraint FK_HOPDONG_DOITAC
foreign key(MaDoiTac)
references DOITAC(MaDT)

alter table CHINHANH
add constraint FK_CHINHANH_DOITAC
foreign key(MaDT)
references DOITAC(MaDT)

alter table CHINHANH
add constraint FK_CHINHANH_HOPDONG
foreign key(MaHopDong)
references HOPDONG(MaHD)

alter table CUNGCAP
add constraint FK_CUNGCAP_CHINHANH
foreign key(MaDT,STT)
references CHINHANH(MaDT,STT)

alter table CUNGCAP
add constraint FK_CUNGCAP_SANPHAM
foreign key(MaSP)
references SANPHAM(MaSP)

alter table TAIXE
add constraint FK_TAIXE_TAIKHOAN
foreign key(TenTaiKhoan)
references TAIKHOAN(TenTaiKhoan)

/*use master
go
drop database QLDatChuyenHang*/
