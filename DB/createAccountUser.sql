use QLDatChuyenHang
go
alter
--create
procedure CreateLoginUser
as
declare @TenTK varchar(20)
declare @MatKhau varchar(20)
declare @PhanLoai char(2)
declare @Role varchar(9)
declare @createlogin varchar(200)
declare @createuser varchar(200)
declare @adusertorole varchar(200)
while exists(select *
from TAIKHOAN TK
where TK.TinhTrangKhoa = 'Chua cap')
		begin
	select top(1)
		@TenTK = TK.TenTK, @MatKhau = TK.MatKhau, @PhanLoai = TK.PhanLoai
	from TAIKHOAN TK
	where TK.TinhTrangKhoa = 'Chua cap'
	update TAIKHOAN
			set TinhTrangKhoa = 'Da cap'
			where TenTK = @TenTK and MatKhau = @MatKhau
	set @createlogin = 'CREATE LOGIN ' + @TenTK + ' WITH PASSWORD=''' + @MatKhau + ''', CHECK_POLICY = OFF'
	set @createuser = 'CREATE USER ' + @TenTK + ' FOR LOGIN ' + @TenTK
	if @PhanLoai = 'AD'
		set @Role = 'Admin'
	if @PhanLoai = 'NV'
		set @Role = 'NhanVien'
	if @PhanLoai = 'DT'
		set @Role = 'DoiTac'
	if @PhanLoai = 'KH'
		set @Role = 'KhachHang'
	if @PhanLoai = 'TX'
		set @Role = 'TaiXe'
	set @adusertorole = 'ALTER ROLE ' + @Role + ' ADD MEMBER ' + @TenTK + ';'
	exec (@createlogin)
	exec (@createuser)
	exec (@adusertorole)
	--exec sp_addrolemember @Role ,@TenTK
end
go
EXEC CreateLoginUser;