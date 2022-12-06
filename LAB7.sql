CREATE function FN_Age(@MaNV nvarchar(9))
	returns int
as
begin
	return(
		select DATEDIFF(year, NGSINH, GETDATE()) + 1 from NHANVIEN where MaNV =@MaNV
	);
end
select [dbo].[Fn_Age]('005');
select * from NHANVIEN 
CREATE function FN_TongDeAn(
		@MaNV nvarchar(9)
	)
	returns int
as
begin
	return(select count(mada) from PHANCONG where MA_NVIEN = @MaNV);
end;
select [dbo].[Fn_TongSoDeAn]('005');
select * from PHANCONG;
CREATE function FN_ThongKePhai(
		@Phai nvarchar(3)
	)
	returns int
as
begin
	return(select count(manv) from NHANVIEN where PHAI= @Phai);
end
select [dbo].[FN_ThongKePhai](N'Nữ');
CREATE function	FN_LuongLB(
		@TenPhong	nvarchar(30)
	)
	returns int
as
begin
	return(
		select AVG(b.luong) from PHONGBAN a inner join NHANVIEN b on a.MAPHG = b.PHG
			where TENPHG like '%' + @TenPhong + '%'
	)
select HONV, TENLOT, TENNV from NHANVIEN a inner join PHONGBAN b on  a.MAPHG = b.MAPHG
end;
	where luong > [dbo]. [FN_LuongLB] (N'Quản Lý') and  TENPHG  like  N'%Quản Lý%';
CREATE function FN_ThongTinPhongDeAn
	(@MaPhg int)
	return  @List table (TenPhong nvarchar(15), TenTruongPhong nvarchar(30), SoLuongDeAn int)
as
begin
	insert into @List 
		select a.TENPHG, b.HONV + ' ' + b.TENNV ,
			(select count(c.MADA) from  DEAN c where c.PHONG = a.MAPHG)
			from PHONGBAN a  inner join NHANVIEN b on a.MAPHG = b.PHG; 
	return;
end;
select  = from [dbo].[FN_ThongTinPhongDeAn](1);
--BÀI 2:
--Hiển thị thông tin HoNV,TenNV,TenPHG, DiaDiemPhg.
SELECT TENPHG FROM PHONGBAN
INNER JOIN DIADIEM_PHG ON DIADIEM_PHG.MAPHG= PHONGBAN.MAPHG
INNER JOIN NHANVIEN ON NHANVIEN.PHG = PHONGBAN.MAPHG

CREATE VIEW V_DD_PHONGBAN
AS
SELECT HONV,TENNV, TENPHG, DIADIEM_PHG FROM PHONGBAN
INNER JOIN DIADIEM_PHG ON DIADIEM_PHG.MAPHG = PHONGBAN.MAPHG
INNER JOIN NHANVIEN ON NHANVIEN.PHG =PHONGBAN,MAPHG

SELECT * FROM V_DD_PHONGBAN

--Hiển thị thông tin TenNv, Lương, Tuổi.

SELECT TENNV,LUONG,YEAR (GETDATE())-YEAR(NGSINH) AS 'TUOI' FROM NHANVIEN

CREATE VIEW V_TUOINV
AS
SELECT TENNV,LUONG,YEAR (GETDATE())-YEAR(NGSINH) AS 'TUOI' FROM NHANVIEN

SELECT * FROM V_TUOINV

--Hiển thị tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất
SELECT TOP(1) TENPHG,TRPHG,B.HONV,+' '+B.TENLOT+' '+B.TENNV AS 'TENTP',COUNT(A.MANV) AS 'SOLUONGNV' FROM NHANVIEN A
INNER JOIN PHONGBAN ON PHONGBAN.MAPHG = A.PHG
INNER JOIN NHANVIEN B ON B.MANV = PHONGBAN.TRPHG
GROUP BY TRPHG,TENPHG,B.TENNV,B.HONV,B.TENLOT
ORDER BY SOLUONGNV DESC

CREATE VIEW V_TOPSOLUONGNV_PB
AS
SELECT TOP(1) TENPHG,TRPHG,B.HONV,+' '+B.TENLOT+' '+B.TENNV AS 'TENTP',COUNT(A.MANV) AS 'SOLUONGNV' FROM NHANVIEN A
INNER JOIN PHONGBAN ON PHONGBAN.MAPHG = A.PHG
INNER JOIN NHANVIEN B ON B.MANV = PHONGBAN.TRPHG
GROUP BY TRPHG,TENPHG,B.TENNV,B.HONV,B.TENLOT
ORDER BY SOLUONGNV DESC

SELECT * FROM V_TOPSOLUONGNV_PB