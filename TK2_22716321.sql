--LeNhatTruong
USE QUANLIDETAI

--Q1. Cho"biết"họ"tên"và"mức"lương"của"các"giáo"viên"nữ." 
SELECT HOTEN, LUONG
FROM GIAOVIEN
WHERE PHAI = N'Nữ';

--Q2. Cho"biết"họ"tên"của"các"giáo"viên"và"lương"của"họ"sau"khi"tăng"10%." 
SELECT HOTEN, LUONG * 1.10 AS 'LUONG_SAU_TANG'
FROM GIAOVIEN;

--Q3. Cho"biết"mã"của"các"giáo"viên"có"họ"tên"bắt"đầu"là"“Nguyễn”"và"lương"trên"$2000"hoặc,"giáo"viên"là"trưởng" bộ"môn"nhận"chức"sau"năm"1995." 
SELECT MAGV
FROM GIAOVIEN
WHERE (HOTEN LIKE N'Nguyễn%' AND LUONG > 2000)
OR MAGV IN (SELECT TRUONGBM FROM BOMON WHERE NGAYNHANCHUC > '1995-12-31');

--Q4. Cho"biết"tên"những"giáo"viên"khoa"Công"nghệ"thông"tin." 
SELECT G.HOTEN
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM
WHERE B.MAKHOA = 'CNTT';

--Q5. Cho"biết"thông"tin"của"bộ"môn"cùng"thông"tin"giảng"viên"làm"trưởng"bộ"môn"đó."
SELECT B.*, G.HOTEN AS 'TRUONG_BOMON'
FROM BOMON B
JOIN GIAOVIEN G ON B.TRUONGBM = G.MAGV;

--Q6. Với"mỗi"giáo"viên,"hãy"cho"biết"thông"tin"của"bộ"môn"mà"họ"đang"làm"việc." 
SELECT G.HOTEN, B.*
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM;

--Q7. Cho"biết"tên"đề"tài"và"giáo"viên"chủ"nhiệm"đề"tài." 
SELECT D.TENDT, G.HOTEN
FROM DETAI D
JOIN GIAOVIEN G ON D.GVCNDT = G.MAGV;

--Q8. Với"mỗi"khoa"cho"biết"thông"tin"trưởng"khoa." 
SELECT K.TENKHOA, G.*
FROM KHOA K
JOIN GIAOVIEN G ON K.TRUONGKHOA = G.MAGV;

--Q9. Cho"biết"các"giáo"viên"của"bộ"môn"“Vi"sinh”"có"tham"gia"đề"tài"006." 
SELECT G.HOTEN
FROM GIAOVIEN G
JOIN THAMGIADETAI TG ON G.MAGV = TG.MAGV
WHERE G.MABM = 'VS' AND TG.MADT = '006';

--Q10. Với"những"đề"tài"thuộc"cấp"quản"lý"“Thành"phố”,"cho"biết"mã"đề"tài,"đề"tài"thuộc"về"chủ"đề"nào,"họ"tên" người"chủ"nghiệm"đề"tài"cùng"với"ngày"sinh"và"địa"chỉ"của"người"ấy." 
SELECT D.MADT, CD.TENCD, G.HOTEN, G.NGAYSINH, G.DIACHI
FROM DETAI D
JOIN CHUDE CD ON D.MACD = CD.MACD
JOIN GIAOVIEN G ON D.GVCNDT = G.MAGV
WHERE D.CAPQL = N'Thành phố';

--Q11. Tìm"họ"tên"của"từng"giáo"viên"và"người"phụ"trách"chuyên"môn"trực"tiếp"của"giáo"viên"đó." 
SELECT G1.HOTEN AS 'GIÁO VIÊN', G2.HOTEN AS 'PHỤ TRÁCH'
FROM GIAOVIEN G1
JOIN GIAOVIEN G2 ON G1.GVQLCM = G2.MAGV;

--Q12. Tìm"họ"tên"của"những"giáo"viên"được"“Nguyễn"Thanh"Tùng”"phụ"trách"trực"tiếp." 
SELECT G1.HOTEN
FROM GIAOVIEN G1
JOIN GIAOVIEN G2 ON G1.GVQLCM = G2.MAGV
WHERE G2.HOTEN = N'Nguyễn Thanh Tùng';

