/*
This code is a SQL query that copies data from a CSV file named (`company_dim.csv`) located at 
('D:\IT Courses\Courses 2025\SQL for Data Analytics - Full Course\Database\csv_files\company_dim.csv') into a table called (`company_dim`). 
It specifies that the file format is comma-separated values (CSV), has a header (columns name) row (true), and uses UTF-8 encoding.
PostgreSQL commonly uses this query to import data from external files into database tables.
In the context of the SQL query you provided, `DELIMITER` refers to the character used to separate values in the CSV file.
In this case, the delimiter specified is a comma (`,`), indicating that the values in the CSV file are separated by commas.
Regarding `ENCODING 'UTF8'`, UTF-8 is a character encoding standard that is capable of representing all possible characters in Unicode. 
When data is encoded in UTF-8, it ensures that various characters from different languages and scripts can be properly stored and displayed.
In this SQL query, it specifies that the data in the CSV file is encoded using UTF-8, which is a common and widely supported encoding for text data.
*/

COPY company_dim
FROM 'D:\IT Courses\Courses 2025\SQL for Data Analytics - Full Course\Database\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'D:\IT Courses\Courses 2025\SQL for Data Analytics - Full Course\Database\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'D:\IT Courses\Courses 2025\SQL for Data Analytics - Full Course\Database\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'D:\IT Courses\Courses 2025\SQL for Data Analytics - Full Course\Database\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

