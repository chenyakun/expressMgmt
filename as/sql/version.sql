ALTER TABLE "current_packages";
ALTER TABLE "serviceSites";
ALTER TABLE "provinces";
ALTER TABLE "couriers(快递员)";
ALTER TABLE "administrators";
ALTER TABLE "history_packages";
ALTER TABLE "city";
ALTER TABLE "county";

DROP TABLE "news_info";
DROP TABLE "current_packages";
DROP TABLE "serviceSites";
DROP TABLE "provinces";
DROP TABLE "couriers(快递员)";
DROP TABLE "administrators";
DROP TABLE "history_packages";
DROP TABLE "city";
DROP TABLE "county";

CREATE TABLE "news_info" (
);

CREATE TABLE "current_packages" (
"guid" CLOB NOT NULL,
"packageid" DECIMAL(11) NULL,
"fromAddress" VARCHAR(255) NULL,
"fromTel" VARCHAR(255) NULL,
"fromDate" DATE NULL,
"toAddress" VARCHAR(255) NULL,
"toTel" VARCHAR(255) NULL,
"toCustomerMail" VARCHAR(255) NULL,
"fromCustomerInfo" CLOB NULL,
"toCustomerInfo" CLOB NULL,
"packageType" DECIMAL(11) NULL,
"packageTransInfo" CLOB NULL,
"packageVolume" VARCHAR(255) NULL,
"packageWeight" DECIMAL(2147483647,2147483647) NULL,
"packageStatus" VARCHAR(255) NULL,
"fromSite" VARCHAR(255) NULL,
PRIMARY KEY ("guid") 
);

CREATE TABLE "serviceSites" (
"siteId" CLOB NOT NULL,
"storename" VARCHAR(255) NULL,
"storeTel" VARCHAR(255) NULL,
"storeWebUrl" VARCHAR(255) NULL,
"storeBoss" VARCHAR(255) NULL,
"storeAddress" VARCHAR(255) NULL,
"storeOpenDate" DATE NULL,
"storeAddtionInfo" CLOB NULL,
"storePosition" VARCHAR(255) NULL,
PRIMARY KEY ("siteId") 
);

CREATE TABLE "provinces" (
"provinceId" DECIMAL(11) NULL,
"stateId" DECIMAL(11) NULL,
"name" VARCHAR(255) NULL,
PRIMARY KEY ("provinceId") 
);

CREATE TABLE "couriers(快递员)" (
"guid" DECIMAL(11) NOT NULL,
"courierId" CLOB NULL,
"courierName" VARCHAR(255) NULL,
"courierPosition" VARCHAR(255) NULL,
"courierCompany" VARCHAR(255) NULL,
"gender" DECIMAL(11) NULL,
"age" VARCHAR(255) NULL,
"joinDate" DATE NULL,
"telPhone" VARCHAR(255) NULL,
"county" VARCHAR(255) NULL,
"community" VARCHAR(255) NULL,
"siteId" INTEGER NULL,
PRIMARY KEY ("courierId") 
);

CREATE TABLE "administrators" (
"guid" DECIMAL(11) NULL,
"staffid" DECIMAL(11) NULL,
"staffname" VARCHAR(255) NULL,
"position" VARCHAR(255) NULL,
"additioninfo" CLOB NULL,
PRIMARY KEY ("guid") 
);

CREATE TABLE "history_packages" (
"guid" CLOB NOT NULL,
"packageid" DECIMAL(11) NULL,
"fromAddress" VARCHAR(255) NULL,
"fromTel" VARCHAR(255) NULL,
"fromDate" DATE NULL,
"toAddress" VARCHAR(255) NULL,
"toTel" VARCHAR(255) NULL,
"fromCustomerInfo" CLOB NULL,
"toCustomerInfo" CLOB NULL,
"packageType" DECIMAL(11) NULL,
"packageTransInfo" CLOB NULL,
"packageVolume" VARCHAR(255) NULL,
"packageWeight" DECIMAL(2147483647,2147483647) NULL,
"packageStatus" VARCHAR(255) NULL,
"endDate" DATE NULL,
"receiveCustomer" VARCHAR(255) NULL,
"status" DECIMAL(11) NULL,
"finalStoreId" DECIMAL(11) NULL,
"toCustomerMail" VARCHAR(255) NULL,
"fromStoreID" VARCHAR(255) NULL,
"fromCourierID" VARCHAR(255) NULL,
"endCourierID" INTEGER NULL,
PRIMARY KEY ("guid") 
);

CREATE TABLE "city" (
"cityId" DECIMAL(11) NOT NULL,
"stateId" DECIMAL(11) NULL,
"name" VARCHAR(255) NULL,
"provinceId" DECIMAL(11) NULL,
PRIMARY KEY ("cityId") 
);

CREATE TABLE "county" (
"id" DECIMAL(11) NOT NULL,
"countyName" VARCHAR(255) NULL,
"cityId" DECIMAL(11) NULL,
PRIMARY KEY ("id") 
);


ALTER TABLE "provinces" ADD CONSTRAINT "fk_provinces_city_1" FOREIGN KEY ("provinceId") REFERENCES "city" ("provinceId");
ALTER TABLE "city" ADD CONSTRAINT "fk_city_county_1" FOREIGN KEY ("cityId") REFERENCES "county" ("cityId");
ALTER TABLE "county" ADD CONSTRAINT "fk_county_serviceSites_1" FOREIGN KEY ("id") REFERENCES "serviceSites" ("storePosition");
ALTER TABLE "serviceSites" ADD CONSTRAINT "fk_serviceSites_couriers(快递员)_1" FOREIGN KEY ("siteId") REFERENCES "couriers(快递员)" ("siteId");
ALTER TABLE "serviceSites" ADD CONSTRAINT "fk_serviceSites_current_packages_1" FOREIGN KEY ("siteId") REFERENCES "current_packages" ("fromSite");
ALTER TABLE "serviceSites" ADD CONSTRAINT "fk_serviceSites_history_packages_1" FOREIGN KEY ("siteId") REFERENCES "history_packages" ("fromStoreID");
ALTER TABLE "serviceSites" ADD CONSTRAINT "fk_serviceSites_history_packages_2" FOREIGN KEY ("siteId") REFERENCES "history_packages" ("finalStoreId");
ALTER TABLE "couriers(快递员)" ADD CONSTRAINT "fk_couriers(快递员)_history_packages_1" FOREIGN KEY ("courierId") REFERENCES "history_packages" ("fromCourierID");
ALTER TABLE "couriers(快递员)" ADD CONSTRAINT "fk_couriers(快递员)_history_packages_2" FOREIGN KEY ("courierId") REFERENCES "history_packages" ("endCourierID");

