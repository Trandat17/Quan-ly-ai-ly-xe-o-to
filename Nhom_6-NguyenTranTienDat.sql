create database QuanLyDaiLyXeOTo
go
use QuanLyDaiLyXeOTo
go
create table KHACHHANG(
                     MaKhachHang int primary key,
					 HoVaTen nvarchar(50),
					 SoDienThoai nvarchar(15),
					 DiaChi nvarchar(100)
					 )
go
create table XE(
               MaXe int primary key,
			   LoaiXe nvarchar(50),
			   MauXe nvarchar(50),
			   HieuXe nvarchar(50),
			   MaKhachHang int references KHACHHANG(MaKhachHang)
			   )
go
create table NHANVIEN(
                    MaNhanVien int primary key,
					TenChucVu nvarchar(50),
					SoDienThoai int,
					DiaChi nvarchar(50)
					)
go

create table HOPDONG(
                   MaHopDong int primary key,
				   NgayKy datetime,
				   GiaBan nvarchar(50),
				   TrangThai nvarchar(50),
				   MaKhachHang int references KHACHHANG(MaKhachHang),
				   MaXe int references XE(MaXe),
				   MaNhanVien int references NHANVIEN(MaNhanVien)
	   )

go
create table BAODUONG(
					MaBaoDuong int primary key,
					NgayBaoDuong datetime,
					ChiPhi nvarchar(50),
					MoTa nvarchar(50),
					MaXe int references XE(MaXe)
)
go
create table BAOHANH(
					MaBaoHanh int primary key,
					NgayBatDau datetime,
					NgayKetThuc datetime,
					DieuKhoan nvarchar(50),
					MaXe int references XE(MaXe)
)
go
create table HOADON(
					MaHoaDon int primary key,
					NgayLap datetime,
					TongTien decimal,
					MaKhachHang int references KHACHHANG(MaKhachHang),
					MaXe int references XE(MaXe)
)
go
Insert into NHANVIEN(MaNhanVien, TenChucVu, SoDienThoai, DiaChi) values ('0', N'Trưởng Phòng', '0498765432', N'Bắc Giang'),
																		('1', N'Quản Lý', '0493221457', N'Bắc Giang'),
																		('2', N'Nhân Viên', '0489765472', N'Bắc Ninh'),
																		('3', N'Nhân Viên', '0365705432', N'Hà Giang'),
																		('4', N'Thư Ký', '0496065932', N'Bắc Kạn'),
																		('5', N'Nhân Viên', '0365705772', N'Nam Định'),
																		('6', N'Nhân Viên', '0360905432', N'Hậu Giang'),
																		('7', N'Trưởng Phòng', '0095705432', N'Nam Định'),
																		('8', N'Nhân Viên', '0875705432', N'Cần Thơ'),
																		('9', N'Nhân Viên', '0398705432', N'TP Hồ Chí Minh'),
																		('10',N'Nhân Viên', '0365776432', N'Nam Định'),
																		('100', N'Nhân Viên', '0365705482', N'Nam Định'),
																		('101', N'Quản Lý', '0365705401', N'Cao Bằng'),
																		('102', N'Nhân Viên', '0365701232', N'Nam Định'),
																		('103', N'Nhân Viên', '0376705432', N'Hải Dương')
																		
