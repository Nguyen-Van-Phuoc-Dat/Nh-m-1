CREATE trigger trg_checkSalary15000
	on Nhanvien
	for insert, update 
as 
	if(select luong from inserted)<150000
	begin
		print N'lương < 15000';
		rollback tran;
	end;
CREATE trigger trg_checkvalidAge
	on Nhanvien
	for insert
as
	declare @age int;
	select @age = DATEDIFF(YEAR,ngsinh, GETDATE())+1 from inserted;
	if @age <18 or @age > 65
	begin
		print N'Tuổi của nhân viên không hợp lêj 18<= tuổi <65 tuổi';
		rollback transaction;
	end;
INSERT INTO [dbo].[NHANVIEN]
			([HONV],[TENLOT],[TENNV],[MANV],[NGSINH],[DCHI],[PHAI],[LUONG],[MA_NQl],[PHG])
		VALUES
			(N'Nguyễn', N'Quang', N'Hùng','098','9-13-2020','Le Duan - HCM','Nam',90000,'005',1)
Go
CREATE trigger trg_CheckupdateonAddress
	on Nhanvien
	for update
as 
	if exists(select dchi from inserted where DChi like '%HCM%'
	begin
		print N'Không thể cập nhật nhân viên ở HCM';
		rollback tran;
	end;
Update [dbo].[NHANVIEN]
	SET[PHAI] = 'Nam'
WHERE MANV ='001';	
Go
CREATE trigger trg_SumEmps
	on Nhanvien
	after insert
as
	declare @male  int, @female int;
	select @female = count(MANV) from NHANVIEN where PHAI = N'Nữ';
	select @female = count(MANV) from NHANVIEN where PHAI = N'Nam';
	print N'Tổng số nhân viên là nữ:' + cast(@female as varchar);
	print N'Tổng số nhân viên là nam:' + cast(@female as varchar);
INSERT INTO[dbo].[NHANVIEN]
					([HONV],[TENLOT],[TENNV],[MANV],[NGSINH],[DCHI],[PHAI],[LUONG],[MA_NQl],[PHG])
				Values
					('A','B','C','345','7-12-1995','HCM','Nam',60000,'005',1)
CREATE trigger trg_SumEmpsForUpdate
	on nhanvien
	after insert
as
	if(select top 1 phai from deleted)!= (select top 1 phai from inserted)
	begin
		declare @male  int, @female int;
		select @female = count(MANV) from NHANVIEN where PHAI = N'Nữ';
		select @female = count(MANV) from NHANVIEN where PHAI = N'Nam';
		print N'Tổng số nhân viên là nữ:' + cast(@female as varchar);
		print N'Tổng số nhân viên là nam:' + cast(@female as varchar);
	end;