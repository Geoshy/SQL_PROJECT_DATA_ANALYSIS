/*
The following statement are used to manipulate tables.
1.	CREATE TABLES: Create tables:
*/

CREATE TABLE job_applied
(
    job_id INT NOT NULL PRIMARY KEY,
    application_sent_date DATE NOT NULL,
    custom_resume BOOLEAN NOT NULL,
    resume_file_name VARCHAR(225) NOT NULL,
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50) NOT NULL
);

-- 2. INSERT INTO: Add columns (data) to your tables:
INSERT INTO job_applied
(
    job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)
VALUES
(
    1,
    '2024-02-01',
    true,
    'resume_02.pdf',
    true,
    'cover_letter_01.pdf',
    'submitted'
),
(
    2,
    '2024-02-02',
    true,
    'resume_02.pdf',
    false,
    NULL,
    'interview_scheduales'   
),
(
    3,
    '2024-02-03',
    true,
    'resume_03.pdf',
    true,
    'cover_letter_03.pdf',
    'ghosted'   
),
(
    4,
    '2024-02-04',
    true,
    'resume_04.pdf',
    false,
    NULL,
    'submitted'   
),
(
    5,
    '2024-02-05',
    true,
    'resume_05.pdf',
    true,
    'cover_letter_05.pdf',
    'rejected'   
);

-- 3.	ALTER TABLE:

-- 1.	ADD: Add columns:
ALTER TABLE job_applied
ADD contact VARCHAR(50);

-- 2.	RENAME COLUMN: Rename a column on an existig table.
ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

-- 3.	ALTER COLUMN: 
--	Used to modify the properties of an existing column in a table.
--	Change Data Type: Modify the column's data type, subject to compatibility between the old and new types.
--	Limitations: Certain data types can't be changed.

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

-- 4.	DROP COLUMN: Delete a column.
ALTER TABLE job_applied
DROP COLUMN marital_status;

/*
4.	UPDATE TABLE:
UPDATE: used to modify existing data in a table.
SET: specifies the column to be updated and the new value for that column.
WHERE: filters which rows to update based on a condition.
*/

UPDATE job_applied
SET contact = 'Erlich Bachman'
WHERE job_id = 1;


UPDATE job_applied
SET contact = 'Mahamoud Mhumoud'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Sayed Kamal'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Joan Halown'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Dona Londy'
WHERE job_id = 5;

-- 5.	DROP TABLE: Delete tables.
DROP TABLE job_applied;

