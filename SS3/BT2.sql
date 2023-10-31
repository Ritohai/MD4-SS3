DROP DATABASE IF exists banhang;
CREATE DATABASE banhang;
use banhang;

CREATE TABLE Customer(
cId int primary key auto_increment,
cName varchar(25) not null,
cAge tinyint
);

CREATE TABLE orders(
oId int primary key auto_increment,
cId int not null,
oDate datetime not null,
oTotalPrice int 
);

CREATE TABLE product(
pId int primary key auto_increment,
pName varchar(25) not null,
pPrice int not null
);

CREATE TABLE orderDetail(
oId int not null,
pId int not null,
odQty int
);

alter table orders add constraint pk_order_customer foreign key (cId) references Customer(cId);
alter table orderDetail add constraint pk_orderDetail_order foreign key (oId) references orders(oId);
alter table orderDetail add constraint pk_orderDetail_product foreign key (pId) references product(pId);

 insert into customer(cName, cAge) value ('Minh Quan', 10), ('Ngoc Oanh', 20), ('Hong Ha', 50);
 insert into orders(cId, oDate, oTotalPrice) value (1, '2006-03-21',null), (2, '2006-03-23',null), (1, '2006-03-16',null);
 insert into product(pName, pPrice) value ('May Giat', 3), ('Tu lanh', 5), ('Dieu Hoa', 7), ('Quat', 1), ('Bep dien', 2);
 insert into orderDetail(oId, pId, odQty) value (1, 1, 3), (1, 3, 7), (1, 4, 2), (2, 1, 1), (3, 1, 8), (2, 5, 4), (2, 3, 3);
 
-- Hiển thị các thông tin gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select od.oId as 'Ma hoa don', p.pName as 'Ngay ban', (p.pPrice*od.odQty) as "Gia tien" 
from orderDetail od
join product p on p.pId = od.pId;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select c.cId, c.cName, c.cAge, GROUP_CONCAT(p.pName SEPARATOR ', ') as 'San pham da mua' from customer c
join orders o on o.cId = c.cId
join orderDetail od on od.oId	= o.oId
join product p on p.pId = od.pId
group by  c.cId, c.cName, c.cAge;

--  Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT c.cId, c.cName, c.cAge
FROM Customer c
LEFT JOIN orders o ON o.cId = c.cId
WHERE o.cId IS NULL;

--  Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng 
-- loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
select orders.oId as 'Ma hoa don', orders.oDate as 'Ngay ban', sum(product.pPrice * orderDetail.odQty) as "Gia tien" 
from orders
join orderDetail on orderDetail.oId	= orders.oId
join product on product.pId = orderDetail.pId
group by orders.oId, orders.oDate;






