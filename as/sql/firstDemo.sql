ALTER TABLE "serviceSites";
ALTER TABLE "couriers";

DROP TABLE "news_info";
DROP TABLE "packages";
DROP TABLE "serviceSites";
DROP TABLE "locations";
DROP TABLE "couriers";

CREATE TABLE "news_info" (
);

CREATE TABLE "packages" (
);

CREATE TABLE "serviceSites" (
"siteId" VARCHAR NOT NULL,
PRIMARY KEY ("siteId") 
);

CREATE TABLE "locations" (
);

CREATE TABLE "couriers" (
"courierId" VARCHAR NULL,
PRIMARY KEY ("courierId") 
);


ALTER TABLE "serviceSites" ADD CONSTRAINT "fk_serviceSites_couriers_1" FOREIGN KEY ("siteId") REFERENCES "couriers" ("courierId");