--Q13. Cho"biết"tên"giáo"viên"là"trưởng"bộ"môn"Hệ"thống"thông"tin." 
SELECT G.HOTEN
FROM GIAOVIEN G
JOIN BOMON B ON G.MAGV = B.TRUONGBM
WHERE B.TENBM = N'Hệ thống thông tin';

--Q14. Cho"biết"tên"người"chủ"nhiệm"đề"tài"của"những"đề"tài"thuộc"chủ"đề"Quản"lý"giáo"dục." 
SELECT G.HOTEN
FROM GIAOVIEN G
JOIN DETAI D ON G.MAGV = D.GVCNDT
WHERE D.MACD = 'QLGD';

--Q15. Cho"biết"tên"các"công"việc"của"đề"tài"HTTT"quản"lý"các"trường"ĐH"có"thời"gian"bắt"đầu"trong"tháng" 3/2008."
SELECT CV.TENCV
FROM CONGVIEC CV
WHERE CV.MADT = '001' 
AND MONTH(CV.NGAYBD) = 3 
AND YEAR(CV.NGAYBD) = 2008;

--Q16. Cho"biết"tên"giáo"viên"và"tên"người"quản"lý"chuyên"môn"của"giáo"viên"đó." 
SELECT G1.HOTEN AS 'GIÁO VIÊN', G2.HOTEN AS 'NGƯỜI QUẢN LÝ CHUYÊN MÔN'
FROM GIAOVIEN G1
LEFT JOIN GIAOVIEN G2 ON G1.GVQLCM = G2.MAGV;

--Q17. Cho"các"công"việc"bắt"đầu"trong"khoảng"từ"01/01/2007"đến"01/08/2007." 
SELECT TENCV
FROM CONGVIEC
WHERE NGAYBD BETWEEN '2007-01-01' AND '2007-08-01';

--Q18. Cho"biết"họ"tên"các"giáo"viên"cùng"bộ"môn"với"giáo"viên"“Trần"Trà"Hương”." 
SELECT G.HOTEN
FROM GIAOVIEN G
WHERE MABM = (SELECT MABM FROM GIAOVIEN WHERE HOTEN = N'Trần Trà Hưong') 
AND HOTEN != N'Trần Trà Hưong';

--Q19. Tìm"những"giáo"viên"vừa"là"trưởng"bộ"môn"vừa"chủ"nhiệm"đề"tài." 
SELECT G.HOTEN
FROM GIAOVIEN G
WHERE MAGV IN (SELECT TRUONGBM FROM BOMON) 
AND MAGV IN (SELECT GVCNDT FROM DETAI);

--Q20. Cho"biết"tên"những"giáo"viên"vừa"là"trưởng"khoa"và"vừa"là"trưởng"bộ"môn." 
SELECT G.HOTEN
FROM GIAOVIEN G
WHERE MAGV IN (SELECT TRUONGKHOA FROM KHOA) 
AND MAGV IN (SELECT TRUONGBM FROM BOMON);

--Q21. Cho"biết"tên"những"trưởng"bộ"môn"mà"vừa"chủ"nhiệm"đề"tài"" 
SELECT G.HOTEN
FROM GIAOVIEN G
WHERE MAGV IN (SELECT TRUONGBM FROM BOMON) 
AND MAGV IN (SELECT GVCNDT FROM DETAI);

--Q22. Cho"biết"mã"số"các"trưởng"khoa"có"chủ"nhiệm"đề"tài." 
SELECT G.MAGV
FROM GIAOVIEN G
WHERE MAGV IN (SELECT TRUONGKHOA FROM KHOA) 
AND MAGV IN (SELECT GVCNDT FROM DETAI);

--Q23. Cho"biết"mã"số"các"giáo"viên"thuộc"bộ"môn"HTTT"hoặc"có"tham"gia"đề"tài"mã"001." 
SELECT MAGV
FROM GIAOVIEN
WHERE MABM = 'HTTT' 
OR MAGV IN (SELECT MAGV FROM THAMGIADETAI WHERE MADT = '001');

--Q24. Cho"biết"giáo"viên"làm"việc"cùng"bộ"môn"với"giáo"viên"002."
SELECT G.HOTEN
FROM GIAOVIEN G
WHERE MABM = (SELECT MABM FROM GIAOVIEN WHERE MAGV = '002') 
AND MAGV != '002';