Insert into KHACHHANG(MaKhachHang, HoVaTen, SoDienThoai, DiaChi) values ('11', N'Dương Công Hảo', '0359075931',  N'Lạng Sơn'), 
																		('21', N'Nguyễn Tuấn Anh', '0345098765',  N'Quảng Ninh'),
																		('31', N'Lò Văn Tâm', '0309008874', N'Hà Giang'), 
																		('41', N'Đường Văn Tuyến ', '0349871022',  N'Lạng Sơn'), 
																		('51', N'Nguyễn Văn Lè', '0358766531',  N'Hà Nội'),
																		('61', N'Nguyễn Xuân Trường', '0359070031',  N'Hải Dương'),
																		('71', N'Đào Duy Từ', '0358675931',  N'Lạng Sơn'),
																		('81', N'Nguyễn Thị Trà Giang', '0889075931',  N'Thái Bình'),
																		('91', N'Nguyễn Ngọc Lý', '0359075907',  N'Hà Nội'),
																		('110', N'Phạm Trung Đồng', '0359124931',  N'Hà Nam'),
																		('111', N'Dương Huy Hoàng', '0399075971',  N'Bắc Giang'),
																		('112', N'Trương Mỹ Lan', '0359213657',  N'Lạng Sơn'),
																		('113', N'Hà Phi Đồng', '0359074709',  N'Bắc Ninh'),
																		('114', N'Trần Đình Bạc', '0765075331',  N'Tiền Giang'),
																		('115', N'Phan Văn Giang', '0875124765',  N'Yên Bái')
Insert into XE(MaXe, LoaiXe, MauXe, HieuXe, MaKhachHang) values ('12', N'Bán tải', N'Đỏ', 'Toyota', '11'), 
																('22', N'Xe Con', N'Trắng','Hyundai','31'),
																('32', N'Xe Tải', N'Đen', 'Lamboghini', '51'),
																('42', N'Xe Điện', N'Vàng', 'Kia','11'),
																('52', N'Xe Container', N'Tím', 'Vinfast', '41'),
																('62', N'Xe Container', N'Tím', 'Vinfast', '115'),
																('72', N'Xe Ben', N'Hồng', 'Vinfast', '71'),
																('82', N'Xe Con', N'Tím', 'Vinfast', '61'),
																('92', N'Xe Con', N'Tím', 'Vinfast', '41'),
																('120', N'Xe Tải', N'Tím', 'Vinfast', '111'),
																('121', N'Xe Điện', N'Tím', 'Vinfast', '110'),
																('122', N'Bán Tải', N'Tím', 'Vinfast', '112'),
																('123', N'Xe Ben', N'Tím', 'Vinfast', '113'),
																('124', N'Xe Sang', N'Tím', 'Vinfast', '21'),
																('125', N'Xe Tải', N'Tím', 'Vinfast', '114')

Insert into BAODUONG(MaBaoDuong, NgayBaoDuong, ChiPhi, Mota, MaXe) values ('13','2022-09-28','15', N'Bình Thường', '12'),
																		  ('23','2024-02-10','30', N'Bình Thường', '52'),
																		  ('33','2023-12-20','25', N'Bình Thường', '32'),
																		  ('43','2024-05-03','90', N'Hỏng Nặng', '22'),
																		  ('53','2022-11-27','30', N'Bình Thường', '42'),
																		  ('63','2022-09-28','15', N'Bình Thường', '62'),
																		  ('73','2022-05-28','15', N'Bình Thường', '82'),
																		  ('83','2023-09-19','15', N'Bình Thường', '72'),
																		  ('93','2022-03-28','15', N'Bình Thường', '121'),
																		  ('130','2022-09-28','50', N'Hơi Nặng', '123'),
																		  ('131','2022-09-28','15', N'Bình Thường', '124'),
																		  ('132','2021-02-13','15', N'Bình Thường', '120'),
																		  ('133','2022-09-28','50', N'Hơi Nặng', '122'),
																		  ('134','2024-10-01','15', N'Bình Thường', '92'),
																		  ('135','2021-03-05','15', N'Bình Thường', '120')
Insert into BAOHANH(MaBaoHanh, NgayBatDau, NgayKetThuc, DieuKhoan, MaXe) values ('14','2020-10-10','2025-10-10', '10','12'),	
																				('24','2020-05-05','2025-05-05', '10','42'),
																				('34','2021-08-08','2026-08-08', '10','22'),
																				('44','2022-11-19','2027-11-27', '10','32'),
																				('54','2022-01-15','2027-01-15', '10','52'),
																				('64','2020-10-10','2025-01-10', '10','62'),
																				('74','2020-09-10','2025-07-09', '10','82'),
																				('84','2020-04-10','2025-09-10', '10','72'),
																				('94','2020-01-10','2025-10-10', '10','92'),
																				('140','2020-12-10','2026-08-10', '10','120'),
																				('141','2020-10-10','2024-10-10', '10','122'),
																				('142','2020-11-10','2025-05-20', '10','121'),
																				('143','2020-07-10','2025-12-08', '10','124'),
																				('144','2020-08-10','2025-10-09', '10','123'),
																				('145','2020-10-10','2025-11-10', '10','125')																			
