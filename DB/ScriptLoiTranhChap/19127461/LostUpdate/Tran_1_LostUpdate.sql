use	QLDatChuyenHang
go

--Xem Số lượng sản phẩm hiện có
select MaSP, SoLuong 
from SANPHAM 
where MaSP = 'SP0001'

--Thực hiện giao tác gây lỗi 
exec ThemSLSanPham1 'SP0001' , 4

--Thực hiện giao tác sau khi sửa lỗi
exec ThemSLSanPham1_Fix 'SP0001' , 4


--Kiểm tra lại số lượng sản phẩm
select MaSP, SoLuong 
from SANPHAM 
where MaSP = 'SP0001'