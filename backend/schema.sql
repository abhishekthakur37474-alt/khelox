  CREATE TABLE IF NOT EXISTS users (
    id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100)  NOT NULL,
    email         VARCHAR(190)  NOT NULL,
    phone         VARCHAR(20)   NOT NULL,
    password_hash VARCHAR(255)  NOT NULL,
    fcoin         DECIMAL(12,2) NOT NULL DEFAULT 0,
    dcoin         DECIMAL(12,2) NOT NULL DEFAULT 0,
    wcoin         DECIMAL(12,2) NOT NULL DEFAULT 0,
    created_at    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_email (email),
    UNIQUE KEY uq_phone (phone)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;