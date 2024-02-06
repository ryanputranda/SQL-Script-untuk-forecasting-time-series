CREATE DATABASE db_percobaanPrediksi
GO
USE db_percobaanPrediksi
GO
ALTER TABLE ujicobaClone(
	id INT PRIMARY KEY IDENTITY(1,1),
	tahun INT,
	bulan INT,
	angka DECIMAL(5,2)
	prediksi DECIMAL(5,2) NULL
)

ALTER TABLE ujiCobaClone
	ALTER COLUMN angka DECIMAL(5,2) NULL
	ALTER COLUMN bulan INT NULL,
	ALTER COLUMN angka DECIMAL(5,2) NULL
GO

DROP TABLE hasilUjiCoba
DROP TABLE ujiCoba

CREATE TABLE hasilUjiCoba(
	id VARCHAR(30) NULL,
	angkaPrediksi DECIMAL(5,2)
)


DROP TABLE ujicoba

INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2019, 10, 56)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2019, 11, 70)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2019, 12, 63)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 1, 61)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 2, 73)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 3, 78)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 4, 54)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 5, 78)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 6, 56)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 7, 57)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 8, 45)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 9, 50)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 10, 40)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 11, 51)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2020, 12, 57)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2021, 1, 47)
INSERT INTO ujicoba (tahun, bulan, angka) VALUES (2022, 2, 45)

#PERCOBAAN 1
DECLARE @angka INT, @temp INT, @i INT, @k INT
SET @i = 0
SET @k = 1
SET @angka = 0
SET @temp = 0

WHILE @i <= 15
	BEGIN
		WHILE @k <= 3
			BEGIN
				SELECT @angka = angka FROM ujicoba WHERE id = @k
				SET @temp = @temp + @angka 
				SET @k = @k + 1
			END
		PRINT @temp
		SET @i = @i + 3
		SET
	END


#PERCOBAAN 2
SELECT * FROM ujicoba
DECLARE @jml INT, @id1 DECIMAL, @id2 DECIMAL, @id3 DECIMAL, @iterasi INT, @hasilPrediksi DECIMAL, @rata2bergerak INT
DECLARE @idKet VARCHAR(30)
SET @id1 = 1
SET @id2 = 2
SET @id3 = 3
SET @iterasi = 1
SET @rata2bergerak = 3
SELECT @jml = COUNT(id) FROM ujicoba
IF (@jml % 3 = 0)
	WHILE @iterasi <= (@jml+1)
		BEGIN
			SET @rata2bergerak = 1 + @rata2bergerak
			SET @hasilPrediksi = 0
			SELECT @hasilPrediksi = (SUM(angka)/3) FROM ujicoba WHERE id IN (@id1, @id2, @id3)
			SET @idKet = CONVERT(VARCHAR(5), @id3)
			SET @id1 = @id1 + 1
			SET @id2 = @id2 + 1
			SET @id3 = @id3 + 1
			INSERT INTO hasilUjiCoba (id, angkaPrediksi) VALUES (@idKet, @hasilPrediksi)
			IF @rata2bergerak = (@jml + 1)
				BREAK
		END
ELSE
	PRINT 'Tidak dapat mengeksekusi data, banyak data harus kelipatan 3'



DECLARE @no INT
DECLARE @angkaPrediksi DECIMAL
DECLARE dataPrediksi CURSOR FOR
	SELECT * FROM hasilUjiCoba

OPEN dataPrediksi
FETCH NEXT FROM dataPrediksi INTO @no, @angkaPrediksi
PRINT 'ID	' + '	PREDIKSI'
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CONVERT(VARCHAR(3),@no) + '			' + CONVERT(VARCHAR(3),@angkaPrediksi)
		FETCH NEXT FROM dataPrediksi INTO @no, @angkaPrediksi
	END
CLOSE dataPrediksi
DEALLOCATE dataPrediksi



SELECT * FROM hasilUjiCoba
DELETE FROM hasilUjiCoba WHERE angkaPrediksi IS NULL OR id BETWEEN 16 AND 17
TRUNCATE TABLE hasilUjiCoba





#PERCOBAAN 3

--
DECLARE @jml INT, @id1 DECIMAL, @id2 DECIMAL, @id3 DECIMAL, @iterasi INT, @hasilPrediksi DECIMAL, @rata2bergerak INT
DECLARE @idKet VARCHAR(30)
SET @id1 = 1
SET @id2 = 2
SET @id3 = 3
SET @iterasi = 1
SET @rata2bergerak = 3
SELECT @jml = COUNT(id) FROM ujicoba
WHILE @iterasi <= (@jml+2)
	BEGIN
		SET @rata2bergerak = @rata2bergerak + 1
		SET @hasilPrediksi = 0
		SELECT @hasilPrediksi = (SUM(angka)/3) FROM ujicoba WHERE id IN (@id1, @id2, @id3)
		SET @idKet = CONVERT(VARCHAR(5), @id3)
		SET @id1 = @id1 + 1
		SET @id2 = @id2 + 1
		SET @id3 = @id3 + 1
		INSERT INTO hasilUjiCoba (id, angkaPrediksi) VALUES (@rata2bergerak, @hasilPrediksi)
		IF @rata2bergerak = (@jml + 1)
			BREAK
	END
--TAMPIL HASIL PREDIKSINYA:
DECLARE @no INT
DECLARE @angkaPrediksi DECIMAL
DECLARE dataPrediksi CURSOR FOR
	SELECT * FROM hasilUjiCoba

OPEN dataPrediksi
FETCH NEXT FROM dataPrediksi INTO @no, @angkaPrediksi
PRINT 'ID	' + '	PREDIKSI'
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CONVERT(VARCHAR(3),@no) + '			' + CONVERT(VARCHAR(3),@angkaPrediksi)
		FETCH NEXT FROM dataPrediksi INTO @no, @angkaPrediksi
	END
CLOSE dataPrediksi
DEALLOCATE dataPrediksi
TRUNCATE TABLE hasilUjiCoba