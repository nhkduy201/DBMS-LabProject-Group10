use QLDatChuyenHang
go

--Đối tác cập nhật giá của sản phẩm
create
proc sp_CapNhatSanPham
	@MaSP char(6),
	@GiaCapNhat int
as
begin tran
	begin try
		if not exists (select *
				from SANPHAM
				where MaSP = @MaSP)
		begin
			print N'Sản phẩm ' + @MaSP + N' không tồn tại.'
			rollback tran
		end
			
		if @GiaCapNhat < 0
		begin
			print N'Giá cập nhật không hợp lệ.'
			rollback tran
		end
			
		update SANPHAM
		set Gia = @GiaCapNhat
		where MaSP = @MaSP
		waitfor delay '0:0:05'
		if exists (select Gia from SANPHAM where MaSP = @MaSP and Gia > 100000000) 
		begin
			raiserror (N'Giá sản phẩm không được vượt quá 100.000.000', 16, 1)
		end
		print N'Đổi thành công'
		commit tran
	end try
	begin catch
		print N'Đổi không thành công'
		rollback tran
	end catch
go


--Khách hàng đọc thông tin sản phẩm
create
proc sp_XemSanPhamFix
	@MaSP char(6),
	@GiaSP int out
as
--set tran isolation level read uncommitted
begin tran
begin try
		if not exists (select *
from SANPHAM
where MaSP = @MaSP)
	begin
		print N'Sản phẩm ' + @MaSP + N' không tồn tại.'
		rollback tran
	end
	set @GiaSP = (select Gia
	from SANPHAM
	where MaSP = @MaSP)
	end try
	-----------
	begin catch
		print N'Lỗi hệ thống'
		rollback tran
	end catch
	commit tran
go
