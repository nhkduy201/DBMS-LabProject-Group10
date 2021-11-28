	--select * from DONHANG

create proc NhanDonHangFix1
@MaTX char(6), @MaDH char(8)
as 
begin
	set transaction isolation level repeatable read
	begin tran
		declare @MaTaiXe char(6)
		select @MaTaiXe = MaTaiXe from DONHANG where MaDH = @MaDH
		waitfor delay '00:00:10'
		if @MaTaiXe is null
		begin
			update DONHANG
			set MaTaiXe = @MaTX
			where MaDH = @MaDH
		end
		else
			rollback tran
	commit tran
	set transaction isolation level read committed
end
exec NhanDonHangFix1 @MaTX = 'TX0001', @MaDH = 'DH0001'
go
create proc NhanDonHangFix2
@MaTX char(6), @MaDH char(8)
as 
begin
	set transaction isolation level repeatable read
	begin tran
		declare @MaTaiXe char(6)
		select @MaTaiXe = MaTaiXe from DONHANG where MaDH = @MaDH
		waitfor delay '00:00:01'
		if @MaTaiXe is null
		begin
			update DONHANG
			set MaTaiXe = @MaTX
			where MaDH = @MaDH
		end
		else
			rollback tran
	commit tran
	set transaction isolation level read committed
end
exec NhanDonHangFix2 @MaTX = 'TX0002', @MaDH = 'DH0001'
--select * from DONHANG
--update DONHANG set MaTaiXe = null where MaDH = 'DH0001'