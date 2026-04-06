ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER TRIETTH2 IDENTIFIED BY 123;
GRANT DBA TO TRIETTH2;
GRANT ALL PRIVILEGES TO TRIETTH2;
ALTER USER TRIETTH2 QUOTA UNLIMITED ON USERS;

SPOOL Tuan2_1250080211.sql

CREATE TABLE REGIONS (
    REGION_ID NUMBER PRIMARY KEY, 
    REGION_NAME VARCHAR2(25)
);

CREATE TABLE COUNTRIES (
    COUNTRY_ID CHAR(2) PRIMARY KEY, 
    COUNTRY_NAME VARCHAR2(40), 
    REGION_ID NUMBER REFERENCES REGIONS(REGION_ID)
);

CREATE TABLE LOCATIONS (
    LOCATION_ID NUMBER(4) PRIMARY KEY, 
    STREET_ADDRESS VARCHAR2(40), 
    CITY VARCHAR2(30), 
    STATE_PROVINCE VARCHAR2(25), 
    POSTAL_CODE VARCHAR2(12), 
    COUNTRY_ID CHAR(2) REFERENCES COUNTRIES(COUNTRY_ID)
);

CREATE TABLE DEPARTMENTS (
    DEPARTMENT_ID NUMBER(4) PRIMARY KEY, 
    DEPARTMENT_NAME VARCHAR2(30), 
    MANAGER_ID NUMBER(6), 
    LOCATION_ID NUMBER(4) REFERENCES LOCATIONS(LOCATION_ID)
);

CREATE TABLE JOBS (
    JOB_ID VARCHAR2(10) PRIMARY KEY, 
    JOB_TITLE VARCHAR2(35), 
    MIN_SALARY NUMBER(6), 
    MAX_SALARY NUMBER(6)
);

CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID NUMBER(6) PRIMARY KEY, 
    FIRST_NAME VARCHAR2(20), 
    LAST_NAME VARCHAR2(25), 
    EMAIL VARCHAR2(25), 
    PHONE_NUMBER VARCHAR2(20), 
    HIRE_DATE DATE, 
    JOB_ID VARCHAR2(10) REFERENCES JOBS(JOB_ID), 
    SALARY NUMBER(8,2), 
    COMMISSION_PCT NUMBER(2,2), 
    MANAGER_ID NUMBER(6) REFERENCES EMPLOYEES(EMPLOYEE_ID), 
    DEPARTMENT_ID NUMBER(4) REFERENCES DEPARTMENTS(DEPARTMENT_ID)
);

CREATE TABLE JOB_HISTORY (
    EMPLOYEE_ID NUMBER(6) REFERENCES EMPLOYEES(EMPLOYEE_ID), 
    START_DATE DATE, 
    END_DATE DATE, 
    JOB_ID VARCHAR2(10) REFERENCES JOBS(JOB_ID), 
    DEPARTMENT_ID NUMBER(4) REFERENCES DEPARTMENTS(DEPARTMENT_ID), 
    PRIMARY KEY (EMPLOYEE_ID, START_DATE)
);

ALTER TABLE DEPARTMENTS ADD CONSTRAINT DEPT_MGR_FK FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID);

INSERT INTO REGIONS VALUES (1, 'Global');

INSERT INTO COUNTRIES VALUES ('US', 'United States', 1);
INSERT INTO COUNTRIES VALUES ('CA', 'Canada', 1);
INSERT INTO COUNTRIES VALUES ('VN', 'Viet Nam', 1);

INSERT INTO LOCATIONS VALUES (1500, 'Q1', 'San Francisco', 'California', '90000', 'US');
INSERT INTO LOCATIONS VALUES (1700, 'Q3', 'Ho Chi Minh', 'Ho Chi Minh', '70000', 'VN');
INSERT INTO LOCATIONS VALUES (1800, 'Q5', 'Toronto', 'Ontario', 'M5V', 'CA');