Insert into HOADON(MaHoaDon, NgayLap, TongTien, MaKhachHang, MaXe) values ('15','2020-10-10','100','11','12'),
																		  ('25','2021-08-08','110','31','22'),
																		  ('35','2019-11-19','130','51','32'),
																		  ('45','2020-05-05','199','11','42'),
																		  ('55','2022-01-15','105','41','52'),
																		  ('65','2020-10-10','100','115','62'),
																		  ('75','2020-10-10','100','71','72'),
																		  ('85','2020-10-10','100','61','82'),
																		  ('95','2020-10-10','100','41','92'),
																		  ('150','2020-10-10','100','111','120'),
																		  ('151','2020-10-10','100','110','121'),
																		  ('152','2020-10-10','100','112','122'),
																		  ('153','2020-10-10','100','113','123'),
																		  ('154','2020-10-10','100','21','124'),
																		  ('155','2020-10-10','100','114','125')
Insert into HOPDONG(MaHopDong, NgayKy, GiaBan, TrangThai, MaKhachHang, MaXe, MaNhanVien) values ('16','2020-10-10', '120',N'Tốt','11', '12','1'),
																								('26','2021-08-08', '200',N'Tốt','31', '22','2'),
																								('36','2019-11-19', '250',N'Tốt','51', '32','3'),
																								('46','2020-05-05', '150',N'Tốt','11', '42','4'),
																								('56','2022-01-15', '100',N'Xước','41', '52','5'),
																								('66','2020-10-10', '120',N'Tốt','115', '62','6'),
																								('76','2020-10-10', '120',N'Tốt','71', '72','7'),
																								('86','2020-10-10', '120',N'Tốt','61', '82','8'),
																								('96','2020-10-10', '120',N'Tốt','41', '92','9'),
																								('160','2020-10-10', '100',N'Xước','111', '120','0'),
																								('161','2020-10-10', '120',N'Tốt','110', '121','101'),
																								('162','2020-10-10', '120',N'Tốt','112', '122','102'),
																								('163','2020-10-10', '120',N'Tốt','113', '123','103'),
																								('164','2020-10-10', '120',N'Tốt','21', '124','10'),
																								('165','2020-10-10', '120',N'Tốt','114', '125','100')


--View 1 thông tin khách hàng và xe của họ
CREATE VIEW View_KhachHangXe AS
SELECT 
    KH.MaKhachHang,
    KH.HoVaTen,
    KH.SoDienThoai,
    KH.DiaChi,
    X.MaXe,
    X.LoaiXe,
    X.MauXe,
    X.HieuXe
FROM 
    KHACHHANG KH
JOIN 
    XE X ON KH.MaKhachHang = X.MaKhachHang;

SELECT * FROM View_KhachHangXe;
-- View 2 thông tin hợp đồng và khách hàng
CREATE VIEW View_HopDongKhachHang AS
SELECT 
    HD.MaHopDong,
    HD.NgayKy,
    HD.GiaBan,
    HD.TrangThai,
    KH.HoVaTen,
    KH.SoDienThoai
FROM 
    HOPDONG HD
JOIN 
    KHACHHANG KH ON HD.MaKhachHang = KH.MaKhachHang;
SELECT * FROM View_HopDongKhachHang
-- View 3 thông tin bảo hành của xe
CREATE VIEW View_BaoHanhXe AS
SELECT 
    BH.MaBaoHanh,
    BH.NgayBatDau,
    BH.NgayKetThuc,
    BH.DieuKhoan,
    X.HieuXe,
    X.MauXe
