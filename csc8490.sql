CREATE TABLE MYADMIN(
adminID char(6) CONSTRAINT myadmin_pk PRIMARY KEY,
adminFN varchar2(20) CONSTRAINT myadmin_nn_adminFN NOT NULL,
adminLN varchar2(20),
adminPh char(10)
)
/*drop table myadmin;*/
select * From mycategory;
CREATE TABLE MYLOCATION(
locationName varchar2(20) CONSTRAINT mylocation_pk PRIMARY KEY,
zipCode char(5),
adminID char(6)CONSTRAINT mylocation_nn_adminID NOT NULL
CONSTRAINT mylocation_fk_admin REFERENCES MYADMIN(adminID) ON DELETE CASCADE
)

CREATE TABLE MYUSER(
userID char(6) CONSTRAINT myuser_pk PRIMARY KEY,
userFN varchar2(20),
userLN varchar2(20),
userPh char(10),
aptNo varchar(10) CONSTRAINT myuser_uq_aptNo UNIQUE,
locationName varchar2(20) CONSTRAINT myuser_nn_locationName NOT NULL
CONSTRAINT myuser_fk_mylocation REFERENCES MYLOCATION(locationName) ON DELETE CASCADE
)

CREATE TABLE MYWISHLIST(
wishlistID char(6) CONSTRAINT mywishlist_pk PRIMARY KEY,
userID char(6) CONSTRAINT mywishlist_nn_userID NOT NULL
CONSTRAINT mywishlist_fk_myuser REFERENCES MYUSER(userID)ON DELETE CASCADE
)

CREATE TABLE myAd(
adID char(6) CONSTRAINT myAd_pk PRIMARY KEY,
adDescription varchar2(300),
adDateposted date,
adStatus varchar2(20),
contactDetails varchar2(100), /* either email or phonenumber*/
userID char(6) CONSTRAINT myAd_nn_userID NOT NULL
CONSTRAINT myAd_fk_myuser REFERENCES MYUSER(userID),
productID char(6) CONSTRAINT myAd_nn_productID NOT NULL 
CONSTRAINT myAd_fk_myproduct REFERENCES MYPRODUCT(productID)ON DELETE CASCADE
)

CREATE TABLE myproduct(
productID char(6) CONSTRAINT myproduct_pk PRIMARY KEY,
productName varchar2(100),
usedTime char(10),
orginalPrice number(6,2),
sellingPrice number(6,2),
categoryID CONSTRAINT myproduct_nn_categoryID NOT NULL
CONSTRAINT myproduct_fk_categoryID REFERENCES mycategory(categoryID)ON DELETE CASCADE
)

CREATE TABLE MYORDER(
orderID char(6)CONSTRAINT myorder_pk PRIMARY KEY,
orderDate date,
quantity number(3),
status varchar2(20),
userID char(6) CONSTRAINT myorder_nn_uerID REFERENCES myuser(userID) ON DELETE CASCADE,
productID char(6)CONSTRAINT ad_nn_productID NOT NULL 
CONSTRAINT myorder_fk_myproduct REFERENCES MYPRODUCT(productID)ON DELETE CASCADE
)

CREATE TABLE wishlistDetails(
wishlistID char(6)
CONSTRAINT wishlistdetails_fk_wishlist REFERENCES mywishlist(wishlistID) ON DELETE CASCADE,
adID char(6) CONSTRAINT wishlistdetails_fk_ad REFERENCES myad(adID) ON DELETE CASCADE,
CONSTRAINT wishlistDetails_pk PRIMARY KEY(wishlistId,adID)

)

CREATE TABLE mycategory(
categoryID char(6) constraint mycategory_pk PRIMARY KEY,
categoryName varchar2(20) constraint mycategory_nn_categoryname NOT NULL
)

INSERT INTO MYADMIN
VALUES('AD0001','steve','smith','6104852173');
INSERT INTO MYADMIN
VALUES('AD0002','Robin','Walter','4847903474');
INSERT INTO MYADMIN
VALUES('AD0003','Jessica','Bing','9135904598');


ALTER TABLE MYADMIN
ADD CONSTRAINT myadmin_uq_adminPh UNIQUE (adminPh);

/*Admin might want to update their phone number*/
update myadmin 
set adminPh='6105362255'
where adminID='AD0002';

/*cannot delete admin as there is exactly one admin at a time for one location*/
-------------------------------------------------------------------------------------

INSERT INTO MYLOCATION
VALUES('StoneGateAtDevon','19333','AD0001');
INSERT INTO MYLOCATION
VALUES('LaMaison','19087','AD0002');
INSERT INTO MYLOCATION
VALUES('DevonPark','19333','AD0003');