INSERT INTO DEPARTMENTS VALUES (10, 'Admin', NULL, 1700);
INSERT INTO DEPARTMENTS VALUES (20, 'Marketing', NULL, 1800);
INSERT INTO DEPARTMENTS VALUES (50, 'Shipping', NULL, 1500);
INSERT INTO DEPARTMENTS VALUES (80, 'Sales', NULL, 1700);
INSERT INTO DEPARTMENTS VALUES (90, 'Executive', NULL, 1700);
INSERT INTO DEPARTMENTS VALUES (500, 'Testing', NULL, 1700);

INSERT INTO JOBS VALUES ('AD_PRES', 'President', 20000, 40000);
INSERT INTO JOBS VALUES ('AD_VP', 'Vice President', 15000, 30000);
INSERT INTO JOBS VALUES ('SA_MAN', 'Sales Manager', 10000, 20000);
INSERT INTO JOBS VALUES ('SA_REP', 'Sales Rep', 6000, 12000);
INSERT INTO JOBS VALUES ('ST_CLERK', 'Clerk', 2000, 5000);
INSERT INTO JOBS VALUES ('IT_PROG', 'Programmer', 4000, 10000);

INSERT INTO EMPLOYEES VALUES (100, 'Steven', 'King', 'SKING', '0901', TO_DATE('17/06/1987', 'DD/MM/YYYY'), 'AD_PRES', 24000, NULL, NULL, 90);
INSERT INTO EMPLOYEES VALUES (149, 'Jones', 'Zlotkey', 'EZLOT', '0902', TO_DATE('29/01/1994', 'DD/MM/YYYY'), 'SA_MAN', 10500, 0.2, 100, 80);
INSERT INTO EMPLOYEES VALUES (151, 'Jones', 'Davies', 'CDAVI', '0903', TO_DATE('29/01/1997', 'DD/MM/YYYY'), 'ST_CLERK', 3100, NULL, 100, 50);
INSERT INTO EMPLOYEES VALUES (3, 'John', 'Doe', 'JDOE', '0904', TO_DATE('01/01/1990', 'DD/MM/YYYY'), 'IT_PROG', 4500, NULL, 100, 50);
INSERT INTO EMPLOYEES VALUES (101, 'Triết', 'Dương', 'DTRIET', '0905', TO_DATE('15/05/1986', 'DD/MM/YYYY'), 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO EMPLOYEES VALUES (102, 'Bảo', 'Nguyễn', 'BNGUYEN', '0906', TO_DATE('25/06/2004', 'DD/MM/YYYY'), 'IT_PROG', 800, NULL, 100, 50);
INSERT INTO EMPLOYEES VALUES (103, 'Lan', 'Phan', 'LPHAN', '0907', TO_DATE('25/03/1998', 'DD/MM/YYYY'), 'SA_REP', 5000, 0.15, 149, 80);
INSERT INTO EMPLOYEES VALUES (104, 'Thanh', 'Le Anh', 'TLEANH', '0908', TO_DATE('17/08/1996', 'DD/MM/YYYY'), 'ST_CLERK', 4000, NULL, 100, 20);
INSERT INTO EMPLOYEES VALUES (105, 'Trúc', 'Mai', 'TMAI', '0909', TO_DATE('10/10/1997', 'DD/MM/YYYY'), 'ST_CLERK', 3500, NULL, 100, 20);

COMMIT;

SELECT last_name, salary
FROM employees
WHERE salary > 12000;

SELECT last_name, salary
FROM   employees
WHERE  salary < 5000 OR salary > 12000;

SELECT last_name, salary
FROM   employees
WHERE  salary NOT BETWEEN 5000 AND 12000;

SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN TO_DATE('20/02/1998','DD/MM/YYYY')
AND TO_DATE('01/05/1998','DD/MM/YYYY')
ORDER BY hire_date ASC;

SELECT last_name, department_id
FROM employees
WHERE department_id IN (20, 50)
ORDER BY last_name ASC;

SELECT last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '1994';

SELECT last_name, hire_date
FROM employees
WHERE hire_date BETWEEN TO_DATE('01/01/1994','DD/MM/YYYY')
AND TO_DATE('31/12/1994','DD/MM/YYYY');

SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

SELECT last_name
FROM employees
WHERE last_name LIKE '%a%'
AND last_name LIKE '%e%';

SELECT last_name, job_id, salary
FROM  employees
WHERE job_id IN ('SA_REP', 'ST_CLERK')
AND  salary NOT IN (2500, 3500, 7000);

SELECT employee_id,
       last_name,
       ROUND(salary * 1.15, 0) AS "New Salary"
FROM employees;

SELECT INITCAP(last_name) AS "Ten Nhan Vien",
       LENGTH(last_name) AS "Chieu Dai"
FROM employees
WHERE SUBSTR(last_name, 1, 1) IN ('J','A','L','M')
ORDER BY last_name ASC;

SELECT last_name,
    TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "So Thang Lam Viec"
FROM employees
ORDER BY MONTHS_BETWEEN(SYSDATE, hire_date) ASC;

SELECT last_name || ' earns '
    || TO_CHAR(salary, '$99,999') || ' monthly but wants '
    || TO_CHAR(salary*3, '$99,999') AS "Dream Salaries"
FROM employees;

SELECT last_name,
       CASE WHEN commission_pct IS NULL THEN 'No commission'
            ELSE TO_CHAR(commission_pct)
       END AS "Commission"
FROM employees;

SELECT last_name,
       NVL(TO_CHAR(commission_pct), 'No commission') AS "Commission"
FROM employees;

SELECT job_id,
    DECODE(job_id,
        'AD_PRES',  'A',
        'ST_MAN',   'B',
        'IT_PROG',  'C',
        'SA_REP',   'D',
        'ST_CLERK', 'E',
        '0') AS "GRADE"
FROM employees;

SELECT job_id,
    CASE job_id
        WHEN 'AD_PRES'  THEN 'A'
        WHEN 'ST_MAN'   THEN 'B'
        WHEN 'IT_PROG'  THEN 'C'
        WHEN 'SA_REP'   THEN 'D'
        WHEN 'ST_CLERK' THEN 'E'
        ELSE '0'
    END AS "GRADE"
FROM employees;

SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id
AND  d.location_id   = l.location_id
AND  UPPER(l.city)   = 'TORONTO';

SELECT e.employee_id AS "Ma NV",
       e.last_name AS "Ten NV",
       m.employee_id AS "Ma Quan Ly",
       m.last_name AS "Ten Quan Ly"
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

SELECT e1.last_name AS "Nhan Vien 1",
       e2.last_name AS "Nhan Vien 2",
       e1.department_id AS "Phong Ban"
FROM employees e1, employees e2
WHERE e1.department_id = e2.department_id
AND e1.employee_id < e2.employee_id
ORDER BY e1.department_id, e1.last_name;

SELECT last_name, hire_date
FROM   employees
WHERE  hire_date > (SELECT hire_date
                    FROM   employees
                    WHERE  last_name = 'Davies');

SELECT e.last_name   AS "Nhan Vien",
       e.hire_date   AS "Ngay Vao",
       m.last_name   AS "Quan Ly",
       m.hire_date   AS "Quan Ly Vao"
FROM   employees e, employees m
WHERE  e.manager_id = m.employee_id
AND  e.hire_date  < m.hire_date;

SELECT job_id,
       MIN(salary) AS "Luong Thap Nhat",
       MAX(salary) AS "Luong Cao Nhat",
       ROUND(AVG(salary),2) AS "Luong Trung Binh",
       SUM(salary) AS "Tong Luong"
FROM   employees
GROUP BY job_id
ORDER BY job_id;

SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS "So Nhan Vien"
FROM   departments d LEFT JOIN employees e
       ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;

SELECT COUNT(*) AS "Tong NV",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1995' THEN 1 ELSE 0 END) AS "Nam 1995",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1996' THEN 1 ELSE 0 END) AS "Nam 1996",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1997' THEN 1 ELSE 0 END) AS "Nam 1997",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1998' THEN 1 ELSE 0 END) AS "Nam 1998"
FROM   employees;

