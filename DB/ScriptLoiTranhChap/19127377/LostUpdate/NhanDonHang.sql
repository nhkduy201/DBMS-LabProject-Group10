--alter
create
proc sp_NhanDonHang
	@MaTX char(6),
	@MaDH char(8)
as
begin
	begin tran
	begin try
			declare @MaTaiXe char(6)
			select @MaTaiXe = MaTaiXe
	from DONHANG
	where MaDH = @MaDH
			--test
			waitfor delay '00:00:05'
			-------------
			if @MaTaiXe is null
			begin
		update DONHANG
				set MaTaiXe = @MaTX
				where MaDH = @MaDH
	end
			else
				rollback tran
		end try
		begin catch
			print N'lỗi hệ thống'
			rollback tran
		end catch
	commit tran
end