CREATE TABLE IF NOT EXISTS customer (
    customer_id       BINARY(16) PRIMARY KEY,
    first_name        VARCHAR(32) NOT NULL,
    last_name         VARCHAR(32),
    address           VARCHAR(64) NOT NULL,
    phone             VARCHAR(16) NOT NULL,
);

CREATE TABLE IF NOT EXISTS provider (
    provider_id       BINARY(16) PRIMARY KEY,  --uuid to bin (uuid())
    provider_name     VARCHAR(32) NOT NULL,
    details           JSON,
    address           VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS delivery (
    delivery_id       BINARY(16) PRIMARY KEY,
    delivery_date     DATETIME NOT NULL
);