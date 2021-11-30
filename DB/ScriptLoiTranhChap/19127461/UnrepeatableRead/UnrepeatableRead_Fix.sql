use QLDatChuyenHang
go

--Khách hàng xem DS sản phẩm
create 
--alter 
proc XemDSSanPham_Fix (@MaDT char(6) )
as 
begin
	set transaction isolation level repeatable read
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
proc XoaSanPham_Fix ( @MaSP char(6) )
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