--Q25. Tìm"những"giáo"viên"là"trưởng"bộ"môn." 
SELECT HOTEN
FROM GIAOVIEN
WHERE MAGV IN (SELECT TRUONGBM FROM BOMON);

--Q26. Cho"biết"họ"tên"và"mức"lương"của"các"giáo"viên." 
SELECT HOTEN, LUONG
FROM GIAOVIEN;

--Q27. Cho"biết"số"lượng"giáo"viên"viên"và"tổng"lương"của"họ." 
SELECT COUNT(*) AS 'SL giáo viên', SUM(LUONG) AS 'Tổng lương'
FROM GIAOVIEN;

--Q28. Cho"biết"số"lượng"giáo"viên"và"lương"trung"bình"của"từng"bộ"môn." 
SELECT B.TENBM, COUNT(G.MAGV) AS 'SL giáo viên', AVG(G.LUONG) AS 'Lương TB'
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM
GROUP BY B.TENBM;

--Q29. Cho"biết"tên"chủ"đề"và"số"lượng"đề"tài"thuộc"về"chủ"đề"đó." 
SELECT C.TENCD, COUNT(D.MADT) AS 'SL đề tài'
FROM CHUDE C
LEFT JOIN DETAI D ON C.MACD = D.MACD
GROUP BY C.TENCD;

--Q30. Cho"biết"tên"giáo"viên"và"số"lượng"đề"tài"mà"giáo"viên"đó"tham"gia." 
SELECT G.HOTEN, COUNT(T.MADT) AS 'SL đề tài'
FROM GIAOVIEN G
JOIN THAMGIADETAI T ON G.MAGV = T.MAGV
GROUP BY G.HOTEN;

--Q31. Cho"biết"tên"giáo"viên"và"số"lượng"đề"tài"mà"giáo"viên"đó"làm"chủ"nhiệm." 
SELECT G.HOTEN, COUNT(D.MADT) AS 'SL đề tài'
FROM GIAOVIEN G
JOIN DETAI D ON G.MAGV = D.GVCNDT
GROUP BY G.HOTEN;

--Q32. Với"mỗi"giáo"viên"cho"tên"giáo"viên"và"số"người"thân"của"giáo"viên"đó." 
SELECT G.HOTEN, COUNT(NT.TEN) AS 'Số người thân'
FROM GIAOVIEN G
LEFT JOIN NGUOITHAN NT ON G.MAGV = NT.MAGV
GROUP BY G.HOTEN;

--Q33. Cho"biết"tên"những"giáo"viên"đã"tham"gia"từ"3"đề"tài"trở"lên." 
SELECT G.HOTEN
FROM GIAOVIEN G
JOIN THAMGIADETAI T ON G.MAGV = T.MAGV
GROUP BY G.HOTEN
HAVING COUNT(T.MADT) >= 3;

--Q34. Cho"biết"số"lượng"giáo"viên"đã"tham"gia"vào"đề"tài"Ứng"dụng"hóa"học"xanh." 
SELECT COUNT(G.MAGV) AS 'Số lượng giáo viên'
FROM GIAOVIEN G
JOIN THAMGIADETAI T ON G.MAGV = T.MAGV
WHERE T.MADT IN (SELECT MADT FROM DETAI WHERE TENDT = N'Ứng dụng hóa học xanh');

--Q35. Cho"biết"mức"lương"cao"nhất"của"các"giảng"viên."
SELECT MAX(LUONG) AS 'Mức lương cao nhất'
FROM GIAOVIEN;

--Q36. Cho"biết"những"giáo"viên"có"lương"lớn"nhất." 
SELECT HOTEN, LUONG
FROM GIAOVIEN
WHERE LUONG = (SELECT MAX(LUONG) FROM GIAOVIEN);

--Q37. Cho"biết"lương"cao"nhất"trong"bộ"môn"“HTTT”." 
SELECT MAX(LUONG) AS 'Lương cao nhất'
FROM GIAOVIEN
WHERE MABM = (SELECT MABM FROM BOMON WHERE MABM = N'HTTT');

