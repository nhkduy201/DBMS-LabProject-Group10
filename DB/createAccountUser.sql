--alter
create procedure CreateLoginUser
as
declare @TenTK varchar(20)
declare @MatKhau varchar(20)
declare @createlogin varchar(200)
declare @createuser varchar(200)
while exists(select *
from TAIKHOAN TK
where TK.TinhTrangKhoa = 'Chua cap')
		begin
	select top(1)
		@TenTK = TK.TenTK, @MatKhau = TK.MatKhau
	from TAIKHOAN TK
	where TK.TinhTrangKhoa = 'Chua cap'
	update TAIKHOAN
			set TinhTrangKhoa = 'Da cap'
			where TenTK = @TenTK and MatKhau = @MatKhau
	set @createlogin = 'CREATE LOGIN ' + @TenTK + ' WITH PASSWORD=''' + @MatKhau + ''', CHECK_POLICY = OFF'
	set @createuser = 'CREATE USER ' + @TenTK + ' FOR LOGIN ' + @TenTK
	exec (@createlogin)
	exec (@createuser)
end
go
EXEC CreateLoginUser;