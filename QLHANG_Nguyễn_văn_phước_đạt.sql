--tao bang vat tu
Create table  VatTu
(
 MaVT nvarchar(10) not null primary key,
 TenVT nvarchar(50),
 DVTinh char(10),
 SLCon int 
 )
 --tao bang HDBan
Create table HDBan
(
 MaHD nvarchar(10) not null primary key,
 HoTenKhach nvarchar(20),
 Ngayxuat date,
 )
 --tao bang HangXuat
Create table Hangxuat
(
 MaHD nvarchar(10)FOREIGN KEY references HDBan(MaHD),
 MaVT nvarchar(10)FOREIGN KEY references VatTu(MaVT),
 DonGia float,
 SLBan int
 )


--cau 2--
select top 1 (slban* dongia) as 'thong tien ', mahd 
 from  hangxuat
 order by [thong tien ] desc