--Q38. Cho"biết"tên"giáo"viên"lớn"tuổi"nhất"của"bộ"môn"Hệ"thống"thông"tin." 
SELECT TOP 1  HOTEN 
FROM GIAOVIEN
WHERE MABM = (SELECT MABM FROM BOMON WHERE MABM = N'HTTT')
ORDER BY NGAYSINH ASC

--Q39. Cho"biết"tên"giáo"viên"nhỏ"tuổi"nhất"khoa"Công"nghệ"thông"tin." 
SELECT TOP 1  HOTEN
FROM GIAOVIEN G
JOIN BOMON BM ON G.MABM = BM.MABM
JOIN KHOA K ON BM.MAKHOA = K.MAKHOA
WHERE K.TENKHOA = N'Công nghệ thông tin'
ORDER BY NGAYSINH DESC

--Q40. Cho"biết"tên"giáo"viên"và"tên"khoa"của"giáo"viên"có"lương"cao"nhất." 
SELECT G.HOTEN, K.TENKHOA
FROM GIAOVIEN G
JOIN BOMON BM ON G.MABM = BM.MABM
JOIN KHOA K ON BM.MAKHOA = K.MAKHOA
WHERE G.LUONG = (SELECT MAX(LUONG) FROM GIAOVIEN);

--Q41. Cho"biết"những"giáo"viên"có"lương"lớn"nhất"trong"bộ"môn"của"họ." 
SELECT G.HOTEN, B.TENBM, G.LUONG
FROM GIAOVIEN G
JOIN BOMON B ON G.MABM = B.MABM
WHERE G.LUONG = (SELECT MAX(LUONG) FROM GIAOVIEN GV2 WHERE GV2.MABM = G.MABM);

--Q42. Cho"biết"tên"những"đề"tài"mà"giáo"viên"Nguyễn"Hoài"An"chưa"tham"gia." 
SELECT D.TENDT
FROM DETAI D
WHERE D.MADT NOT IN (SELECT T.MADT FROM THAMGIADETAI T WHERE T.MAGV = (SELECT MAGV FROM GIAOVIEN WHERE HOTEN = N'Nguyễn Hoài An'));

--Q43. Cho"biết"những"đề"tài"mà"giáo"viên"Nguyễn"Hoài"An"chưa"tham"gia."Xuất"ra"tên"đề"tài,"tên"người"chủ" nhiệm"đề"tài."
SELECT D.TENDT, G.HOTEN AS 'Chủ nhiệm'
FROM DETAI D
JOIN GIAOVIEN G ON D.GVCNDT = G.MAGV
WHERE D.MADT NOT IN (SELECT T.MADT FROM THAMGIADETAI T WHERE T.MAGV = (SELECT MAGV FROM GIAOVIEN WHERE HOTEN = N'Nguyễn Hoài An'));

--Q44. Cho"biết"tên"những"giáo"viên"khoa"Công"nghệ"thông"tin"mà"chưa"tham"gia"đề"tài"nào." 
SELECT HOTEN
FROM GIAOVIEN
WHERE MABM IN (SELECT MABM FROM BOMON WHERE MAKHOA='CNTT')
AND MAGV NOT IN (SELECT DISTINCT MAGV FROM THAMGIADETAI);

--Q45. Tìm"những"giáo"viên"không"tham"gia"bất"kỳ"đề"tài"nào 
SELECT HOTEN
FROM GIAOVIEN
WHERE MAGV NOT IN (SELECT DISTINCT MAGV FROM THAMGIADETAI);

--Q46. Cho"biết"giáo"viên"có"lương"lớn"hơn"lương"của"giáo"viên"“Nguyễn"Hoài"An”" 
SELECT HOTEN
FROM GIAOVIEN
WHERE LUONG > (SELECT LUONG FROM GIAOVIEN WHERE HOTEN=N'Nguyễn Hoài An');

--Q47. Tìm"những"trưởng"bộ"môn"tham"gia"tối"thiểu"1"đề"tài" 
SELECT HOTEN
FROM GIAOVIEN
WHERE MAGV IN (SELECT TRUONGBM FROM BOMON)
AND MAGV IN (SELECT DISTINCT MAGV FROM THAMGIADETAI);

