use QLDatChuyenHang
go

--Khách hàng xem danh sách sản phẩm
create 
--alter 
proc XemDSSanPham (@MaDT char(6) )
as 
begin
	begin tran
		if not exists (select *
				from DOITAC
				where MaDT=@MaDT)
		begin
			print N'Đối tác ' + @MaDT + N' không tồn tại.'
			rollback tran
		end
		
		select sp.MaSP,sp.TenSanPham
		from SANPHAM sp
		where sp.MaDoiTac = @MaDT

		waitfor delay '00:00:10'

		select sp.MaSP,sp.TenSanPham
		from SANPHAM sp
		where sp.MaDoiTac = @MaDT
		
	commit tran
end
go

--Đối tác xóa sản phẩm
create 
--alter 
proc XoaSanPham ( @MaSP char(6) )
as 
begin
	begin tran
		if not exists (select *
				from SANPHAM
				where MaSP = @MaSP)
		begin
			print N'Sản phẩm ' + @MaSP + N' bạn muốn xóa không tồn tại.'
			rollback tran
		end

		delete from SANPHAM
		where MaSP = @MaSP
	commit tran
end
go