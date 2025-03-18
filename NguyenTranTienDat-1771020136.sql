--Bài 1. Lấy danh sách 3 Vật tư có giá trị tồn kho cao nhất.
use QLVATTU
SELECT TOP 3 
	V.Mavtu,
    V.Tenvtu,
    T.Slcuoi,
    C.Dgnhap,
    (T.Slcuoi * C.Dgnhap) AS GiaTriTonKho
FROM 
    TONKHO T
JOIN 
    CTPNHAP C ON T.Mavtu = C.Mavtu
JOIN 
    VATTU V ON T.Mavtu = V.Mavtu
ORDER BY 
    GiaTriTonKho DESC;


--Bài 2. Tính tỷ lệ phần trăm số lượng tồn kho hiện tại của mỗi sản phẩm so với tổng số lượng đã nhập của sản phẩm đó.
SELECT 
    t.Mavtu,
    vt.Tenvtu,
    t.Slcuoi AS SoLuongTonHienTai,
    t.Tongslnhap AS TongSoLuongNhap,
    CASE 
        WHEN t.Tongslnhap > 0 THEN (t.Slcuoi * 100.0 / t.Tongslnhap) 
        ELSE 0 
    END AS TyLePhanTramTonKho
FROM 
    TONKHO t
JOIN 
    VATTU vt ON t.Mavtu = vt.Mavtu
WHERE 
    t.Tongslnhap > 0;

--Bài 3. Hiển thị thông tin phiếu xuất gồm các cột: số phiếu xuất và tổng thành tiền. Trong đó sắp xếp tổng thành tiền giảm dần.
SELECT 
    PX.Sopx AS SoPhieuXuat,
    SUM(CTX.Slxuat * CTX.Dgxuat) AS TongThanhTien
FROM 
    PXUAT PX
JOIN 
    CTPXUAT CTX ON PX.Sopx = CTX.Sopx
GROUP BY 
    PX.Sopx
ORDER BY 
    TongThanhTien DESC;
--Bài 4. Cho biết thông tin chi tiết của PHIẾU NHÂP trong tháng 02-2006.Cột ngày nhập thể hiện theo dạng yyyy-mm.
--Thông tin gồm các cột sopn, ngaynhap, ten vật tư, slnhap, dgnhap, thành tiền.Tong đó thành tiền = slnhap*dgnhap.Hiển thị kết quả
select P.Sopn,
       CONVERT(varchar, P.Ngaynhap, 7) as NgayNhap,
       V.Tenvtu,
       CTPN.Slnhap,
       CTPN.Dgnhap,
       CTPN.Slnhap * CTPN.Dgnhap as ThanhTien
from PNHAP P
JOIN CTPNHAP CTPN on P.Sopn = CTPN.Sopn
JOIN VATTU V on CTPN.Mavtu = V.Mavtu
where P.Ngaynhap >= '2006-02-01' AND P.Ngaynhap < '2006-03-01'
--Bài 5. Tạo view có tên vw_dondh_tongslnhap bao gồm các thông tin sau: số đặt hàng, tổng số lượng nhập. View này dùng để thống kê tổng số lượng nhập theo đơn đặt hàng.Hiển thị kết quả
CREATE VIEW vw_dondh_tongslnhap AS,
SELECT 
    PNHAP.Sodh AS SoDonDatHang,
    SUM(CTPNHAP.Slnhap) AS TongSoLuongNhap
FROM 
    PNHAP
JOIN 
    CTPNHAP ON PNHAP.Sopn = CTPNHAP.Sopn
GROUP BY 
    PNHAP.Sodh;
SELECT * FROM vw_dondh_tongslnhap;


--Bài 6. Tạo view có tên vw_dondh_tongsldatnhap bao gồm các thông tin sau: số đặt hàng, tổng số lượng đặt,tổng số lượng nhập. Hiển thị kết quả
CREATE VIEW vw_dondh_tongsldatnhap AS
SELECT 
    D.Sodh AS SoDonHang,
    SUM(CTDH.Sldat) AS TongSoLuongDat,
    COALESCE(SUM(CTPN.Slnhap), 0) AS TongSoLuongNhap
FROM 
    DONDH D
INNER JOIN CTDONDH CTDH ON D.Sodh = CTDH.Sodh
LEFT JOIN PNHAP PN ON D.Sodh = PN.Sodh
LEFT JOIN CTPNHAP CTPN ON PN.Sopn = CTPN.Sopn
GROUP BY D.Sodh;