--Q48. Tìm"giáo"viên"trùng"tên"và"cùng"giới"tính"với"giáo"viên"khác"trong"cùng"bộ"môn" 
SELECT A.HOTEN
FROM GIAOVIEN A, GIAOVIEN B
WHERE A.MAGV != B.MAGV AND A.HOTEN = B.HOTEN AND A.PHAI = B.PHAI AND A.MABM = B.MABM;

--Q49. Tìm"những"giáo"viên"có"lương"lớn"hơn"lương"của"ít"nhất"một"giáo"viên"bộ"môn"“Công"nghệ"phần"mềm”" 
SELECT HOTEN
FROM GIAOVIEN
WHERE LUONG > ANY (SELECT LUONG FROM GIAOVIEN WHERE MABM = (SELECT MABM FROM BOMON WHERE TENBM = N'Công nghệ phần mềm'));

--Q50. Tìm"những"giáo"viên"có"lương"lớn"hơn"lương"của"tất"cả"giáo"viên"thuộc"bộ"môn"“Hệ"thống"thông"tin”" 
SELECT HOTEN
FROM GIAOVIEN
WHERE LUONG > ALL (SELECT LUONG FROM GIAOVIEN WHERE MABM = (SELECT MABM FROM BOMON WHERE TENBM = N'Hệ thống thông tin'));

--Q51. Cho"biết"tên"khoa"có"đông"giáo"viên"nhất" 
SELECT TOP 1 MAKHOA 
FROM BOMON JOIN GIAOVIEN ON BOMON.MABM = GIAOVIEN.MABM
GROUP BY MAKHOA
ORDER BY COUNT(MAGV) DESC 

--Q52. Cho"biết"họ"tên"giáo"viên"chủ"nhiệm"nhiều"đề"tài"nhất" 
SELECT HOTEN
FROM GIAOVIEN
WHERE MAGV = (SELECT TOP 1 GVCNDT FROM DETAI GROUP BY GVCNDT ORDER BY COUNT(GVCNDT) DESC);

--Q53. Cho"biết"mã"bộ"môn"có"nhiều"giáo"viên"nhất" 
SELECT TOP 1  MABM
FROM GIAOVIEN
GROUP BY MABM
ORDER BY COUNT(MAGV) DESC

--Q54. Cho"biết"tên"giáo"viên"và"tên"bộ"môn"của"giáo"viên"tham"gia"nhiều"đề"tài"nhất." 
SELECT GIAOVIEN.HOTEN, BOMON.TENBM
FROM GIAOVIEN JOIN BOMON ON GIAOVIEN.MABM = BOMON.MABM
WHERE MAGV = (SELECT TOP 1 MAGV FROM THAMGIADETAI GROUP BY MAGV ORDER BY COUNT(MADT) DESC);

--Q55. Cho"biết"tên"giáo"viên"tham"gia"nhiều"đề"tài"nhất"của"bộ"môn"HTTT." 
SELECT HOTEN
FROM GIAOVIEN
WHERE MAGV IN (SELECT TOP 1  MAGV FROM THAMGIADETAI WHERE MADT IN (SELECT MADT FROM DETAI WHERE GVCNDT IN (SELECT MAGV FROM GIAOVIEN WHERE MABM = (SELECT MABM FROM BOMON WHERE MABM = N'HTTT'))) GROUP BY MAGV ORDER BY COUNT(MADT) DESC );

--Q56. Cho"biết"tên"giáo"viên"và"tên"bộ"môn"của"giáo"viên"có"nhiều"người"thân"nhất." 
SELECT GIAOVIEN.HOTEN, BOMON.TENBM
FROM GIAOVIEN JOIN BOMON ON GIAOVIEN.MABM = BOMON.MABM
WHERE MAGV = (SELECT TOP 1  MAGV FROM NGUOITHAN GROUP BY MAGV ORDER BY COUNT(TEN) DESC);

--Q57. Cho"biết"tên"trưởng"bộ"môn"mà"chủ"nhiệm"nhiều"đề"tài"nhất."
SELECT HOTEN
FROM GIAOVIEN
WHERE MAGV = (SELECT TOP 1 TRUONGBM FROM BOMON WHERE TRUONGBM IN (SELECT TOP 1 GVCNDT FROM DETAI GROUP BY GVCNDT ORDER BY COUNT(GVCNDT) DESC ));