SELECT last_name, hire_date
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM   employees
                        WHERE  last_name = 'Zlotkey')
  AND  last_name <> 'Zlotkey';

SELECT last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   departments
                         WHERE  location_id = 1700);

SELECT last_name, manager_id
FROM   employees
WHERE  manager_id IN (SELECT employee_id
                      FROM   employees
                      WHERE  last_name = 'King');

SELECT last_name, salary, department_id
FROM   employees
WHERE  salary > (SELECT AVG(salary) FROM employees)
  AND  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  last_name LIKE '%n');

SELECT department_id, department_name
FROM departments d
WHERE (SELECT COUNT(*) FROM employees e
WHERE e.department_id = d.department_id) < 3
ORDER BY department_id;

SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS "So NV"
FROM departments d LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3
ORDER BY d.department_id;

SELECT department_id, COUNT(*) AS "So Nhan Vien", 'Dong nhat' AS "Loai"
FROM employees
GROUP BY department_id
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM employees GROUP BY department_id)
UNION ALL
SELECT department_id, COUNT(*), 'It nhat'
FROM employees
GROUP BY department_id
HAVING COUNT(*) = (SELECT MIN(COUNT(*)) FROM employees GROUP BY department_id);

SELECT last_name, hire_date,
       TO_CHAR(hire_date,'Day') AS "Thu trong tuan"