SELECT * FROM vw_dondh_tongsldatnhap;


--Bài 7. Tạo view. Cho biết vật tư nào có tổng số lượng xuất bán là nhiều nhất. Hiển thị kết quả
CREATE VIEW vw_vattu_tongslexuat AS
WITH SoldQuantities AS (
    SELECT 
        ct.Mavtu,
        v.Tenvtu,
        SUM(ct.Slxuat) AS TongSlxuat
    FROM 
        CTPXUAT ct
    JOIN 
        PXUAT p ON ct.Sopx = p.Sopx
    JOIN 
        VATTU v ON ct.Mavtu = v.Mavtu
    GROUP BY 
        ct.Mavtu, v.Tenvtu
)
SELECT 
    Mavtu,
    Tenvtu,
    TongSlxuat
FROM 
    SoldQuantities
WHERE 
    TongSlxuat = (
        SELECT MAX(TongSlxuat) 
        FROM SoldQuantities
    );

-- Kiểm tra dữ liệu trong view
SELECT * FROM vw_vattu_tongslexuat;

--Bài 8. Tìm những phiếu đặt hàng từ tháng 01/2006 đến tháng 3/2006. Nếu tìm thấy in câu thông báo „Những phiếu đặt hàng từ 01/2006 đến 03/2006 là: sau đó in kèm với các thông tin của các phiếu đặt hàng tìm thấy.
-- nếu không thấy thì xuất thông báo 'Không tìm thấy'. Khi in thông báo nhớ truyền biến vào thông báo.
DECLARE @result TABLE (Sodh CHAR(4), Ngaydh DATETIME, Manhacc CHAR(4)); 

-- Truy vấn phiếu đặt hàng trong khoảng thời gian
INSERT INTO @result
SELECT Sodh, Ngaydh, Manhacc
FROM DONDH
WHERE Ngaydh BETWEEN '2006-01-01' AND '2006-03-31';

-- Kiểm tra có kết quả hay không và in thông báo tương ứng
IF EXISTS (SELECT 1 FROM @result)
BEGIN
    PRINT 'Những phiếu đặt hàng từ 01/2006 đến 03/2006 là:';
    SELECT * FROM @result;
END
ELSE
BEGIN
    PRINT 'Không tìm thấy';
END;
--Bài 9. Tìm những phiếu đặt hàng chưa từng nhập hàng trong tháng 01/2006. Nếu tìm thấy thì xuất thông báo: Những phiếu đặt hàng chưa từng nhập hàng trong tháng 01/2006 , kèm thông tin các phiếu đặt hàng chưa từng nhập hàng trong 01/2006.
-- nếu không thấy xuất thông báo „Không tìm thấy những phiếu đặt hàng chưa từng nhập hàng trong 01/2006.
--Dùng biến để xuất thông báo.
DECLARE @Message NVARCHAR(MAX);

IF EXISTS (SELECT * FROM DONDH WHERE Sodh NOT IN (SELECT DISTINCT Sodh FROM PNHAP WHERE MONTH(Ngaynhap) = 1 AND YEAR(Ngaynhap) = 2006))
BEGIN
    SET @Message = 'Nhung phieu dat hang chua tung nhap hang 01/2006 la:';
    SELECT @Message, DONDH.*
    FROM DONDH
    WHERE Sodh NOT IN (SELECT DISTINCT Sodh FROM PNHAP WHERE MONTH(Ngaynhap) = 1 AND YEAR(Ngaynhap) = 2006);
END
ELSE
BEGIN
    SET @Message = 'Khong tim thay nhung phieu dat hang chua tung nhap trong 01/2006.';
    SELECT @Message;
END
--Bài 10. Cho biết danh sách những vật tư có tổng số lượng xuất bán lớn hơn 40.Nếu có xuất thông báo, kèm thông tin vật tư
-- có tổng số lượng xuất bán lớn hơn 40.Còn ngược lại xuất thông báo „không có vật tư có tổng số lượng xuất bán lớn hơn 40. 
SELECT V.Mavtu, V.Tenvtu, SUM(C.Slxuat) AS TongSlXuat
FROM VATTU V
JOIN CTPXUAT C ON V.Mavtu = C.Mavtu
GROUP BY V.Mavtu, V.Tenvtu
HAVING SUM(C.Slxuat) > 40;
SELECT * FROM VATTU;