FROM 
    BAOHANH BH
JOIN 
    XE X ON BH.MaXe = X.MaXe;
SELECT * FROM View_BaoHanhXe
-- View 4 thông tin bảo dưỡng xe 
CREATE VIEW View_BaoDuongXe AS
SELECT 
    BD.MaBaoDuong,
    BD.NgayBaoDuong,
    BD.ChiPhi,
    BD.MoTa,
    X.HieuXe,
    X.MauXe
FROM 
    BAODUONG BD
JOIN 
    XE X ON BD.MaXe = X.MaXe;
SELECT * FROM View_BaoDuongXe
-- View 5 View thông tin hóa đơn và khách hàng 
CREATE VIEW View_HoaDonKhachHang AS
SELECT 
    HD.MaHoaDon,
    HD.NgayLap,
    HD.TongTien,
    KH.HoVaTen,
    KH.SoDienThoai
FROM 
    HOADON HD
JOIN 
    KHACHHANG KH ON HD.MaKhachHang = KH.MaKhachHang;
SELECT * FROM View_HoaDonKhachHang
-- View 6 thông tin nhân viên và hợp đồng
CREATE VIEW View_NhanVienHopDong AS
SELECT 
    NV.MaNhanVien,
    NV.TenChucVu,
    HD.MaHopDong,
    HD.NgayKy
FROM 
    NHANVIEN NV
JOIN 
    HOPDONG HD ON NV.MaNhanVien = HD.MaNhanVien;
SELECT * FROM View_NhanVienHopDong
-- View 7 thống kê số lượng xe theo từng loại.
CREATE VIEW View_ThongKeXe AS
SELECT 
    LoaiXe,
    COUNT(*) AS SoLuong
FROM 
    XE
GROUP BY 
    LoaiXe;
SELECT * FROM View_ThongKeXe
-- View 8 thông tin xe và bảo hành của chúng 
CREATE VIEW View_XeBaoHanh AS
SELECT 
    X.MaXe,
    X.HieuXe,
    BH.NgayBatDau,
    BH.NgayKetThuc
FROM 
    XE X
LEFT JOIN 
    BAOHANH BH ON X.MaXe = BH.MaXe;
SELECT * FROM View_XeBaoHanh
-- View 9 thông tin khách hàng và số tiền họ đã chi cho hóa đơn
CREATE VIEW View_KhachHangChiTieu AS
SELECT 
    KH.MaKhachHang,
    KH.HoVaTen,
    SUM(HD.TongTien) AS TongChiTieu
FROM 
    KHACHHANG KH
JOIN 
    HOADON HD ON KH.MaKhachHang = HD.MaKhachHang
GROUP BY 
    KH.MaKhachHang, KH.HoVaTen;
SELECT * FROM View_KhachHangChiTieu 
-- View 10 thông tin bảo dưỡng và xe 
CREATE VIEW View_BaoDuongVaXe AS
SELECT 
    BD.MaBaoDuong,
    BD.NgayBaoDuong,
    BD.ChiPhi,
    X.HieuXe,
    X.MauXe
FROM 
    BAODUONG BD
JOIN 
    XE X ON BD.MaXe = X.MaXe;
SELECT * FROM View_BaoDuongVaXe

--Procedure 1 thủ tục lấy danh sách tất cả khách hàng
CREATE PROCEDURE GetAllCustomers
AS
BEGIN
    SELECT * FROM KHACHHANG;
END;
EXEC GetAllCustomers
-- Procedure 2 thủ tục thêm khách hàng mới 
CREATE PROCEDURE ThemKhachHang
    @MaKhachHang INT,
    @HoVaTen NVARCHAR(50),
    @SoDienThoai NVARCHAR(15),
    @DiaChi NVARCHAR(100)
AS
BEGIN
    INSERT INTO KHACHHANG (MaKhachHang, HoVaTen, SoDienThoai, DiaChi)
    VALUES (@MaKhachHang, @HoVaTen, @SoDienThoai, @DiaChi);
