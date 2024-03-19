CREATE TABLE IF NOT EXISTS users (
     user_id int NOT NULL AUTO_INCREMENT,
     accreditation_num int DEFAULT -1,
     active TINYINT NOT NULL,
     address varchar(255) NOT NULL,
     date_of_birth date NOT NULL,
     email varchar(100) NOT NULL,
     first_name varchar(100) NOT NULL,
     last_name varchar(100) NOT NULL,
     password varchar(30) NOT NULL,
     phone_num varchar(30) NOT NULL,
     role ENUM('AD','PA','DR') NOT NULL,
     verified TINYINT DEFAULT 0,
     PRIMARY KEY (user_id),
     UNIQUE KEY `phone_num_UNIQUE` (phone_num),
     UNIQUE KEY `email_UNIQUE` (email)
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS patient_health_info (
     profile_id int NOT NULL,
     user_id int NOT NULL,
     height double DEFAULT NULL,
     weight double DEFAULT NULL,
     health_status varchar(255) DEFAULT NULL,
     PRIMARY KEY (profile_id),
     CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES userServices.users (user_id)
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS booking (
    booking_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT NOT NULL,
    booking_date DATE NOT NULL,
    booking_time TIME,
    booking_end_time TIME,
    chat_link varchar(200),
    has_paid TINYINT(0),
    is_availability TINYINT(4) DEFAULT 1 NOT NULL,
    PRIMARY KEY (booking_id),
    CONSTRAINT patient_id FOREIGN KEY (patient_id) REFERENCES userServices.users (user_id),
    CONSTRAINT doctor_id FOREIGN KEY (doctor_id) REFERENCES userServices.users (user_id)
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS prescription (
    prescription_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    medicine_name varchar(255) DEFAULT NULL,
    dose varchar(255) DEFAULT NULL,
    instructions varchar(255) DEFAULT NULL,
    PRIMARY KEY (prescription_id),
    FOREIGN KEY (patient_id) REFERENCES userServices.users (user_id),
    FOREIGN KEY (doctor_id) REFERENCES userServices.users (user_id)
) ENGINE=InnoDB;





