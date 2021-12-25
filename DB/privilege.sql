use QLDatChuyenHang
go
exec sp_addrole 'DOITAC'
go
--Tạo view để đối tác chỉ có thể xóa, sửa SẢN PHẨM của chi nhánh mình
create view VDT_QLSANPHAM as
select TenSanPham,Gia,STT 
from SANPHAM sp join DOITAC dt on sp.MaDoiTac = dt.MaDT 
				join TAIKHOAN tk on dt.TenTaiKhoan = tk.TenTK
where tk.TenTK = CURRENT_USER
go
--Tạo view để đối tác chỉ có thể xem thông tin đơn hàng của mình
create view VDT_QLDONHANG as
select *
from DONHANG dh join DOITAC dt on dh.MaDoiTac = dt.MaDT 
				join TAIKHOAN tk on dt.TenTaiKhoan = tk.TenTK
where tk.TenTK = CURRENT_USER
go
--Tạo view để đối tác chỉ có thể cập nhật tình trạng đơn hàng của mình
create view VDT_CAPNHATDONHANG as
select TinhTrangVanChuyen
from DONHANG dh join DOITAC dt on dh.MaDoiTac = dt.MaDT 
				join TAIKHOAN tk on dt.TenTaiKhoan = tk.TenTK
where tk.TenTK = CURRENT_USER
go

--Cấp quyền cho DOITAC
grant update,delete on VDT_QLSANPHAM to DOITAC
grant select on VDT_QLDONHANG to DOITAC
grant update on VDT_CAPNHATDONHANG to DOITAC
go

exec sp_addrole 'KHACHHANG'
go

--Tạo view để khách hàng có thể theo dõi quá trình vận chuyển đơn hàng của mình
create view VKH_THEODOIDONHANG as
select MaDH , TinhTrangVanChuyen
from DONHANG dh join KHACHHANG kh on dh.MaKhachHang = kh.MaKH
				join TAIKHOAN tk on kh.TenTaiKhoan = tk.TenTK
where tk.TenTK = CURRENT_USER
go

--Cấp quyền cho KHACHHANG
grant select on DOITAC(TenDoiTac) to KHACHHANG
grant select on SANPHAM(TenSanPham) to KHACHHANG
grant select on VKH_THEODOIDONHANG to KHACHHANG
go

exec sp_addrole 'TAIXE'
go
--Tạo view để tài xế có thể xem các đơn hàng khu vực của minh
create view VTX_XEMDONHANG as
select MaDH,DiaChiGiaoHang,PhiVC
from DONHANG dh join TAIXE tx on dh.KhuVucGiaoHang = tx.KhuVucHoatDong  
				join TAIKHOAN tk on tx.TenTaiKhoan = tk.TenTK
where tk.TenTK = CURRENT_USER and dh.TinhTrangVanChuyen = N'Đang chờ tài xế'
go
--Tạo view để tài xế có thể nhận các đơn hàng khu vực của minh
create view VTX_NHANDONHANG as
select MaTaiXe
from DONHANG dh join TAIXE tx on dh.KhuVucGiaoHang = tx.KhuVucHoatDong  
				join TAIKHOAN tk on tx.TenTaiKhoan = tk.TenTK
where tk.TenTK = CURRENT_USER and dh.TinhTrangVanChuyen = N'Đang chờ tài xế'
go
--Tạo view để tài xế có thể chỉnh tình trạng vận chuyển đơn hàng mình nhận
create view VTX_CAPNHATDONHANG as
select TinhTrangVanChuyen
from DONHANG dh join TAIXE tx on dh.MaTaiXe = tx.MaTX
				join TAIKHOAN tk on tx.TenTaiKhoan = tk.TenTK
where tk.TenTK = CURRENT_USER 
go
--Tạo view để tài xế xem lại các đơn hàng đã nhận và phí VC tương ứng
create view VTX_THEODOITHUNHAP as
select MaDH,PhiVC
from DONHANG dh join TAIXE tx on dh.MaTaiXe = tx.MaTX 
				join TAIKHOAN tk on tx.TenTaiKhoan = tk.TenTK
where tk.TenTK = CURRENT_USER
go

--Cấp quyền cho TAIXE
grant select on VTX_XEMDONHANG to TAIXE
grant update on VTX_NHANDONHANG to TAIXE
grant update on VTX_CAPNHATDONHANG to TAIXE
grant select on VTX_THEODOITHUNHAP to TAIXE
go

exec sp_addrole 'NHANVIEN'
go
--Cấp quyền cho NHANVIEN
grant select on HOPDONG to NHANVIEN
grant update on HOPDONG (TinhTrangDuyet) to NHANVIEN
go

exec sp_addrole 'ADMINIS'
go
--Cấp quyền cho ADMINIS
grant insert, update on NHANVIEN to ADMINIS
grant select, delete on NHANVIEN to ADMINIS
grant insert, update on TAIKHOAN to ADMINIS
grant select, delete on TAIKHOAN to ADMINIS
grant insert, update on DOITAC to ADMINIS
grant select, delete on DOITAC to ADMINIS
grant insert, update on KHACHHANG to ADMINIS
grant select, delete on KHACHHANG to ADMINIS
grant insert, update on TAIXE to ADMINIS
grant select, delete on TAIXE to ADMINIS
grant insert, update on ADMINISTRATOR to ADMINIS with grant option
grant select, delete on ADMINISTRATOR to ADMINIS with grant option
go
