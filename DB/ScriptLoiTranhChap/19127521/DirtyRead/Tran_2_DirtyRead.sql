declare @Gia int
exec sp_XemSanPham 'SP0001', @Gia out
print N'Giá của sản phẩm là: ' + cast(@Gia as varchar(20))