FROM   employees
WHERE  TO_CHAR(hire_date,'Day') = (
    SELECT TO_CHAR(hire_date,'Day')
    FROM   employees
    GROUP BY TO_CHAR(hire_date,'Day')
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(*))
        FROM   employees
        GROUP BY TO_CHAR(hire_date,'Day')
    )
);

SELECT last_name, salary
FROM (
    SELECT last_name, salary
    FROM   employees
    ORDER BY salary DESC
)
WHERE ROWNUM <= 3;

SELECT e.last_name, e.department_id
FROM   employees    e,
       departments  d,
       locations    l
WHERE  e.department_id = d.department_id
  AND  d.location_id   = l.location_id
  AND  UPPER(l.state_province) = 'CALIFORNIA';

SELECT employee_id, last_name FROM employees WHERE employee_id = 3;
UPDATE employees
SET    last_name = 'Drexler'
WHERE  employee_id = 3;
COMMIT;
SELECT employee_id, last_name FROM employees WHERE employee_id = 3;

SELECT e1.last_name, e1.salary, e1.department_id
FROM   employees e1
WHERE  e1.salary < (SELECT AVG(e2.salary)
                    FROM   employees e2
                    WHERE  e2.department_id = e1.department_id)
ORDER BY e1.department_id;

-- Kiem tra truoc: xem ai bi anh huong
SELECT employee_id, last_name, salary
FROM   employees
WHERE  salary < 900;
-- Tang luong
UPDATE employees
SET    salary = salary + 100
WHERE  salary < 900;
COMMIT;

-- Kiem tra: co nhan vien trong phong 500 khong?
SELECT COUNT(*) FROM employees WHERE department_id = 500;
-- Truong hop 1: Phong trong (khong co nhan vien)
DELETE FROM departments WHERE department_id = 500;
COMMIT;
-- Truong hop 2: Phong co nhan vien -> phai xu ly truoc
UPDATE employees SET department_id = NULL WHERE department_id = 500;
DELETE FROM departments WHERE department_id = 500;
COMMIT;

-- Kiem tra truoc
SELECT department_id, department_name FROM departments
WHERE  department_id NOT IN (
    SELECT DISTINCT department_id FROM employees
    WHERE  department_id IS NOT NULL
);

-- Thuc hien xoa
DELETE FROM departments
WHERE  department_id NOT IN (
    SELECT DISTINCT department_id FROM employees
    WHERE  department_id IS NOT NULL
);
COMMIT;

DELETE FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e
    WHERE e.department_id = d.department_id
);
COMMIT;

--BAI TAP AP DUNG
--A1 TAO BANG CSDL QLDIEM
CREATE TABLE DMKHOA (
    MAKHOA CHAR(2) CONSTRAINT DMKHOA_MAKHOA_PK PRIMARY KEY,
    TENKHOA NVARCHAR2(30)
);

CREATE TABLE DMMH (
    MAMH CHAR(2) CONSTRAINT DMMH_MAMH_PK PRIMARY KEY,
    TENMH NVARCHAR2(35),
    SOTIET NUMBER(3)
);