/* every location has a unique adminone admin cannot supervise two locations*/
ALTER TABLE MYLOCATION
ADD CONSTRAINT mylocation_uq_adminID UNIQUE (adminID);


/*Admin might want to update the name of the apartments*/
UPDATE MYLOCATION
SET locationName ='DevonParkApartments'
WHERE locationName = 'DevonPark';
-------------------------------------------------------------------

INSERT INTO MYUSER
VALUES('UR0001','Isabel','Stuart','4379934453','C95','StoneGateAtDevon');
INSERT INTO MYUSER
VALUES('UR0002','Ronny','Kapoor','9248623451','K193','LaMaison');
INSERT INTO MYUSER
VALUES('UR0003','Shweta','Tiwari','6103847392','F144','StoneGateAtDevon');
INSERT INTO MYUSER
VALUES('UR0004','Rob','Martin','4847756910','561B','DevonParkApartments');
INSERT INTO MYUSER
VALUES('UR0005','Stacy','Chu','9140233654','A70','StoneGateAtDevon');
INSERT INTO MYUSER
VALUES('UR0006','Owen','Hunt','8257249077','444E','DevonParkApartments');
INSERT INTO MYUSER
VALUES('UR0007','Derek','Sheperd','4843445766','F196','StoneGateAtDevon');
INSERT INTO MYUSER
VALUES('UR0008','Meredith','Grey','4346673322','F194','StoneGateAtDevon');
INSERT INTO MYUSER
VALUES('UR0009','Christina','Yang','2125576081','F194','StoneGateAtDevon');
INSERT INTO MYUSER
VALUES('UR0010','George','Omalley','6061227764','B128','LaMaison');
INSERT INTO MYUSER
VALUES('UR0011','Mark','Sloan','4327598091','D312','LaMaison');
INSERT INTO MYUSER
VALUES('UR0012','Adison','Montgomery','814371993
3','G408','LaMaison');
INSERT INTO MYUSER
VALUES('UR0013','Jackson','Avery','5708832190','221A','DevonParkApartments');
INSERT INTO MYUSER
VALUES('UR0014','April','Kepner','2673245678','194H','DevonParkApartments');

alter table myuser
drop constraint myuser_uq_aptno;

select * from myuser;

drop table myuser;
/*A user might change his apartment to a different community among the available communities
then, both his apartment no and location name will change*/
update myuser
set aptNo= 'L373',
    locationName = 'LaMaison'
where userFN = 'Shweta'
and userLN='Tiwari';

/* A user might be deleted if he no longer wants to be a part of the application*/
delete from myuser
where userID = 'UR0005';
-----------------------------------------------------------------------------------------
INSERT INTO MYWISHLIST
VALUES('WL0001','UR0001');
INSERT INTO MYWISHLIST
VALUES('WL0002','UR0002');
INSERT INTO MYWISHLIST
VALUES('WL0003','UR0003');
INSERT INTO MYWISHLIST
VALUES('WL0004','UR0004');
INSERT INTO MYWISHLIST
VALUES('WL0005','UR0005');
INSERT INTO MYWISHLIST
VALUES('WL0006','UR0006');
INSERT INTO MYWISHLIST
VALUES('WL0007','UR0007');
INSERT INTO MYWISHLIST
VALUES('WL0008','UR0008');
INSERT INTO MYWISHLIST
VALUES('WL0009','UR0009');
INSERT INTO MYWISHLIST
VALUES('WL0010','UR0010');
INSERT INTO MYWISHLIST
VALUES('WL0011','UR0011');
INSERT INTO MYWISHLIST
VALUES('WL0012','UR0012');
INSERT INTO MYWISHLIST
VALUES('WL0013','UR0013');
INSERT INTO MYWISHLIST
VALUES('WL0014','UR0014');
select * from mywishlist;



/* If a user is deleted from the system then according to 'on delete cascade' 
the corresponding row in mywishlist table is also deleted*/

DELETE FROM MYUSER 
WHERE USERID = 'UR0001';

select * from mywishlist;

INSERT INTO MYCATEGORY
VALUES ('CA0001', 'ELECTRONICS');
INSERT INTO MYCATEGORY
VALUES ('CA0002', 'BOOKS');
INSERT INTO MYCATEGORY
VALUES ('CA0003', 'FURNITURE');
INSERT INTO MYCATEGORY
VALUES ('CA0004', 'KITCHEN');
INSERT INTO MYCATEGORY
VALUES ('CA0005', 'CLOTHING');
INSERT INTO MYCATEGORY
VALUES ('CA0006', 'AUTO-MOBILE');
INSERT INTO MYCATEGORY
VALUES ('CA0007', 'KIDS');
INSERT INTO MYCATEGORY
VALUES ('CA0008', 'STATIONARY');
INSERT INTO MYCATEGORY
VALUES ('CA0009', 'GARDEN');
INSERT INTO MYCATEGORY
VALUES ('CA0010', 'INSTRUMENTS');
INSERT INTO MYCATEGORY
VALUES ('CA0011', 'JEWELLERY');
INSERT INTO MYCATEGORY
VALUES ('CA0012', 'MISCALLANEOUS');
INSERT INTO MYCATEGORY
VALUES ('CA0013', 'FOOD');

/* admin might want to change the category name*/
UPDATE MYCATEGORY
SET categoryName ='MUSICAL INSTRUMENTS'
WHERE categoryname = 'INSTRUMENTS';

/* categoryname cannot be repeated*/
alter table mycategory
add constraint mycategory_uq_categoryname unique(categoryName);

/* admin might want to delete a category */

DELETE FROM mycategory
WHERE categoryname = 'FOOD';
-------------------------------------------------------------------------------------
alter table myproduct
    add productQuantity number(3) default 1;


select * from myproduct;
INSERT INTO MYPRODUCT (productID, productName, usedTime, originalPrice, sellingPrice , categoryID,productQuantity)
VALUES ('PR0001', 'Study Table','1 year',60,20,'CA0003',1);
INSERT INTO MYPRODUCT(productID, productName,usedTime, originalPrice, sellingPrice , categoryID,productQuantity)
VALUES ('PR0002', 'Kohls Blender','2 MONTHS',25,10,'CA0004',1);
INSERT INTO MYPRODUCT(productID, productName, usedTime, originalPrice, sellingPrice , categoryID,productQuantity)
VALUES ('PR0003', 'Office chair','8 months',80,50,'CA0003',1);
INSERT INTO MYPRODUCT(productID, productName, usedTime, originalPrice, sellingPrice , categoryID,productQuantity)
VALUES ('PR0004', 'Patio chairs','6 months',50,20,'CA0003',2);
INSERT INTO MYPRODUCT(productID, productName, usedTime, originalPrice, sellingPrice , categoryID,productQuantity)
VALUES ('PR0005', 'Roku smart LED HD TV','10 months',80,40,'CA0001',1);
INSERT INTO MYPRODUCT(productID, productName, usedTime, originalPrice, sellingPrice , categoryID,productQuantity)
VALUES ('PR0006', 'Queen size bed frame','1.5 years',220,150,'CA0003',1);





------------------------------------------------------------------------------------
/*Adding not null constraint as the adDatePosted cannot be null and need to be 
displayed to the users*/
ALTER TABLE myAd
MODIFY( adDatePosted constraint myad_nn_adDatePosted NOT NULL);


INSERT INTO myad(adId, adDescription,adDatePosted,adStatus, contactDetails, userID, productID)
VALUES ('AD0001','Wooden study table', '12-SEP-20','active','email me at xyz@gmail.com or contact at 9248623451','UR0002','PR0001');
INSERT INTO myad(adId, adDescription,adDatePosted,adStatus, contactDetails, userID, productID)
VALUES ('AD0002','Kohls blender new excellent condition','12-SEP-20','active','email me at insertrandomid@gmail.com or contact at 6103847392','UR0003','PR0002');
INSERT INTO myad(adId, adDescription,adDatePosted,adStatus, contactDetails, userID, productID)
VALUES ('AD0003','Office chair with adjustable seat reach out to me for more info', '29-SEP-20','active','contact at 4847756910','UR0004','PR0003');
INSERT INTO myad(adId, adDescription,adDatePosted,adStatus, contactDetails, userID, productID)
VALUES ('AD0004','Two patio chairs', '01-OCT-20','active','contact at 8257249077','UR0006','PR0004');
INSERT INTO myad(adId, adDescription,adDatePosted,adStatus, contactDetails, userID, productID)
VALUES ('AD0005','Roku smart tv available for sale 40 inches', '03-OCT-20','active','email me at noideawhat23@gmail.com or contact at 4843445766','UR0007','PR0005');
INSERT INTO myad(adId, adDescription,adDatePosted,adStatus, contactDetails, userID, productID)
VALUES ('AD0006','Queen size bed frame excellent condition', '09-OCT-20','active','email at random235@gmail.com or contact at 4346673322','UR0008','PR0006');


UPDATE myad
SET 
    adDescription = 'sturdy wooden study table'
WHERE
    adId ='AD0001';

    
------------------------------------------------------------------------------------
INSERT INTO MYORDER(orderId, orderDate, quantity, status, userId, productId)
VALUES('OR0001', '13-SEP-20',1, 'completed','UR0002','PR0001');

INSERT INTO MYORDER(orderId, orderDate, quantity, status, userId, productId)
VALUES('OR0002', '15-SEP-20',1, 'completed','UR0003','PR0002');

INSERT INTO MYORDER(orderId, orderDate, quantity, status, userId, productId)
VALUES('OR0003', '14-OCT-20',1, 'completed','UR0004','PR0005');

INSERT INTO MYORDER(orderId, orderDate, quantity, status, userId, productId)
VALUES('OR0004', '25-NOV-20',1, 'pending','UR0004','PR0006');

UPDATE 
    MYORDER
SET
    STATUS ='completed'
WHERE
    PRODUCTID = 'PR0006';
    
    
ALTER TABLE myOrder MODIFY ( quantity NOT NULL);
-------------------------------------------------------------------------------------

INSERT INTO wishlistDetails(wishlistID,adId)
VALUES('WL0002','AD0001');

INSERT INTO wishlistDetails(wishlistID,adId)
VALUES('WL0002','AD0003');

INSERT INTO wishlistDetails(wishlistID,adId)
VALUES('WL0003','AD0005');

INSERT INTO wishlistDetails(wishlistID,adId)
VALUES('WL0003','AD0002');
INSERT INTO wishlistDetails(wishlistID,adId)
VALUES('WL0004','AD0004');

INSERT INTO wishlistDetails(wishlistID,adId)
VALUES('WL0011','AD0004');

/* A user might want to remove an ad from wishlist*/
DELETE FROM WISHLISTDETAILS 
WHERE adID= 'AD0002' AND wishlistID ='WL0003';

/*only adding and deleting in a wishlist*/
---------------------------------------------------------------------------------------
/*VIew Order details for each user*/
CREATE OR REPLACE VIEW order_details AS
SELECT a.orderId, a.orderDate,b.productName, a.quantity, ( a.quantity*b.sellingPrice) as totalAmount,
a.status, a.userID, a.productId
from myorder a
LEFT JOIN myproduct b on a.productID=b.productID;

select * from order_details;


-----------------------------------------------------------------------------


/* Get all active ad on the portal*/
CREATE OR REPLACE VIEW Active_Ads AS
SELECT adId, adDescription,adDatePosted, adStatus
FROM MYAD
WHERE adStatus= 'active'
ORDER BY (adDatePosted);

select * from active_Ads;
-----------------------------------------------------------------------------
/*avg item value for all the products in each category uploaded on the portal
and sort it by category name alphabeticaly*/

CREATE OR REPLACE VIEW Average_SellingPrice_PerCategory AS
SELECT
    a.categoryID,
    a.categoryName,
    avgSpPerCategory.avgSp as avgPerCat
FROM mycategory a,
    (SELECT categoryId, avg(sellingPrice) as avgSp
    FROM myproduct group by categoryid 
    )avgSpPerCategory
WHERE
a.categoryID = avgSpPerCategory.categoryID;
select * from Average_SellingPrice_PerCategory;
-----------------------------------------------------------------------
/*view all users per  location*/

CREATE OR REPLACE VIEW users_per_location AS
SELECT  
u.locationName,
u.userID
from myuser u
left join mylocation l on
u.locationName =l.locationName
order by u.locationName;

select * from users_per_location;

/* See all sellers from all locations.
Business Value: This report helps the business in viewing 
users who have been sellers atleast once in NearMe
*/

select u.userID as seller, u.locationName, a.addescription
from myuser u
right join myad a on u.userId=a.userID;


------------------------------------------------------------------------
/*get all wishlisted ads*/
SELECT DISTINCT adId, wishlistID
from wishListDetails;










----------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE show_active_ads_with_category
( c1 OUT SYS_REFCURSOR)
AS 
BEGIN
    open c1 for
	select a.adID, a.adDescription, ad_cat.categoryname,a.productID
    from myAd a,(select p.productID,p.categoryID, c.categoryname from myproduct p
    left join mycategory c on p.categoryID=c.categoryid
    ) ad_cat
    where a.productID = ad_cat.productID;
    DBMS_SQL.RETURN_RESULT(c1);
    
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END show_active_ads_with_category;
EXEC show_active_ads_with_category(c1);


variable c1 refcursor;
exec show_active_ads_with_category( :c1 );
print c1;
--------------------------------------------------------------------------------

CREATE or REPLACE PROCEDURE add_new_category(
p_category_id char,
p_category_name varchar2
) AS

BEGIN

INSERT INTO mycategory (categoryID, categoryName)
VALUES(p_category_id, p_category_name);
COMMIT;
EXCEPTION
WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END add_new_category;
EXECUTE ADD_NEW_CATEGORY('CA0013','ART');