END;
EXEC ThemKhachHang @MaKhachHang = 2, @HoVaTen = N'Phạm Trung Vàng', @SoDienThoai = '0312354679', @DiaChi = N'Hà Nội';
-- Procedure 3 thủ tục cập nhật thông tin xe 
CREATE PROCEDURE UpdateCarInfo
    @MaXe INT,
    @LoaiXe NVARCHAR(50),
    @MauXe NVARCHAR(50),
    @HieuXe NVARCHAR(50)
AS
BEGIN
    UPDATE XE
    SET LoaiXe = @LoaiXe, MauXe = @MauXe, HieuXe = @HieuXe
    WHERE MaXe = @MaXe;
END;
EXEC UpdateCarInfo @MaXe = 121, @LoaiXe = 'Xe Con', @MauXe = 'Đen', @HieuXe = 'Toyota';

-- Procedure 4 thủ tục xóa hóa đơn theo mã hóa đơn 
CREATE PROCEDURE DeleteInvoice
    @MaHoaDon INT
AS
BEGIN
    DELETE FROM HOADON 
    WHERE MaHoaDon = @MaHoaDon;
END;
EXEC DeleteInvoice @MaHoaDon = 1;

-- Procedure 5 thủ tục lấy danh sách xe của 1 khách hàng 
CREATE PROCEDURE GetCarsByCustomer
    @CustomerID INT
AS
BEGIN
    SELECT * FROM XE 
    WHERE MaKhachHang = @CustomerID;
END;
EXEC GetCarsByCustomer @CustomerID = 1;
-- Procedure 6 thủ tục tạo hợp đồng mới 
CREATE PROCEDURE HopDongMoi
    @MaHopDong INT,
    @NgayKy DATETIME,
    @GiaBan DECIMAL,
    @TrangThai NVARCHAR(50),
    @MaKhachHang INT,
    @MaXe INT,
    @MaNhanVien INT
AS
BEGIN
    INSERT INTO HOPDONG (MaHopDong, NgayKy, GiaBan, TrangThai, MaKhachHang, MaXe, MaNhanVien)
    VALUES (@MaHopDong, @NgayKy, @GiaBan, @TrangThai, @MaKhachHang, @MaXe, @MaNhanVien);
END;

EXEC sp_helptext 'HopDongMoi';
-- Procedure 7 thủ tục lấy thông tin nhân viên theo mã nhân viên 
CREATE PROCEDURE GetEmployeeById
    @MaNhanVien INT
AS
BEGIN
    SELECT * FROM NHANVIEN 
    WHERE MaNhanVien = @MaNhanVien;
END; 
EXEC GetEmployeeById @MaNhanVien = 1;
-- Procedure 8 thủ tục thống kê tổng chi phí bảo trì 
CREATE PROCEDURE GetMaintenanceCostByCar
    @MaXe INT,
    @TotalCost DECIMAL OUTPUT
AS
BEGIN
    SELECT @TotalCost = SUM(CAST(ChiPhi AS DECIMAL)) 
    FROM BAODUONG 
    WHERE MaXe = @MaXe;
END;
DECLARE @TotalCost DECIMAL;
EXEC GetMaintenanceCostByCar @MaXe = 1, @TotalCost = @TotalCost OUTPUT;
SELECT @TotalCost AS 'Total Maintenance Cost';
-- Procedure 9 thủ tục lấy danh sách bảo hành xe 
CREATE PROCEDURE GetWarrantyByCar
    @MaXe INT
AS
BEGIN
    SELECT * FROM BAOHANH 
    WHERE MaXe = @MaXe;
END;
EXEC GetWarrantyByCar @MaXe = 1;

-- Procedure 10 thủ tục cập nhật trạng thái hợp đồng
CREATE PROCEDURE UpdateContractStatus
    @MaHopDong INT,
    @TrangThai NVARCHAR(50)
AS
BEGIN
    UPDATE HOPDONG
    SET TrangThai = @TrangThai
    WHERE MaHopDong = @MaHopDong;
