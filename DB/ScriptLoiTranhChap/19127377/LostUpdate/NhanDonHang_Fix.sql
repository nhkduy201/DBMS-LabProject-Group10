create proc NhanDonHang
@MaTX char(6), @MaDH char(8)
as 
begin
	--set transaction isolation level repeatable read
	begin tran
		begin try
			declare @MaTaiXe char(6)
			select @MaTaiXe = MaTaiXe from DONHANG with (xlock) where MaDH = @MaDH
			--test
			waitfor delay '00:00:10'
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