declare @rt int
exec @rt = sp_CapNhatSanPham 'SP0001', 600
if @rt = 1 
	print N'Cập nhật thất bại.'
else
	print N'Cập nhật thành công.'
