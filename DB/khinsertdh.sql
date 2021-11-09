use QLDatChuyenHang
go
--alter
create 
proc SP_InsertDonHang
@HinhThucThanhToan nvarchar(20),@DiaChiGiaoHang nvarchar(100), @KhuVucGiaoHang nvarchar(30),@TenDoiTac nvarchar(30)
as
begin
	declare @maxmadhint int;
	select @maxmadhint = max(cast(substring(MaDH,3, 6) as int)) from DONHANG
	if @maxmadhint = 9999
		return
	set @maxmadhint = @maxmadhint + 1
	declare @madh char(6) = 'DH' + right('000000' + cast(@maxmadhint as varchar(4)), 4)
	declare @madoitac char(6)
	select @madoitac = MaDT from DOITAC dt where @TenDoiTac = dt.TenDoiTac
	insert into DONHANG(MaDH,DiaChiGiaoHang,KhuVucGiaoHang,MaDoiTac)
	values (@madh, @DiaChiGiaoHang,@KhuVucGiaoHang, @madoitac)
end

GRANT EXECUTE ON SP_InsertDonHang TO KHACHHANG

--exec SP_InsertDonHang @HinhThucThanhToan = 'tien mat',@DiaChiGiaoHang ='abc', @KhuVucGiaoHang = 'def' ,@TenDoiTac = 'doitac1'
--select * from DONHANG