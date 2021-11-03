create database QLDatChuyenHang
go

use QLDatChuyenHang
go

-- tạo bảng và khóa chính
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
	primary key(MaDT,STT,MaSP)
)

-- tạo khóa ngoại
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

