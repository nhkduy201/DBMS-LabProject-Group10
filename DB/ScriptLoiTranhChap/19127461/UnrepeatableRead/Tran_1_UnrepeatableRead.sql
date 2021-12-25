use QLDatChuyenHang
go

--Thực hiện giao tác gây ra lỗi
exec XemDSSanPham 'DT0001'

--Thực hiện giao tác sau khi đã khắc phục lỗi
exec XemDSSanPham_Fix 'DT0001'

