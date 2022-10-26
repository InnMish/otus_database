CREATE database online_shop;
CREATE TABLE IF NOT EXISTS customer (
    customer_id       SERIAL PRIMARY KEY,
    first_name        VARCHAR(32) NOT NULL,
    last_name         VARCHAR(32),
    address           VARCHAR(64) NOT NULL,
    phone             VARCHAR(16) NOT NULL
);

CREATE TABLE IF NOT EXISTS provider (
    provider_id       SERIAL PRIMARY KEY,
    provider_name     VARCHAR(32) NOT NULL,
    address           VARCHAR(64)
);

CREATE TABLE if not exists producer (
    producer_id       SERIAL PRIMARY KEY,
    producer_name     VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS product (
    product_id        SERIAL PRIMARY KEY,
    product_name      VARCHAR(64) NOT NULL,
    description       VARCHAR(64) NOT NULL,
    price             VARCHAR(32) NOT NULL,
    quantity          INTEGER NOT NULL
);

USE online_shop;