--Bài 11. Xây dựng thủ tục cho biết nhà cung cấp có nhiều đơn hàng nhất.Hiển thị kết quả
CREATE PROCEDURE NhaCungCapNhieuDonHangNhat
AS
BEGIN
    -- Sử dụng Common Table Expression (CTE) để tính số lượng đơn hàng của từng nhà cung cấp
    WITH SoLuongDonHang AS (
        SELECT 
            NHACC.Manhacc, 
            NHACC.Tenncc, 
            COUNT(DONDH.Sodh) AS SoDonHang
        FROM NHACC
        LEFT JOIN DONDH ON NHACC.Manhacc = DONDH.Manhacc
        GROUP BY NHACC.Manhacc, NHACC.Tenncc
    )
    -- Trả về nhà cung cấp có số lượng đơn hàng cao nhất
    SELECT TOP 1 
        Manhacc, 
        Tenncc, 
        SoDonHang
    FROM SoLuongDonHang
    ORDER BY SoDonHang DESC;
END;
EXEC NhaCungCapNhieuDonHangNhat;


--Bài 12. Xây dựng thủ tục cho biết thông tin của những vật tư có mã vật tư bắt đầu bằng TV.Hiển thị kết quả
CREATE PROCEDURE sp_GetVatTuByMa
AS
BEGIN
    SELECT 
        Mavtu,
        Tenvtu,
        Dvitinh,
        Phantram
    FROM VATTU
    WHERE Mavtu LIKE 'TV%'
END
EXEC sp_GetVatTuByMa;

--Bài 13. Viết hàm trả về số lượng tồn kho của một Vật tư bất kỳ. Hiển thị kết quả
CREATE FUNCTION dbo.GetSoLuongTonKho (
    @Mavtu CHAR(4) -- Tham số đầu vào: Mã vật tư
)
RETURNS INT
AS
BEGIN
    DECLARE @SoLuongTon INT;

    -- Lấy số lượng tồn kho từ bảng TONKHO
    SELECT TOP 1 
        @SoLuongTon = Slcuoi
    FROM TONKHO
    WHERE Mavtu = @Mavtu
    ORDER BY Namthang DESC; -- Lấy theo kỳ gần nhất

    RETURN ISNULL(@SoLuongTon, 0); -- Nếu không có dữ liệu, trả về 0
END;
SELECT dbo.GetSoLuongTonKho('DD01') AS SoLuongTonKho;

--Bài 14. Viết hàm trả về danh sách Vật tư còn tồn kho. Hiển thị danh sách này.
CREATE FUNCTION GetVatTuTonKho()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        tk.Mavtu,
        vt.Tenvtu,
        tk.Slcuoi
    FROM TONKHO tk
    JOIN VATTU vt ON tk.Mavtu = vt.Mavtu
    WHERE tk.Slcuoi > 0
);
SELECT * 
FROM GetVatTuTonKho();

--Bài 15. Sử dụng con trỏ để tăng giá 10% cho các Vật tư tồn kho dưới 10. Hiển thị kết quả
-- Tạo con trỏ
DECLARE @Mavtu CHAR(4); -- Biến để lưu mã vật tư
DECLARE @Phantram REAL; -- Biến để lưu phần trăm hiện tại

-- Khởi tạo con trỏ
DECLARE VattuCursor CURSOR FOR
SELECT Mavtu, Phantram
FROM VATTU
WHERE Mavtu IN (
    SELECT Mavtu
    FROM TONKHO
    WHERE Slcuoi < 10
);

-- Mở con trỏ
OPEN VattuCursor;

-- Lặp qua các bản ghi
FETCH NEXT FROM VattuCursor INTO @Mavtu, @Phantram;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Cập nhật giá trị phần trăm tăng thêm 10%
    UPDATE VATTU
    SET Phantram = @Phantram * 1.1
    WHERE Mavtu = @Mavtu;

    -- Lấy bản ghi tiếp theo
    FETCH NEXT FROM VattuCursor INTO @Mavtu, @Phantram;
END;

-- Đóng và giải phóng con trỏ
CLOSE VattuCursor;
DEALLOCATE VattuCursor;

-- Hiển thị kết quả
SELECT * FROM VATTU;