END;
EXEC UpdateContractStatus @MaHopDong = 1, @TrangThai = N'Hoàn thành';

-- Trigger 1 Cập nhật lại thời gian trong bảng KHACHHANG
ALTER TABLE KHACHHANG
ADD ThoiGianChinhSua DATETIME NULL;
CREATE TRIGGER trg_UpdateTime_KHACHHANG
ON KHACHHANG
AFTER UPDATE
AS
BEGIN
    UPDATE KHACHHANG
    SET ThoiGianChinhSua = GETDATE()
    WHERE MaKhachHang IN (SELECT MaKhachHang FROM inserted);
END;
-- Trigger 2 kiểm tra số điện thoại khi thêm khách hàng
CREATE TRIGGER trg_CheckPhone_KHACHHANG
ON KHACHHANG
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @SoDienThoai nvarchar(15);
    
    SELECT @SoDienThoai = SoDienThoai FROM inserted;
    
    IF LEN(@SoDienThoai) != 10 
    BEGIN
        RAISERROR('Số điện thoại phải có 10 chữ số', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO KHACHHANG (MaKhachHang, HoVaTen, SoDienThoai, DiaChi)
        SELECT MaKhachHang, HoVaTen, SoDienThoai, DiaChi FROM inserted;
    END;
END;
-- Trigger 3 tạo mã hóa đơn mới
CREATE TRIGGER trg_AutoMaHoaDon
ON HOADON
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @MaHoaDon INT;
    
    SELECT @MaHoaDon = COALESCE(MAX(MaHoaDon), 0) + 1 FROM HOADON;
    
    INSERT INTO HOADON (MaHoaDon, NgayLap, TongTien, MaKhachHang, MaXe)
    SELECT @MaHoaDon, NgayLap, TongTien, MaKhachHang, MaXe FROM inserted;
END;
-- Triger 4 ghi lại lịch sử cập nhật
CREATE TRIGGER trg_LogUpdate_KHACHHANG
ON KHACHHANG
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogTable (MaKhachHang, ThayDoi, ThoiGian)
    SELECT NEW.MaKhachHang, 'Cập nhật khách hàng', GETDATE()
    FROM inserted AS NEW
    JOIN deleted AS OLD ON NEW.MaKhachHang = OLD.MaKhachHang;
END;
-- Trigger 5 từ chối xóa xe nếu có hợp đồng 
CREATE TRIGGER trg_PreventDelete_XE
ON XE
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM HOPDONG WHERE MaXe IN (SELECT MaXe FROM deleted))
    BEGIN
        RAISERROR('Không thể xóa xe vì có hợp đồng liên quan', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM XE WHERE MaXe IN (SELECT MaXe FROM deleted);
    END;
END;
-- Trigger 6 cập nhật số lượng xe trong bảng NHANVIEN 
CREATE TRIGGER trg_UpdateXeCount_NHANVIEN
ON HOPDONG
AFTER INSERT
AS
BEGIN
    UPDATE NHANVIEN 
    SET SoXeDaBan = SoXeDaBan + 1 
    WHERE MaNhanVien IN (SELECT MaNhanVien FROM inserted);
END;
-- Trigger 7 ghi lịa chi phí bảo dưỡng
CREATE TRIGGER trg_LogChiPhi_BAODUONG
ON BAODUONG
AFTER INSERT
AS
BEGIN
    INSERT INTO ChiPhiTable (MaXe, ChiPhi, ThoiGian)
    SELECT MaXe, ChiPhi, GETDATE() FROM inserted;
END;
-- Trigger 8 kiễm tra số lượng xe khi thêm hợp đồng
ALTER TABLE XE
ADD TrangThai nvarchar(50) NULL;
CREATE TRIGGER trg_CheckXeCount_HOPDONG
ON HOPDONG
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @MaXe INT;
    
    SELECT @MaXe = MaXe FROM inserted;
    
    IF (SELECT COUNT(*) FROM XE WHERE MaXe = @MaXe AND TrangThai = 'Có sẵn') = 0
    BEGIN
        RAISERROR('Xe không có sẵn để ký hợp đồng', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO HOPDONG (MaHopDong, NgayKy, GiaBan, TrangThai, MaKhachHang, MaXe, MaNhanVien)
        SELECT MaHopDong, NgayKy, GiaBan, TrangThai, MaKhachHang, MaXe, MaNhanVien FROM inserted;
    END;
END;
-- Trigger 9 ghi lại bảo hành khi có bảo hành mới
CREATE TRIGGER trg_LogBaoHanh
ON BAOHANH
AFTER INSERT
AS
BEGIN
    INSERT INTO LogBaoHanh (MaBaoHanh, MoTa, ThoiGian)
    SELECT MaBaoHanh, 'Thêm bảo hành mới', GETDATE() FROM inserted;
END;
-- Trigger 10 cập nhật lại trạng thái xe khi hủy hợp đồng 
CREATE TRIGGER trg_UpdateTrangThaiXe_HOPDONG
ON HOPDONG
AFTER DELETE
AS
BEGIN
    UPDATE XE 
    SET TrangThai = 'Có sẵn' 
    WHERE MaXe IN (SELECT MaXe FROM deleted);
END;
-- Phân quyền quản lý
CREATE ROLE QuanLy;
GRANT SELECT, INSERT, UPDATE, DELETE ON KHACHHANG TO QuanLy;
GRANT SELECT, INSERT, UPDATE, DELETE ON NHANVIEN TO QuanLy;
GRANT SELECT, INSERT, UPDATE, DELETE ON XE TO QuanLy;
GRANT SELECT, INSERT, UPDATE, DELETE ON HOPDONG TO QuanLy;
GRANT SELECT, INSERT, UPDATE, DELETE ON BAODUONG TO QuanLy;
GRANT SELECT, INSERT, UPDATE, DELETE ON BAOHANH TO QuanLy;
GRANT SELECT, INSERT, UPDATE, DELETE ON HOADON TO QuanLy;
-- Giả sử bạn muốn gán cho những người có chức vụ là 'Quản Lý'
CREATE LOGIN [QuanLyMa2] WITH PASSWORD = 'QuanLyMa2';  -- tạo tên đăng nhập
CREATE USER [2] FOR LOGIN [QuanLyMa2];-- Đăng nhập
EXEC sp_addrolemember 'QuanLy', '2';  -- Sử dụng mã nhân viên đã tạo để cấp quyền
EXEC sp_helprolemember 'QuanLy';-- kiểm tra quyền 
--	Phân quyền nhân viên 
CREATE ROLE NhanVienRole;
GRANT SELECT, INSERT, UPDATE ON KHACHHANG TO NhanVienRole;
GRANT SELECT, INSERT, UPDATE ON XE TO NhanVienRole;
GRANT SELECT, INSERT ON HOPDONG TO NhanVienRole;   -- Nhân viên có thể thêm hợp đồng
GRANT SELECT ON BAODUONG TO NhanVienRole;           -- Nhân viên chỉ xem bảo dưỡng
GRANT SELECT ON BAOHANH TO NhanVienRole;            -- Nhân viên chỉ xem bảo hành
GRANT SELECT ON HOADON TO NhanVienRole;              -- Nhân viên chỉ xem hóa đơn
CREATE LOGIN [NhanVienMa3] WITH PASSWORD = 'NhanVienMa3'; 
CREATE USER [3] FOR LOGIN [NhanVienMa3];
EXEC sp_addrolemember 'NhanVienRole', '3';
EXEC sp_helprolemember 'NhanVienRole';
--	Phân quyền khách hàng 
CREATE ROLE KhachHang;
GRANT SELECT ON KHACHHANG TO KhachHang;
CREATE LOGIN [Dương Công Hảo] WITH PASSWORD = '1';
CREATE LOGIN [Nguyễn Tuấn Anh] WITH PASSWORD = '2';
CREATE LOGIN [Lò Văn Tâm] WITH PASSWORD = '3';
CREATE LOGIN [Đường Văn Tuyến] WITH PASSWORD = '4';
CREATE LOGIN [Nguyễn Văn Lè] WITH PASSWORD = '5';
CREATE LOGIN [Nguyễn Xuân Trường] WITH PASSWORD = '6';
CREATE LOGIN [Đào Duy Từ] WITH PASSWORD = '7';
CREATE LOGIN [Nguyễn Thị Trà Giang] WITH PASSWORD = '8';
CREATE LOGIN [Nguyễn Ngọc Lý] WITH PASSWORD = '9';
CREATE LOGIN [Phạm Trung Đồng] WITH PASSWORD = '10';
CREATE LOGIN [Dương Huy Hoàng] WITH PASSWORD = '11';
CREATE LOGIN [Trương Mỹ Lan] WITH PASSWORD = '12';
CREATE LOGIN [Hà Phi Đồng] WITH PASSWORD = '13';
CREATE LOGIN [Trần Đình Bạc] WITH PASSWORD = '14';
CREATE LOGIN [Phan Văn Giang] WITH PASSWORD = '15';
CREATE USER [Dương Công Hảo] FOR LOGIN [Dương Công Hảo];
CREATE USER [Nguyễn Tuấn Anh] FOR LOGIN [Nguyễn Tuấn Anh];
CREATE USER [Lò Văn Tâm] FOR LOGIN [Lò Văn Tâm];
CREATE USER [Đường Văn Tuyến] FOR LOGIN [Đường Văn Tuyến];
CREATE USER [Nguyễn Văn Lè] FOR LOGIN [Nguyễn Văn Lè];
CREATE USER [Nguyễn Xuân Trường] FOR LOGIN [Nguyễn Xuân Trường];
CREATE USER [Đào Duy Từ] FOR LOGIN [Đào Duy Từ];
CREATE USER [Nguyễn Thị Trà Giang] FOR LOGIN [Nguyễn Thị Trà Giang];
CREATE USER [Nguyễn Ngọc Lý] FOR LOGIN [Nguyễn Ngọc Lý];
CREATE USER [Phạm Trung Đồng] FOR LOGIN [Phạm Trung Đồng];
CREATE USER [Dương Huy Hoàng] FOR LOGIN [Dương Huy Hoàng];
CREATE USER [Trương Mỹ Lan] FOR LOGIN [Trương Mỹ Lan];
CREATE USER [Hà Phi Đồng] FOR LOGIN [Hà Phi Đồng];
CREATE USER [Trần Đình Bạc] FOR LOGIN [Trần Đình Bạc];
CREATE USER [Phan Văn Giang] FOR LOGIN [Phan Văn Giang];
EXEC sp_addrolemember 'KhachHang', N'Dương Công Hảo';
EXEC sp_addrolemember 'KhachHang', N'Nguyễn Tuấn Anh';
EXEC sp_addrolemember 'KhachHang', N'Lò Văn Tâm';
EXEC sp_addrolemember 'KhachHang', N'Đường Văn Tuyến';
EXEC sp_addrolemember 'KhachHang', N'Nguyễn Văn Lè';
EXEC sp_addrolemember 'KhachHang', N'Nguyễn Xuân Trường';
EXEC sp_addrolemember 'KhachHang', N'Đào Duy Từ';
EXEC sp_addrolemember 'KhachHang', N'Nguyễn Thị Trà Giang';
EXEC sp_addrolemember 'KhachHang', N'Nguyễn Ngọc Lý';
EXEC sp_addrolemember 'KhachHang', N'Phạm Trung Đồng';
EXEC sp_addrolemember 'KhachHang', N'Dương Huy Hoàng';
EXEC sp_addrolemember 'KhachHang', N'Trương Mỹ Lan';
EXEC sp_addrolemember 'KhachHang', N'Hà Phi Đồng';
EXEC sp_addrolemember 'KhachHang', N'Trần Đình Bạc';
EXEC sp_addrolemember 'KhachHang', N'Phan Văn Giang';
EXEC sp_helprolemember 'KhachHang';




