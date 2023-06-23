use master
go

drop database MoMo_Cinema
go
-- Tạo database ShopOnline_Demo
create database MoMo_Cinema
go
use MoMo_Cinema
go
-- 1: Tạo Table [Accounts] chứa tài khoản thành viên được phép sử dụng các trang quản trị ----

create table TaiKhoan
(
	taiKhoan varchar(20) primary key not null,
	matKhau varchar(20) not null,
	hoDem nvarchar(50) null,
	tenTV nvarchar(30) not null,
	ngaysinh datetime ,
	gioiTinh bit default 1,
	soDT nvarchar(20),
	email nvarchar(50),
	diaChi nvarchar(250),
	trangThai bit default 0,
	ghiChu ntext
)
go

-- 2: Tạo Table [Customers] chứa Thông tin khách hàng  ---------------------------------------
create table KhachHang
(
	Cccd varchar(20) primary key not null,
	tenKH nvarchar(50) not null,
	soDT varchar(20) ,
	email nvarchar(50),	
	diaChi nvarchar(250),
	ngaySinh datetime ,
	gioiTinh bit default 1,
	ghiChu ntext
)
go

-- 3: Tạo Table [Articles] chứa thông tin về các bài viết phục vụ cho quảng bá sản phẩm, ------
--    xu hướng mua sắm hiện nay của người tiêu dùng , ...             ------------------------- 
create table Rapphim
(
	tenRap nvarchar(50) primary key not null,
	viTri nvarchar(20) not null,
	khuVuc nvarchar (20) not null,
	maPhim varchar(10) not null foreign key references Phim(maPhim),
)
go
-- 4: Tạo Table [LoaiSP] chứa thông tin loại sản phẩm, ngành hàng -----------------------------
create table LoaiPhim
(
	maLoai int primary key not null identity,
	tenLoai nvarchar(88) not null,
	ghiChu ntext default ''
)
go
-- 4: Tạo Table [Products] chứa thông tin của sản phẩm mà shop kinh doanh online --------------
create table Phim
(
	maPhim varchar(10) primary key not null,
	tenPhim nvarchar(500) not NULL,
	hinhDD varchar(max) DEFAULT '',
	ndTomTat nvarchar(2000) DEFAULT '',
	ngayDang DATETIME DEFAULT CURRENT_TIMESTAMP,
	maLoai int not null references LoaiPhim(maLoai),
	noiDung nvarchar(4000) DEFAULT '',
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade,
	giaBan INTEGER DEFAULT 0,
	nhaSanXuat nvarchar(168) default '',
	rapphim nvarchar(168)
)
go

-- 5: Tạo Table [Orders] chứa danh sách đơn hàng mà khách đã đặt mua thông qua web ------------
create table HD_DV
(
	soHDDV varchar(10) primary key not null ,
	Cccd varchar(20) not null foreign key references KhachHang(Cccd),
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade ,
	ngayDat datetime,
	daKichHoat bit default 1,
	ghiChu ntext,
	soluong int,
	tenDV nvarchar(50)
)
go	

create table HD_TT
(
	soHD varchar(10) primary key not null,
	soHDDV varchar(10) foreign key references HD_DV(soHDDV), 
	Cccd varchar(20) not null foreign key references KhachHang(Cccd),
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade ,
	ngayDat datetime,
	daKichHoat bit default 1,
	ghiChu ntext,
	soluong int,
	tenDV nvarchar(50)

)

create table CTHDTT	
(
	
	soHD varchar(10) not null foreign key references HDTT(soHD),
	maPhim varchar(10) not null foreign key references Phim(maPhim),
	maKm varchar(10) not null foreign key references Khuyenmai(maKm), 
	soLuong int,
	giaBan bigint,
	giamGia BIGINT,
	PRIMARY KEY (soHD, maPhim)
)
go

create table Comment
(
	maCmt varchar(10)  primary key not null,
	maSP varchar(10) not null foreign key references Phim(maPhim),
	tenKH nvarchar(50) not null,
	noidung nvarchar(30) not null
)
go

create table Khuyenmai(
	maKm varchar(10) primary key not null,
	tenKm varchar(10) not null,
	ngayhethan datetime,
	ngaybatdau datetime
)
go

create table Lienhe(
	Id int primary key not null,
	tenKH nvarchar(50),
	email varchar(50),
	ngayLh datetime,
	tieude varchar(50), 
	noidung nvarchar(300)
)
go

create table Matkhau(
	
	Id int primary key not null,
	Cccd varchar(20) not null foreign key references KhachHang(Cccd),
	email varchar(50),
	thoigiandat datetime,
	trangthai nvarchar(30)
)
go

create table Hanhdong(
	Id int primary key not null,
	taikhoan varchar(20) foreign key references Taikhoan(taikhoan),
	thoigianHD datetime,
	hanhdong nvarchar(20)
)