CREATE TABLE DMSV (
    MASV CHAR(3) CONSTRAINT DMSV_MASV_PK PRIMARY KEY,
    HOSV NVARCHAR2(30),
    TENSV NVARCHAR2(10),
    PHAI NVARCHAR2(3),
    NGAYSINH DATE,
    NOISINH NVARCHAR2(25),
    MAKH CHAR(2) CONSTRAINT DMSV_DMKHOA_MAKH_FK REFERENCES DMKHOA(MAKHOA),
    HOCBONG NUMBER(10,0)
);

CREATE TABLE KETQUA (
    MASV CHAR(3) CONSTRAINT KETQUA_DMSV_MASV_FK REFERENCES DMSV(MASV),
    MAMH CHAR(2) CONSTRAINT KETQUA_DMMH_MAMH_FK REFERENCES DMMH(MAMH),
    CONSTRAINT KETQUA_MASV_MAMH_PK PRIMARY KEY (MASV, MAMH)
);

INSERT INTO DMKHOA VALUES ('CN', 'Công Nghệ Thông Tin');
INSERT INTO DMKHOA VALUES ('KT', 'Kế Toán - Kiểm Toán');
INSERT INTO DMKHOA VALUES ('NN', 'Ngoại Ngữ');
INSERT INTO DMKHOA VALUES ('QT', 'Quản Trị Kinh Doanh');
INSERT INTO DMKHOA VALUES ('XD', 'Xây Dựng');

INSERT INTO DMMH VALUES ('01', 'Cơ Sở Dữ Liệu', 45);
INSERT INTO DMMH VALUES ('02', 'Lập Trình Java', 60);
INSERT INTO DMMH VALUES ('03', 'Tiếng Anh Giao Tiếp', 30);
INSERT INTO DMMH VALUES ('04', 'Kinh Tế Vi Mô', 45);
INSERT INTO DMMH VALUES ('05', 'Toán Cao Cấp', 60);
INSERT INTO DMMH VALUES ('06', 'Pháp Luật Đại Cương', 30);

INSERT INTO DMSV VALUES ('S01', 'Dương', 'Triết', 'Nam', TO_DATE('06/11/2005', 'DD/MM/YYYY'), 'Hồ Chí Minh', 'CN', 2500000);
INSERT INTO DMSV VALUES ('S02', 'Trần Thị', 'Lan', 'Nữ', TO_DATE('20/10/2004', 'DD/MM/YYYY'), 'Đồng Nai', 'KT', 0);
INSERT INTO DMSV VALUES ('S03', 'Lê Hoàng', 'Sơn', 'Nam', TO_DATE('02/01/2005', 'DD/MM/YYYY'), 'Bình Dương', 'CN', 1500000);
INSERT INTO DMSV VALUES ('S04', 'Phạm', 'Sinh', 'Nam', TO_DATE('15/01/2005', 'DD/MM/YYYY'), 'Cần Thơ', 'NN', 500000);
INSERT INTO DMSV VALUES ('S05', 'Nguyễn Quỳnh', 'Như', 'Nữ', TO_DATE('30/04/2006', 'DD/MM/YYYY'), 'Hà Nội', 'QT', 0);
INSERT INTO DMSV VALUES ('S06', 'Vũ Đức', 'Mạnh', 'Nam', TO_DATE('12/07/2004', 'DD/MM/YYYY'), 'Hải Phòng', 'XD', 1000000);
INSERT INTO DMSV VALUES ('S07', 'Hoàng', 'Mai', 'Nữ', TO_DATE('08/03/2005', 'DD/MM/YYYY'), 'Hồ Chí Minh', 'NN', 1200000);
INSERT INTO DMSV VALUES ('S08', 'Đinh Bá', 'Tiến', 'Nam', TO_DATE('25/11/2004', 'DD/MM/YYYY'), 'Hà Nội', 'CN', 0);
INSERT INTO DMSV VALUES ('S09', 'Phan Thị', 'Bích', 'Nữ', TO_DATE('14/02/2006', 'DD/MM/YYYY'), 'Đà Nẵng', 'KT', 800000);
INSERT INTO DMSV VALUES ('S10', 'Trương', 'Nam', 'Nam', TO_DATE('19/08/2005', 'DD/MM/YYYY'), 'Nha Trang', 'QT', 0);

