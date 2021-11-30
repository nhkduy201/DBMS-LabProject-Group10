use	QLDatChuyenHang
go

--Thực hiện giao tác gây lỗi 
exec ThemSLSanPham2 'SP0001' , 5

--Thực hiện giao tác sau khi sửa lỗi
exec ThemSLSanPham2_Fix 'SP0001' , 5

