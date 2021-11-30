create proc sp_LayThongTinTX
	@MaTX char(6),
	@TongThuNhap int out,
	@TongSoDonHangNhan int out
as
begin
	begin tran
	begin try
			set @TongThuNhap = (select sum(PhiVC)
	from DONHANG
	where MaTaiXe = @MaTX)
			--test
			waitfor delay '00:00:10'
			-------------
			set @TongSoDonHangNhan = (select count(*)
	from DONHANG
	where MaTaiXe = 'TX0001')
			print @TongSoDonHangNhan
		end try
		begin catch
			print N'lỗi hệ thống'
			rollback tran
		end catch
	commit tran
end
go
create proc sp_NhanDonHang
	@MaTX char(6),
	@MaDH char(8)
as
begin
	begin tran
	begin try
			declare @MaTaiXe char(6)
			select @MaTaiXe = MaTaiXe
	from DONHANG with (xlock)
	where MaDH = @MaDH
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