INSERT INTO KETQUA VALUES ('S01', '01');
INSERT INTO KETQUA VALUES ('S01', '02');
INSERT INTO KETQUA VALUES ('S01', '05');
INSERT INTO KETQUA VALUES ('S02', '03');
INSERT INTO KETQUA VALUES ('S02', '04');
INSERT INTO KETQUA VALUES ('S03', '01');
INSERT INTO KETQUA VALUES ('S03', '02');
INSERT INTO KETQUA VALUES ('S04', '03');
INSERT INTO KETQUA VALUES ('S05', '04');
INSERT INTO KETQUA VALUES ('S05', '06');
INSERT INTO KETQUA VALUES ('S06', '05');
INSERT INTO KETQUA VALUES ('S07', '03');
INSERT INTO KETQUA VALUES ('S07', '06');
INSERT INTO KETQUA VALUES ('S08', '01');
INSERT INTO KETQUA VALUES ('S10', '04');

COMMIT;

--A2. CSDL QUẢN LÝ ĐỀ ÁN CÔNG TY
CREATE TABLE PHONGBAN (
    MAPHG NUMBER(2) CONSTRAINT PHONGBAN_MAPHG_PK PRIMARY KEY,
    TENPHG NVARCHAR2(50) NOT NULL,
    TRPHG NUMBER(5),
    NG_NHANCHUC DATE
);

CREATE TABLE NHANVIEN (
    MANV NUMBER(5) CONSTRAINT NHANVIEN_MANV_PK PRIMARY KEY,
    HONV NVARCHAR2(20),
    TENLOT NVARCHAR2(20),
    TENNV NVARCHAR2(20) NOT NULL,
    NGSINH DATE,
    DCHI NVARCHAR2(100),
    PHAI NVARCHAR2(5),
    LUONG NUMBER(10,2),
    MA_NQL NUMBER(5) CONSTRAINT NHANVIEN_NQL_FK REFERENCES NHANVIEN(MANV),
    PHG NUMBER(2) CONSTRAINT NHANVIEN_PHONGBAN_FK REFERENCES PHONGBAN(MAPHG)
);
ALTER TABLE PHONGBAN ADD CONSTRAINT PHONGBAN_TRPHG_FK FOREIGN KEY (TRPHG) REFERENCES NHANVIEN(MANV);

CREATE TABLE DIADIEM_PHG (
    MAPHG NUMBER(2) CONSTRAINT DIADIEM_PHG_MAPHG_FK REFERENCES PHONGBAN(MAPHG),
    DIADIEM NVARCHAR2(50),
    CONSTRAINT DIADIEM_PHG_PK PRIMARY KEY (MAPHG, DIADIEM)
);

CREATE TABLE DEAN (
    MADA NUMBER(3) CONSTRAINT DEAN_MADA_PK PRIMARY KEY,
    TENDA NVARCHAR2(50) NOT NULL,
    DDIEM_DA NVARCHAR2(50),
    PHONG NUMBER(2) CONSTRAINT DEAN_PHONGBAN_FK REFERENCES PHONGBAN(MAPHG)
);

CREATE TABLE PHANCONG (
    MA_NVIEN NUMBER(5) CONSTRAINT PHANCONG_NHANVIEN_FK REFERENCES NHANVIEN(MANV),
    MADA NUMBER(3) CONSTRAINT PHANCONG_DEAN_FK REFERENCES DEAN(MADA),
    THOIGIAN NUMBER(4,1),
    CONSTRAINT PHANCONG_PK PRIMARY KEY (MA_NVIEN, MADA)
);

CREATE TABLE THANNHAN (
    MA_NVIEN NUMBER(5) CONSTRAINT THANNHAN_NHANVIEN_FK REFERENCES NHANVIEN(MANV),
    TENTN NVARCHAR2(20),
    PHAI NVARCHAR2(5),
    NGSINH DATE,
    QUANHE NVARCHAR2(20),
    CONSTRAINT THANNHAN_PK PRIMARY KEY (MA_NVIEN, TENTN)
);

