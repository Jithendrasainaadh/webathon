-- database.sql
-- SQL Schema for Farmer Advisory System

-- Create database
CREATE DATABASE IF NOT EXISTS farmer_advisory_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE farmer_advisory_db;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    location VARCHAR(100),
    role ENUM('farmer', 'admin', 'expert') DEFAULT 'farmer',
    status ENUM('active', 'inactive', 'pending') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Queries table
CREATE TABLE IF NOT EXISTS queries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    crop_type VARCHAR(50),
    question TEXT NOT NULL,
    image_path VARCHAR(255),
    status ENUM('pending', 'answered', 'resolved') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Responses table
CREATE TABLE IF NOT EXISTS responses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    query_id INT NOT NULL,
    response_text TEXT NOT NULL,
    diagnosis VARCHAR(255),
    recommendations TEXT,
    prevention_tips TEXT,
    responded_by VARCHAR(50) DEFAULT 'AI',
    rating INT CHECK (rating BETWEEN 1 AND 5),
    is_helpful BOOLEAN DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (query_id) REFERENCES queries(id) ON DELETE CASCADE,
    INDEX idx_query_id (query_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Resources table (for related articles, videos, guides)
CREATE TABLE IF NOT EXISTS resources (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type ENUM('video', 'pdf', 'article', 'guide') NOT NULL,
    url VARCHAR(500),
    file_path VARCHAR(255),
    category VARCHAR(50),
    description TEXT,
    duration_minutes INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_type (type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Session tracking table (optional - for security)
CREATE TABLE IF NOT EXISTS user_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    session_id VARCHAR(255) NOT NULL,
    ip_address VARCHAR(45),
    user_agent VARCHAR(255),
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_session_id (session_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default admin user (password: Admin@123)
-- IMPORTANT: Change this password immediately after first login
INSERT INTO users (name, email, password, role, status) VALUES 
('Admin User', 'admin@krishimitra.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', 'active');

-- Insert sample farmer user (password: Farmer@123)
INSERT INTO users (name, email, password, phone, location, role, status) VALUES 
('Ramesh Kumar', 'ramesh@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+91-9876543210', 'Punjab', 'farmer', 'active');

-- Insert sample resources
INSERT INTO resources (title, type, url, category, description, duration_minutes) VALUES 
('Tomato Leaf Disease Guide', 'video', 'https://example.com/video1', 'Crop Health', 'Complete guide on identifying and treating tomato diseases', 5),
('Tomato Fertilization Schedule', 'pdf', 'https://example.com/pdf1', 'Soil & Fertilizer', 'Month-by-month fertilizer application guide', NULL),
('Integrated Pest Management', 'article', 'https://example.com/article1', 'Pest Control', 'Organic pest control methods for crops', NULL);