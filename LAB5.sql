CREATE PROCEDURE sp_bai1a	@name nvarchar(20) 
as
	begin
		print 'xin chào: '+ @name 
		end
exec sp_bai1a N'Quốc Kiệt '

--
CREATE PROCEDURE sp_bai1b @s1 int, @s2 int
as
	begin
		declare @tong int = 0;
		set @tong = @s1 + @s2
		print N'Tổng là: ' + cast(@tong as varchar(10))
	end

exec sp_bai1b 5,10
--
create procedure sp_bai1c @n int
as
	begin 
		declare @sum int = 0, @i int = 0;
		while @i <= @n
			begin
				set @sum = @sum + @i
				set @i= @i +2
			end
		print N'Tổng các số chẵn: ' + cast(@sum as varchar(10))
	end
exec sp_bai1c 10
--
create procedure sp_bai1d @a int, @b int
as
	begin
		while (@a != @b)
			begin
				if(@a > @b)
					set @a= @a - @b
				else
					set @b= @b - @a
			end
			return @a
	end

declare @c int
exec @c = sp_bai1d 7,5
print N'Ước chung lớn nhất : ' + cast(@c as varchar(100))


----bài 2----
Create proc sp_timNVTheoMa
	@MaSV nvarchar(9)
as
begin
	select = from NHANVIEN where MANV = @MANV;
end;
exec  sp_timNVTheoMa '005';

CREATE proc sp_TongNVThamGiaDA
	@MaDa int
as
begin
	select count(ma_nvien) as 'Số lượng' from PHANCONG where MADA =@MADA;
end
exec [dbo].[sp_TongNVThamGiaDA] 1;

CREATE proc sp_ThongleNVDeAn
	@MaDa int, @DDiem_DA nvarchar(15)
as
begin
	select count(b.ma_nvien) as 'số lượng'
		from DEAN a inner join PHANCONG b on a.MaDa = b.MADA 
		where a.MADA= @MaDa and  a.DDiem_DA = @DDiem_DA;
end;

exec [dbo].[sp_ThongleNVDeAn] 1, N'Vũng Tàu';
CREATE proc sp_TimNVTheoTP
	@TrPHg nvarchar(9)
as
begin
	select b.* from PHONGBAN a inner join NHANVIEN b on a.MAPHG = b.pHG
		where	a.TRPHG	= @TRPHG and
			not exists(select * from THANHNHAN where MANV =b.MANV0
end;

exec [dbo].[sp_TimNVTheoTP] '005'

------bài 3-----
CREATE PROC sp_InsertPB
	@MaPB int, @TenPB nvarchar(15),
	@MaTP nvarchar(9), @NgayNhanChuc date
AS
BEGIN
	if(exists(select * from PHONGBAN where MAPHG = @MaPB ))
		print 'Them that bai'
	else 
		begin
			insert into PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
			values(@MaPB, @TenPB,@MaTP,@NgayNhanChuc)
			print 'Them thanh cong'
		end
END

exec sp_InsertPB '8', 'CNTT', '008', '2020-10-06'
CREATE PROC sp_UpdatePB
	@MaPB int, @TenPB nvarchar(15),
	@MaTP nvarchar(9), @NgayNhanChuc date
AS
BEGIN
	if(exists(select * from PHONGBAN where MAPHG = @MaPB ))
		update PHONGBAN set TENPHG = @TenPB, TRPHG = @MaTP, NG_NHANCHUC = @NgayNhanChuc
		where MAPHG = @MaPB
	else 
		begin
			insert into PHONGBAN(MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
			values(@MaPB, @TenPB,@MaTP,@NgayNhanChuc)
			print 'Them thanh cong'
		end
END

exec sp_UpdatePB '8', 'IT', '008', '2020-10-06'
create proc sp_InsertNhanVien
	@HONV nvarchar(15), @TENLOT nvarchar(15), @TENNV nvarchar(15),
	@MANV nvarchar(6), @NGSINH date, @DCHI nvarchar(50), @PHAI nvarchar(3),
	@LUONG float, @MA_NQL nvarchar(3) = null, @PHG int
as
begin
	declare @age int 
	set @age = YEAR(GETDATE()) - YEAR (@NGSINH)
	if @PHG = (select MAPHG from PHONGBAN where TENPHG = 'IT')
		begin
			if @LUONG < 25000
				set @MA_NQL = '009'
			else set @MA_NQL = '005'

			if (@PHAI = 'Nam' and (@age >= 18 and @age <= 65))
				or (@PHAI = 'Nu' and (@age >= 18 and @age <= 60))
				begin
					insert into NHANVIEN(HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG)
					values (@HONV, @TENLOT, @TENNV, @MANV, @NGSINH, @DCHI, @PHAI, @LUONG, @MA_NQL, @PHG)
				end
			else 
				print 'Khong thuoc do tuoi lao dong'
		end
	else 
		print 'Khong phai Phong Ban IT'
end

exec sp_InsertNhanVien 'Nguyen', 'Van', 'Nam', '008', '2020-06-10', 'Da Nang', 'Nam', '25000', '004', '8'
exec sp_InsertNhanVien 'Nguyen', 'Van', 'Nam', '006', '2020-06-10', 'Da Nang', 'Nam', '25000', '004', '8'
exec sp_InsertNhanVien 'Nguyen', 'Van', 'Nu', '005', '1954-06-10', 'Da Nang', 'Nam', '25000', '004', '8'