INSERT INTO PHONGBAN VALUES (1, 'Quản Lý Cấp Cao', NULL, TO_DATE('01/01/2020', 'DD/MM/YYYY'));
INSERT INTO PHONGBAN VALUES (4, 'Phát Triển Phần Mềm', NULL, TO_DATE('15/02/2021', 'DD/MM/YYYY'));
INSERT INTO PHONGBAN VALUES (5, 'Nghiên Cứu & Giải Pháp', NULL, TO_DATE('20/05/2020', 'DD/MM/YYYY'));

INSERT INTO NHANVIEN VALUES (888, 'Nguyễn', 'Văn', 'Tùng', TO_DATE('09/01/1980', 'DD/MM/YYYY'), 'Hà Nội', 'Nam', 55000, NULL, 1);
INSERT INTO NHANVIEN VALUES (111, 'Dương', 'Minh', 'Triết', TO_DATE('06/11/2005', 'DD/MM/YYYY'), 'TP Hồ Chí Minh', 'Nam', 45000, 888, 4);
INSERT INTO NHANVIEN VALUES (333, 'Lê', 'Quỳnh', 'Như', TO_DATE('01/02/2000', 'DD/MM/YYYY'), 'Đà Nẵng', 'Nữ', 35000, 888, 5);
INSERT INTO NHANVIEN VALUES (444, 'Phạm', '', 'Sinh', TO_DATE('15/01/2005', 'DD/MM/YYYY'), 'Cần Thơ', 'Nam', 25000, 111, 4);
INSERT INTO NHANVIEN VALUES (555, 'Trần', 'Thị', 'Lan', TO_DATE('20/10/2004', 'DD/MM/YYYY'), 'Đồng Nai', 'Nữ', 22000, 333, 5);

UPDATE PHONGBAN SET TRPHG = 888 WHERE MAPHG = 1;
UPDATE PHONGBAN SET TRPHG = 111 WHERE MAPHG = 4;
UPDATE PHONGBAN SET TRPHG = 333 WHERE MAPHG = 5;

INSERT INTO DIADIEM_PHG VALUES (1, 'Hà Nội');
INSERT INTO DIADIEM_PHG VALUES (4, 'TP Hồ Chí Minh');
INSERT INTO DIADIEM_PHG VALUES (4, 'Bình Dương');
INSERT INTO DIADIEM_PHG VALUES (5, 'Đà Nẵng');
INSERT INTO DIADIEM_PHG VALUES (5, 'Quảng Nam');

INSERT INTO DEAN VALUES (10, 'Hệ Thống ERP', 'TP Hồ Chí Minh', 4);
INSERT INTO DEAN VALUES (20, 'AI Phân Tích Dữ Liệu', 'Đà Nẵng', 5);
INSERT INTO DEAN VALUES (30, 'Số Hóa Doanh Nghiệp', 'Hà Nội', 1);
INSERT INTO DEAN VALUES (40, 'Ứng Dụng Di Động', 'Bình Dương', 4);
INSERT INTO DEAN VALUES (50, 'Bảo Mật Hệ Thống', 'Đà Nẵng', 5);

INSERT INTO PHANCONG VALUES (111, 10, 40.0);
INSERT INTO PHANCONG VALUES (111, 40, 10.5);
INSERT INTO PHANCONG VALUES (444, 10, 35.0);
INSERT INTO PHANCONG VALUES (555, 20, 25.0);
INSERT INTO PHANCONG VALUES (333, 50, 15.0);

INSERT INTO THANNHAN VALUES (111, 'Mai', 'Nữ', TO_DATE('10/05/2010', 'DD/MM/YYYY'), 'Em Gái');
INSERT INTO THANNHAN VALUES (444, 'Hùng', 'Nam', TO_DATE('15/08/1975', 'DD/MM/YYYY'), 'Cha');
INSERT INTO THANNHAN VALUES (333, 'Lan', 'Nữ', TO_DATE('20/12/1978', 'DD/MM/YYYY'), 'Mẹ');
INSERT INTO THANNHAN VALUES (555, 'Tú', 'Nam', TO_DATE('12/02/2008', 'DD/MM/YYYY'), 'Em Trai');
INSERT INTO THANNHAN VALUES (888, 'Hạnh', 'Nữ', TO_DATE('01/01/1985', 'DD/MM/YYYY'), 'Vợ');

COMMIT;

SPOOL OFF