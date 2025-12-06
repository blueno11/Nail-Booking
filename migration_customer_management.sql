-- SQL Migration Script for Customer Management Feature
-- Date: 2025-12-05
-- Description: Adds new columns and indexes to customer table

-- Check if columns exist before adding (for safety)
ALTER TABLE customer 
ADD COLUMN IF NOT EXISTS address VARCHAR(255),
ADD COLUMN IF NOT EXISTS date_of_birth DATE,
ADD COLUMN IF NOT EXISTS created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN IF NOT EXISTS last_visit_date TIMESTAMP,
ADD COLUMN IF NOT EXISTS total_spent DOUBLE DEFAULT 0,
ADD COLUMN IF NOT EXISTS notes LONGTEXT,
ADD COLUMN IF NOT EXISTS status VARCHAR(20) DEFAULT 'ACTIVE';

-- Add indexes for better search performance
ALTER TABLE customer 
ADD INDEX IF NOT EXISTS idx_phone_number (phone_number),
ADD INDEX IF NOT EXISTS idx_email (email),
ADD INDEX IF NOT EXISTS idx_status (status),
ADD INDEX IF NOT EXISTS idx_created_date (created_date);

-- Update existing records to have default created_date if null
UPDATE customer SET created_date = NOW() WHERE created_date IS NULL;

-- Set default status for existing customers
UPDATE customer SET status = 'ACTIVE' WHERE status IS NULL;

-- Set default total_spent for existing customers
UPDATE customer SET total_spent = 0 WHERE total_spent IS NULL;

-- Verify the changes
SELECT 
    id,
    full_name,
    phone_number,
    email,
    address,
    date_of_birth,
    is_accept_marketing,
    created_date,
    last_visit_date,
    total_spent,
    status
FROM customer
LIMIT 5;

-- Show table structure
DESCRIBE customer;