--Bài 16. Viết hàm kiểm tra tồn kho (BIT) và trả về 1 nếu còn hàng, 0 nếu hết hàng. Kiểm tra Vật tư mã DD02.
-- Tạo hàm kiểm tra tồn kho
CREATE FUNCTION KiemTraTonKho
(
    @Mavtu CHAR(4)
)
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT;

    -- Kiểm tra tổng tồn kho (Sldau + Tongslnhap - Tongslxuat) > 0
    IF EXISTS (
        SELECT 1
        FROM TONKHO
        WHERE Mavtu = @Mavtu
          AND (Sldau + Tongslnhap - Tongslxuat) > 0
    )
        SET @Result = 1; -- Còn hàng
    ELSE
        SET @Result = 0; -- Hết hàng

    RETURN @Result;
END;
GO

-- Gọi hàm để kiểm tra mã vật tư 'DD02'
SELECT dbo.KiemTraTonKho('DD02') AS TonKho;

--Bài 17. Dùng con trỏ để xóa Vật tư có tồn kho bằng 4. Hiển thị danh sách sản phẩm còn lại.
-- Declare a cursor to find items with a stock quantity of 4
DECLARE @Mavtu char(4);
DECLARE @Slcuoi int;

DECLARE cursor_tonkho CURSOR FOR
SELECT Mavtu, Slcuoi
FROM TONKHO
WHERE Slcuoi = 4;

-- Open the cursor
OPEN cursor_tonkho;

-- Fetch the first record from the cursor
FETCH NEXT FROM cursor_tonkho INTO @Mavtu, @Slcuoi;

-- Loop through all the records in the cursor
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Delete the corresponding record from VATTU table
    DELETE FROM VATTU WHERE Mavtu = @Mavtu;

    -- Fetch the next record
    FETCH NEXT FROM cursor_tonkho INTO @Mavtu, @Slcuoi;
END;

-- Close and deallocate the cursor
CLOSE cursor_tonkho;
DEALLOCATE cursor_tonkho;

-- Display the remaining products
SELECT * FROM VATTU;

--Bài 18.Tính số ngày tồn kho trung bình của vật tư mã TV14. Hiển thị kết quả
SELECT 
    V.Mavtu, 
    V.Tenvtu,
    AVG(T.Sldau + T.Tongslnhap - T.Tongslxuat - T.Slcuoi) AS AverageStockDays
FROM 
    TONKHO T
JOIN 
    VATTU V ON T.Mavtu = V.Mavtu
WHERE 
    V.Mavtu = 'TV14'
GROUP BY 
    V.Mavtu, V.Tenvtu;

--Bài 19.Viết thủ tục tăng giá nhập 10% cho các Vật tư có tồn kho dưới 5. Sử dụng vòng lặp WHILE. Hiển thị kết quả
IF OBJECT_ID('TangGiaNhap', 'P') IS NOT NULL
    DROP PROCEDURE TangGiaNhap;
GO

