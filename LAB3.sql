--Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó.
SELECT DEAN.MADA, DEAN.TENDEAN, SUM(PHANCONG.THOIGIAN)
	FROM DEAN, PHANCONG
	WHERE DEAN.MADA = PHANCONG.MADA
	GROUP BY DEAN.MADA, DEAN.TENDEAN


--Xuất định dạng “tổng số giờ làm việc” kiểu decimal với 2 số thập phân.
select DEAN.TENDEAN, cast(sum(PHANCONG.THOIGIAN)  as decimal(5,2)) as 'Tổng giờ làm'
	from PHANCONG,DEAN
	where PHANCONG.MADA = DEAN.MADA
	group by DEAN.TENDEAN

--Xuất định dạng “tổng số giờ làm việc” kiểu varchar
	select DEAN.TENDEAN, cast(sum(PHANCONG.THOIGIAN)  as varchar(10)) as 'Tổng giờ làm'
	from PHANCONG,DEAN
	where PHANCONG.MADA = DEAN.MADA
	group by DEAN.TENDEAN



--Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
SELECT PHONGBAN.MAPHG, PHONGBAN.TENPHG, AVG(NHANVIEN.LUONG) AS 'Lương trung bình'
	FROM NHANVIEN, PHONGBAN
	WHERE NHANVIEN.PHG = PHONGBAN.MAPHG
	GROUP BY PHONGBAN.MAPHG, PHONGBAN.TENPHG




--Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu phẩy để phân biệt phần nguyên và phần thập phân.
	select TENPHG, cast(avg(LUONG) as decimal(10,2))
	as 'Lương trung bình' from NHANVIEN 
	inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
	group by TENPHG


--Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3 chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace
select TENPHG, left(cast(avg(LUONG) as varchar(10)) ,3)+ replace(cast(avg(LUONG) as varchar(10)), 
	left(cast(avg(LUONG) as varchar(10)) ,2),',')
	as 'Lương trung bình' from NHANVIEN 
	inner join PHONGBAN on NHANVIEN.PHG=PHONGBAN.MAPHG
	group by TENPHG


--Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc [một tuần] của tất cả các nhân viên tham dự đề án đó.
SELECT DEAN.MADA, DEAN.TENDEAN, SUM(PHANCONG.THOIGIAN)
	FROM DEAN, PHANCONG
	WHERE DEAN.MADA = PHANCONG.MADA
	GROUP BY DEAN.MADA, DEAN.TENDEAN



--Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
	select DEAN.TENDEAN,ceiling(cast(sum(PHANCONG.THOIGIAN)  as decimal(5,2))) as 'Tổng giờ làm'
	from PHANCONG,DEAN
	where PHANCONG.MADA = DEAN.MADA
	group by DEAN.TENDEAN


--Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
	select DEAN.TENDEAN,floor(cast(sum(PHANCONG.THOIGIAN)  as decimal(5,2))) as 'Tổng giờ làm'
	from PHANCONG,DEAN
	where PHANCONG.MADA = DEAN.MADA
	group by DEAN.TENDEAN


/*Xuất định dạng “tổng số giờ làm việc” làm tròn tới 2 chữ số thập phân, 
  Dữ liệu cột HONV được viết in hoa toàn bộ
  Dữ liệu cột TENLOT được viết chữ thường toàn bộ*/
select MAPHG from PHONGBAN where TENPHG=N'Nghiên cứu' 
select (CONCAT_WS(' ',upper(HONV),lower(TENLOT),TENNV))
, LUONG from NHANVIEN 
	where LUONG > (select round(avg (LUONG),2) from NHANVIEN where PHG=(select MAPHG from PHONGBAN where TENPHG=N'Nghiên cứu'))
	


--Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965.
SELECT NHANVIEN.MANV
	FROM NHANVIEN
	WHERE YEAR(NHANVIEN.NGSINH) BETWEEN 1960 AND 1965


--Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại.
select year(getdate())-year(NGSINH) as 'Tuổi' from NHANVIEN




--Cho biết số lượng nhân viên,...hiển thi theo định dạng dd-mm-yy (ví dụ 25-04-2019)
select convert(varchar,NGSINH,105) as 'Ngay Sinh' from NHANVIEN