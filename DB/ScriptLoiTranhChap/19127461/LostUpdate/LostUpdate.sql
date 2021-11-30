use	QLDatChuyenHang
go

alter table SANPHAM
add SoLuong int 

create
--alter
proc ThemSLSanPham1 (@MaSP char(6), @SLMuonThem int)
as
begin
	begin tran
		if not exists (select *
				from SANPHAM
				where MaSP = @MaSP)
		begin
			print N'Sản phẩm ' + @MaSP + N' không tồn tại.'
			rollback tran
		end

		if @SLMuonThem <= 0
		begin
			print N'Số lượng muốn thêm phải lớn hơn 0'
			rollback tran
		end

		declare @SL int
		set @SL = (select SoLuong 
					from SANPHAM 
					where MaSP = @MaSP)
		set @SL = @SL + @SLMuonThem

		waitfor delay '00:00:10'

		update SANPHAM
		set SoLuong = @SL
		where MaSP = @MaSP
	commit tran
end
go


create 
--alter
proc ThemSLSanPham2 (@MaSP char(6), @SLMuonThem int)
as
begin
	begin tran
		if not exists (select *
				from SANPHAM
				where MaSP = @MaSP)
		begin
			print N'Sản phẩm ' + @MaSP + N' không tồn tại.'
			rollback tran
		end

		if @SLMuonThem <= 0
		begin
			print N'Số lượng muốn thêm phải lớn hơn 0'
			rollback tran
		end

		declare @SL int
		set @SL = (select SoLuong 
					from SANPHAM 
					where MaSP = @MaSP)
		set @SL = @SL + @SLMuonThem

		waitfor delay '00:00:10'

		update SANPHAM
		set SoLuong = @SL
		where MaSP = @MaSP
	commit tran
end
go