-- Create the procedure
CREATE PROCEDURE TangGiaNhap
AS
BEGIN
    -- Declare variables to hold values during the loop
    DECLARE @Mavtu CHAR(4)
    DECLARE @Slnhap INT
    DECLARE @Dgnhap MONEY
    DECLARE @NewDgnhap MONEY

    -- Create a temporary table to store eligible rows for updating
    CREATE TABLE #TempVattu (
        Mavtu CHAR(4),
        Slnhap INT,
        Dgnhap MONEY
    )

    -- Insert eligible rows into the temporary table (Vật tư with Tồn kho < 5)
    INSERT INTO #TempVattu (Mavtu, Slnhap, Dgnhap)
    SELECT CTPNHAP.Mavtu, CTPNHAP.Slnhap, CTPNHAP.Dgnhap
    FROM CTPNHAP
    JOIN TONKHO ON CTPNHAP.Mavtu = TONKHO.Mavtu
    WHERE TONKHO.Slcuoi < 5

    -- Cursor through the temporary table to apply the price increase
    WHILE EXISTS (SELECT 1 FROM #TempVattu)
    BEGIN
        -- Fetch the first row from the temporary table
        SELECT TOP 1 @Mavtu = Mavtu, @Slnhap = Slnhap, @Dgnhap = Dgnhap
        FROM #TempVattu

        -- Calculate the new price
        SET @NewDgnhap = @Dgnhap * 1.1

        -- Update the price in the CTPNHAP table
        UPDATE CTPNHAP
        SET Dgnhap = @NewDgnhap
        WHERE Mavtu = @Mavtu

        -- Remove the processed row from the temporary table
        DELETE FROM #TempVattu WHERE Mavtu = @Mavtu
    END

    -- Drop the temporary table
    DROP TABLE #TempVattu

    -- Return the updated rows from the CTPNHAP table
    SELECT CTPNHAP.Mavtu, CTPNHAP.Slnhap, CTPNHAP.Dgnhap
    FROM CTPNHAP
    JOIN TONKHO ON CTPNHAP.Mavtu = TONKHO.Mavtu
    WHERE TONKHO.Slcuoi < 5
END
GO
EXEC TangGiaNhap
SELECT CTPNHAP.Mavtu, CTPNHAP.Slnhap, CTPNHAP.Dgnhap
FROM CTPNHAP
JOIN TONKHO ON CTPNHAP.Mavtu = TONKHO.Mavtu
WHERE TONKHO.Slcuoi < 5;

--Bài 20.Sử dụng con trỏ để tăng giá 15% cho Vật tư tồn kho dưới 5. Hiển thị danh sách sau khi cập nhật.
-- Declare a cursor to select the materials from TONKHO with stock under 5
DECLARE @Mavtu CHAR(4), @Tenvtu NVARCHAR(50), @Phantram REAL;

DECLARE cursor_update CURSOR FOR
SELECT V.Mavtu, V.Tenvtu, V.Phantram
FROM VATTU V
JOIN TONKHO T ON V.Mavtu = T.Mavtu
WHERE T.Slcuoi < 5;

-- Open the cursor
OPEN cursor_update;

-- Fetch the first row
FETCH NEXT FROM cursor_update INTO @Mavtu, @Tenvtu, @Phantram;

-- Loop through the cursor and update the price
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Update the price by increasing it by 15%
    UPDATE VATTU
    SET Phantram = Phantram * 1.15
    WHERE Mavtu = @Mavtu;

    -- Fetch the next row
    FETCH NEXT FROM cursor_update INTO @Mavtu, @Tenvtu, @Phantram;
END;

-- Close and deallocate the cursor
CLOSE cursor_update;
DEALLOCATE cursor_update;

-- Display the updated list
SELECT V.Mavtu, V.Tenvtu, V.Phantram
FROM VATTU V
JOIN TONKHO T ON V.Mavtu = T.Mavtu;

--Bài 21. Viết thủ tục kiểm tra tồn kho cho một vật tư (@MaVatTu). Nếu tồn kho > 5, hiển thị "Tồn kho ổn định", ngược lại hiển thị "Cần nhập thêm hàng".
CREATE PROCEDURE sp_KiemTraTonKho @MaVatTu CHAR(4)
AS
BEGIN
    DECLARE @TonKho INT;
    SELECT @TonKho = Slcuoi 
    FROM TONKHO 
    WHERE Mavtu = @MaVatTu AND Namthang = (SELECT MAX(Namthang) FROM TONKHO);

    IF @TonKho > 5
        PRINT 'Ton kho on đinh'
    ELSE
        PRINT 'Can nhap them hang';
END

-- Gọi thủ tục
EXEC sp_KiemTraTonKho 'TV14';
--Bài 22. Sử dụng WHILE để duyệt qua tất cả các sản phẩm có tồn kho dưới 5 và in ra thông báo về số lượng tồn kho.
CREATE PROCEDURE ThongBaoTonKho
AS
BEGIN
    -- Tạo bảng tạm để lưu danh sách sản phẩm có tồn kho dưới 5
    DECLARE @TempTable TABLE (
        Mavtu CHAR(4),
        Tenvtu NVARCHAR(50),
        Slcuoi INT
    );

    -- Chèn dữ liệu các sản phẩm có tồn kho dưới 5 vào bảng tạm
    INSERT INTO @TempTable (Mavtu, Tenvtu, Slcuoi)
    SELECT V.Mavtu, V.Tenvtu, T.Slcuoi
    FROM VATTU V
    JOIN TONKHO T ON V.Mavtu = T.Mavtu
    WHERE T.Slcuoi < 5;

    -- Biến đếm và tổng số dòng trong bảng tạm
    DECLARE @Index INT = 1;
    DECLARE @Total INT = (SELECT COUNT(*) FROM @TempTable);

    -- Biến lưu giá trị từng dòng
    DECLARE @Mavtu CHAR(4);
    DECLARE @Tenvtu NVARCHAR(50);
    DECLARE @Slcuoi INT;

    -- Duyệt qua từng dòng của bảng tạm
    WHILE @Index <= @Total
    BEGIN
        -- Lấy dữ liệu từng dòng dựa vào số thứ tự
        SELECT 
            @Mavtu = Mavtu, 
            @Tenvtu = Tenvtu, 
            @Slcuoi = Slcuoi
        FROM 
            (SELECT ROW_NUMBER() OVER (ORDER BY Mavtu) AS RowNum, * 
             FROM @TempTable) AS Temp
        WHERE Temp.RowNum = @Index;

        -- In thông báo ra
        PRINT N'Sản phẩm: ' + @Tenvtu + N' (Mã: ' + @Mavtu + N') có tồn kho: ' + CAST(@Slcuoi AS NVARCHAR(10));

        -- Tăng biến đếm
        SET @Index = @Index + 1;
    END
END;
--Hiển thị kết quả
EXEC ThongBaoTonKho;
--Bài 23. Dùng vòng lặp FOR để tính tổng số lượng tồn kho của các sản phẩm trong kho
DECLARE @Total INT = 0;
DECLARE @Current INT, @Max INT;

SELECT @Max = COUNT(*) FROM TONKHO WHERE Namthang = (SELECT MAX(Namthang) FROM TONKHO);
DECLARE @cursor CURSOR;
SET @cursor = CURSOR FOR
SELECT Slcuoi
FROM TONKHO 
WHERE Namthang = (SELECT MAX(Namthang) FROM TONKHO);

OPEN @cursor;
SET @Current = 1;

WHILE @Current <= @Max
BEGIN
    DECLARE @Slcuoi INT;
    FETCH NEXT FROM @cursor INTO @Slcuoi;
    SET @Total = @Total + @Slcuoi;
    SET @Current = @Current + 1;
END

CLOSE @cursor;
DEALLOCATE @cursor;

SELECT @Total AS 'Tổng số lượng tồn kho';

--Bài 24. Duyệt qua tất cả các sản phẩm có số lượng tồn kho lớn hơn 10 và cập nhật giá bán của chúng lên 10% (dung cursor)
-- Khai báo biến cursor
DECLARE @Mavtu CHAR(4)
DECLARE @Dgxuat MONEY

-- Khai báo cursor duyệt qua các sản phẩm có số lượng tồn kho lớn hơn 10
DECLARE cur_Tonkho CURSOR FOR
SELECT Mavtu
FROM TONKHO
WHERE Slcuoi > 10

-- Mở cursor
OPEN cur_Tonkho

-- Lấy từng dòng dữ liệu từ cursor
FETCH NEXT FROM cur_Tonkho INTO @Mavtu

-- Vòng lặp để duyệt từng dòng
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Lấy giá xuất hiện tại của sản phẩm
    SELECT TOP 1 @Dgxuat = Dgxuat
    FROM CTPXUAT
    WHERE Mavtu = @Mavtu
    ORDER BY Sopx DESC -- Lấy giá xuất gần nhất nếu có nhiều lần xuất

    -- Nếu tồn tại giá xuất, cập nhật tăng 10%
    IF @Dgxuat IS NOT NULL
    BEGIN
        UPDATE CTPXUAT
        SET Dgxuat = Dgxuat * 1.1
        WHERE Mavtu = @Mavtu
    END

    -- Lấy dòng tiếp theo
    FETCH NEXT FROM cur_Tonkho INTO @Mavtu
END

-- Đóng và hủy cursor
CLOSE cur_Tonkho
DEALLOCATE cur_Tonkho

--Bài 25. Dùng vòng lặp WHILE để xóa các sản phẩm có số lượng tồn kho bằng 5 và in ra danh sách.
DECLARE @Mavtu CHAR(4);

DECLARE cur_Delete CURSOR FOR
SELECT Mavtu
FROM TONKHO
WHERE Slcuoi = 5 AND Namthang = (SELECT MAX(Namthang) FROM TONKHO);

OPEN cur_Delete;

FETCH NEXT FROM cur_Delete INTO @Mavtu;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Đang xóa vật tư: ' + @Mavtu;
    DELETE FROM VATTU WHERE Mavtu = @Mavtu;

    FETCH NEXT FROM cur_Delete INTO @Mavtu;
END

CLOSE cur_Delete;
DEALLOCATE cur_Delete;

-- Hiển thị danh sách còn lại
SELECT * FROM VATTU;


--Họ tên:  Nguyễn Trần Tiến Dạt			MSV:1771020136  			 Lớp:CNTT 1707 

