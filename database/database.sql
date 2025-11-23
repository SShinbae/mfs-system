-- MFS System Database Schema
-- Created for Management & Facilities System

CREATE DATABASE IF NOT EXISTS mfs_system;
USE mfs_system;

-- Employees Table
CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Problem Tickets Table
CREATE TABLE IF NOT EXISTS problem_tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id VARCHAR(50) UNIQUE NOT NULL,
    reporter_id INT NOT NULL,
    reporter_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    problem_category VARCHAR(100),
    problem_description TEXT,
    assigned_to VARCHAR(100),
    remark TEXT,
    status ENUM('Pending', 'In Progress', 'Solved', 'Cancelled') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (reporter_id) REFERENCES employees(id) ON DELETE CASCADE
);

-- Car Booking Table
CREATE TABLE IF NOT EXISTS car_bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id VARCHAR(50) UNIQUE NOT NULL,
    employee_id INT NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    car_type VARCHAR(50),
    destination TEXT,
    purpose TEXT,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    driver_name VARCHAR(100),
    status ENUM('Pending', 'Approved', 'Rejected', 'Completed', 'Cancelled') DEFAULT 'Pending',
    remark TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);

-- Meeting Room Bookings Table
CREATE TABLE IF NOT EXISTS meeting_room_bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id VARCHAR(50) UNIQUE NOT NULL,
    employee_id INT NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    room_name VARCHAR(100),
    meeting_title VARCHAR(200),
    purpose TEXT,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    attendees_count INT,
    equipment_needed TEXT,
    status ENUM('Pending', 'Approved', 'Rejected', 'Completed', 'Cancelled') DEFAULT 'Pending',
    remark TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);

-- Borrow Items Table
CREATE TABLE IF NOT EXISTS borrow_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    borrow_id VARCHAR(50) UNIQUE NOT NULL,
    employee_id INT NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    item_name VARCHAR(200),
    item_category VARCHAR(100),
    quantity INT DEFAULT 1,
    purpose TEXT,
    borrow_date DATE NOT NULL,
    expected_return_date DATE NOT NULL,
    actual_return_date DATE,
    status ENUM('Pending', 'Approved', 'Borrowed', 'Returned', 'Rejected', 'Overdue') DEFAULT 'Pending',
    remark TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);

-- Request Items Table
CREATE TABLE IF NOT EXISTS request_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    request_id VARCHAR(50) UNIQUE NOT NULL,
    employee_id INT NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    item_name VARCHAR(200),
    item_category VARCHAR(100),
    quantity INT DEFAULT 1,
    urgency ENUM('Low', 'Medium', 'High', 'Critical') DEFAULT 'Medium',
    justification TEXT,
    estimated_cost DECIMAL(10,2),
    status ENUM('Pending', 'Approved', 'Rejected', 'Ordered', 'Received') DEFAULT 'Pending',
    remark TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);

-- Insert default admin user (password: admin123)
INSERT INTO employees (employee_id, password, name, department, email, role) 
VALUES ('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'System Administrator', 'IT', 'admin@mfs.com', 'admin');

-- Insert sample users (password: user123)
INSERT INTO employees (employee_id, password, name, department, email, role) 
VALUES 
('EMP001', '$2y$10$nC5XdBDODnImQy3R1YVbg.mOqxmZ5pKFO/VXTbKLvVKLXyKbFqOge', 'John Doe', 'IT', 'john@mfs.com', 'user'),
('EMP002', '$2y$10$nC5XdBDODnImQy3R1YVbg.mOqxmZ5pKFO/VXTbKLvVKLXyKbFqOge', 'Jane Smith', 'HR', 'jane@mfs.com', 'user');
