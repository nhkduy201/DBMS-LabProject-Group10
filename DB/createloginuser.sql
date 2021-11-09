use QLDatChuyenHang
go
drop proc SP_CreateLoginUser
go
create
procedure SP_CreateLoginUser
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
			where TenTK = @TenTK
	set @createlogin = 'CREATE LOGIN ' + @TenTK + ' WITH PASSWORD=''' + @MatKhau + ''', CHECK_POLICY = OFF'
	set @createuser = 'CREATE USER ' + @TenTK + ' FOR LOGIN ' + @TenTK
	if @PhanLoai = 'AD'
		set @Role = 'ADMINIS'
	if @PhanLoai = 'NV'
		set @Role = 'NHANVIEN'
	if @PhanLoai = 'DT'
		set @Role = 'DOITAC'
	if @PhanLoai = 'KH'
		set @Role = 'KHACHHANG'
	if @PhanLoai = 'TX'
		set @Role = 'TAIXE'
	set @adusertorole = 'ALTER ROLE ' + @Role + ' ADD MEMBER ' + @TenTK
	exec (@createlogin)
	exec (@createuser)
	exec (@adusertorole)
end
go
EXEC SP_CreateLoginUser;