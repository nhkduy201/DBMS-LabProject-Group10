declare @Gia int
exec sp_XemSanPhamFix 'SP0001', @Gia out
select @Gia as Gia
