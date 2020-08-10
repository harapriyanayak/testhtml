CREATE TABLE IF NOT EXISTS data.CLINIC_USER(
	id serial NOT NULL PRIMARY KEY,
	username varchar(30) NOT NULL,
	password varchar(100) NOT NULL,
	role varchar(20) NOT NULL
) ;

CREATE TABLE IF NOT EXISTS data.ADDRESS(
	ADDRESS_ID serial NOT NULL PRIMARY KEY,
	ADDRESS1 varchar(200) NOT NULL,
	ADDRESS2 varchar(100) NULL,
	CITY varchar(30) NOT NULL,
	DISTRICT varchar(30) NOT NULL,
	STATE varchar(30) NOT NULL,
	PIN int NOT NULL
);

CREATE TABLE IF NOT EXISTS data.PATIENT(
	ID serial NOT NULL PRIMARY KEY,
	FIRSTNAME varchar(50) NOT NULL,
	LASTNAME varchar(50) NOT NULL,
	GENDER char(1) NOT NULL,
	AADHAR bigint NOT NULL,
	UHID varchar(30) NOT NULL,
	MOBILENO varchar(15) NULL,
	ADDRESS_ID bigint NOT NULL references data.ADDRESS(ADDRESS_ID)
);


CREATE TABLE IF NOT EXISTS data.PHYSICIAN(
	id serial NOT NULL PRIMARY KEY,
	firstname varchar(50) NOT NULL,
	lastname varchar(50) NOT NULL,
	MOBILENO varchar(15) NOT NULL,
	PHONENO varchar(15) NOT NULL,
	designation varchar(60) NOT NULL,
	REGISTRATIONNO varchar(20) NOT NULL
);
CREATE TABLE IF NOT EXISTS data.LICENSE(
	SERIAL_NO serial NOT NULL PRIMARY KEY,
	START_DATE varchar(150) NOT NULL,
	END_DATE varchar(150) NOT NULL,
	ENC_END_DATE varchar(150) NOT NULL,
	LVALUE varchar(150) NOT NULL,
	SEC_ADDR varchar(150) NOT NULL,
	TRIALMODE BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS data.STORE_INFO(
	SERIAL_NO serial NOT NULL PRIMARY KEY,
	STORE_NAME varchar(100) NOT NULL,
	ADDRESS_ID bigint NOT NULL references data.ADDRESS(ADDRESS_ID),
	DL_NO varchar(100),
	GSTN_UIN varchar(100) NOT NULL,
	PAN_NO varchar(20),
	MOBILENO varchar(15) NOT NULL,
	PHONENO varchar(15) NOT NULL,
	EMAIL varchar(30),
	STORE_TYPE varchar(20)
);

CREATE TABLE IF NOT EXISTS data.VENDOR_DETAILS(
	SERIAL_NO serial NOT NULL PRIMARY KEY,
	CATEGORY varchar(50),
	VENDOR_ID varchar(50),
	VENDOR_NAME varchar(100) NOT NULL,
	ADDRESS_ID bigint NOT NULL references data.ADDRESS(ADDRESS_ID),
	DL_NO varchar(100),
	GSTN varchar(50) NOT NULL,
	PAN_NO varchar(20),
	MOBILENO varchar(15) NOT NULL,
	PHONENO varchar(15) NOT NULL,
	EMAIL varchar(30),
	STORE_TYPE varchar(20)
);

CREATE TABLE IF NOT EXISTS data.STORE_OVERHEAD(
	SERIAL_NO serial NOT NULL PRIMARY KEY,
	CATEGORY varchar(50),
	DESCRIPTION varchar(100),
	EMPLOYEE_NAME varchar(50),
	FIXED_COST decimal(12,2),
	VARIABLE_COST decimal(12,2),
	TOTAL_COST decimal(18,2),
	SALES_TAX decimal(12,2)
);

CREATE TABLE IF NOT EXISTS data.DRUG_STOCK (
    SERIAL_NO serial NOT NULL PRIMARY KEY,
    GenericName varchar(100) not null,
    ProductBrand varchar(50) not null,
    Manufacturers varchar(50) not null,
    ScheduledCategory varchar(50),
    RxOTC varchar(5),
    DrugType varchar(10),
    Strength varchar(10),
    Volume int,
    HSNCode int,
    Category varchar(20),
    GSTinPercent decimal(4,2),
    MRP decimal(12,2) not null,
    Unit smallint,
    Unitprice decimal(12,2) not null,
    PurchasePrice decimal(12,2) check (PurchasePrice >= 0),
    SalePrice decimal(12,2) check (SalePrice >= 0),
    SalesTax decimal(12,2),
    BatchNo varchar(10) not null,
    MFGDate date not null,
    ExpiryDate date not null,
    BinNo varchar(10),
    AvailableStock int check(AvailableStock >= 0),
    SafetyStock int check(SafetyStock >= 0)   
);

CREATE TABLE IF NOT EXISTS data.SALES_INVOICE(
    SERIAL_NO serial NOT NULL PRIMARY KEY,
    INVOICE_NUMBER int NOT NULL unique,
    INVOICE_CATEGORY varchar(10),
    INVOICE_DATE_TIME timestamp,
    STORE_NO bigint NOT NULL references data.STORE_INFO(SERIAL_NO),
    VENDOR_NO bigint NOT NULL references data.VENDOR_DETAILS(SERIAL_NO),
    PATIENT_ID varchar(20),
    PRESCRIPTION_NO varchar(20),
    DOCTOR_NAME varchar(20), 
    DOCTOR_REG_NO varchar(20),
    PAYMENT_CATEGORY varchar(20),
    PAYMENT_MODE varchar(20),
    PAYMENT_STATUS varchar(20),
    PAYMENT_MADE decimal(12,2),
    PAYMENT_BALANCE decimal(12,2),
    DISEASE_SPECIALITY varchar(20),
    GROSS_TOTAL_SALE decimal(18,2),
    GROSS_TOTAL_CGST decimal(12,2),
    GROSS_TOTAL_SGST decimal(12,2),
    GROSS_ITEM_TOTAL decimal(12,2),
    DISCOUNT_IN_PERCENT decimal(4,2),
    TOTAL_DISCOUNT decimal(12,2),
    NET_TOTAL decimal(18,2)
);

CREATE TABLE IF NOT EXISTS data.SALES_INVOICE_ITEM(
	SERIAL_NO serial NOT NULL PRIMARY KEY,
	INVOICE_NUMBER int NOT NULL references data.SALES_INVOICE(INVOICE_NUMBER),
    	GenericName varchar(100) not null,
    	ProductBrand varchar(50) not null,
    	Manufacturers varchar(50) not null,
    	RxOTC varchar(5),
    	Strength varchar(10),
	HSNCode int,
	BatchNo varchar(10) not null,
	MFGDate date not null,
    	ExpiryDate date not null,
    	Unitprice decimal(12,2) not null,
	MRP decimal(12,2) not null,
	Quantity int check(Quantity >= 0),
    	ReturnQuantity int check(ReturnQuantity >= 0),
    	CGSTinPercent decimal(4,2),
	CGST decimal(12,2),
	SGSTinPercent decimal(4,2),
	SGST decimal(12,2),
    	Total decimal(18,2)
);


INSERT INTO data.CLINIC_USER
           (username
           ,password
           ,role)
     VALUES
           ('arosestarAdmin'
           ,'$2a$10$t0odJ6BeVL5H51Ol95Qjve4NVE8ixEa.zhw8dIgjImRkhx5mk9cgS',
           'ADMIN');


--Tables for PO Screen
CREATE TABLE IF NOT EXISTS data.purchase_orders
(
    serial_no integer NOT NULL ,
    category character varying(100)   NOT NULL,
    vendor_serial_no integer,
    po_date timestamp without time zone,
    po_status character varying(100)   NOT NULL,
    po_invoice_date timestamp without time zone,
    paid_amount integer,
    balance_amount integer,
    payment_status character varying(100)   NOT NULL,
    total_po_price integer,
    total_po_gst integer,
    created_by character varying(64)  ,
    creation_date timestamp without time zone,
    po_item_status character varying(100)  ,
    po_grn_status character varying(100)  ,
    total_invoice_price integer,
    payment_mode character varying(100)  ,
    CONSTRAINT purchase_orders_pkey PRIMARY KEY (serial_no)
);

CREATE TABLE IF NOT EXISTS data.purchase_order_items
(
    serial_no integer NOT NULL,
    po_serial_no integer NOT NULL,
    generic_name character varying(100)  NOT NULL,
    product_brand character varying(100)  NOT NULL,
    manufacturer character varying(100)  NOT NULL,
    strength character varying(50),
    quantity bigint,
     unit_mrp double precision,
    item_total_price double precision,
    creation_date date,
    created_by character varying(50) NOT NULL,
    CONSTRAINT purchase_order_items_pkey PRIMARY KEY (serial_no)
);

CREATE TABLE IF NOT EXISTS DATA.PURCHASE_ORDER_GRN_DETAILS(
SERIAL_NO            SERIAL NOT NULL PRIMARY KEY,
PO_SERIAL_NO         INT NOT NULL,
PO_INVOICE_NO        VARCHAR(100),
PRODUCT_BRAND        VARCHAR(50),
STRENGTH             VARCHAR(10),
BATCH                VARCHAR(100),
RECEIVED_QUANTITY    INT,
REMAINING_QUANTITY   INT,
INVOICE_PRICE        INT,
PO_GST               INT,
AMOUNT_PAID          INT,
BALANCE_AMOUNT       INT,
CREATED_BY           VARCHAR(64),
CREATION_DATE        TIMESTAMP
);

CREATE TABLE IF NOT EXISTS data.drug_master
(
    serial_no integer NOT NULL ,
    genericname character varying(100)  NOT NULL,
    productbrand character varying(50)  NOT NULL,
    manufacturers character varying(50)  NOT NULL,
    scheduledcategory character varying(50) ,
    rxotc character varying(5) ,
    drugtype character varying(50) ,
    strength character varying(100) ,
    volume character varying(50) ,
    hsncode integer,
    category character varying(20) ,
    gstinpercent numeric(4,2),
    mrp numeric(12,2) NOT NULL,
    CONSTRAINT drug_master_pkey PRIMARY KEY (serial_no),
    CONSTRAINT chk_rxotc CHECK (rxotc::text = 'RX'::text OR rxotc::text = 'OTC'::text)
);