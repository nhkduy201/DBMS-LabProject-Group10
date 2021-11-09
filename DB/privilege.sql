use QLDatChuyenHang
go
exec sp_addrole 'DoiTac'
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
--Cấp quyền cho đối tác
grant insert on HOPDONG to DoiTac
grant insert on CHINHANH to DoiTac
grant insert on SANPHAM to DoiTac
grant update,delete on VDT_QLSANPHAM to DoiTac
grant select on VDT_QLDONHANG to DoiTac
grant update on VDT_CAPNHATDONHANG to DoiTac

exec sp_addrole 'KhachHang'
go
--Tạo view để khách hàng có thể theo dõi quá trình vận chuyển đơn hàng của mình
create view VKH_THEODOIDONHANG as
select MaDH , TinhTrangVanChuyen
from DONHANG dh join KHACHHANG kh on dh.MaKhachHang = kh.MaKH
				join TAIKHOAN tk on kh.TenTaiKhoan = tk.TenTK
where tk.TenTK = CURRENT_USER
go
--Cấp quyền cho khách hàng
--grant insert on DONHANG(MaDH,HinhThucThanhToan,DiaChiGiaoHang,TinhTrangVanChuyen,MaDoiTac) to KhachHang
--grant insert on CT_DONHANG(MaDonHang,MaSanPham,Soluong) to KhachHang
grant select on DOITAC(TenDoiTac) to KhachHang
grant select on SANPHAM(TenSanPham) to KhachHang
grant select on VKH_THEODOIDONHANG to KhachHang

exec sp_addrole 'TaiXe'
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
--Cấp quyền cho tài xế
grant select on VTX_XEMDONHANG to TaiXe
grant update on VTX_NHANDONHANG  to TaiXe
grant update on VTX_CAPNHATDONHANG to TaiXe
grant select on VTX_THEODOITHUNHAP to TaiXe








