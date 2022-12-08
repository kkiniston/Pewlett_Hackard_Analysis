--  Data is from https://github.com/vrajmohan/pgsql-sample-data/tree/master/employee
-- Creating tables for PH-EmployeeDB
--D1:The Number of Retiring employees by Title
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date 
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT *
FROM retirement_titles;

--remove the duplicates
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title 
-- Export the Unique Titles table as unique_titles.csv
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no,
	rt.to_date DESC;
	
SELECT *
FROM unique_titles;



SELECT COUNT(ut.emp_no),
	ut.title 
-- Export the Retiring Titles table as retiring_titles.csv
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;

SELECT *
FROM retiring_titles;

--D2: Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title 
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
							AND de.to_date = '9999-01-01')
ORDER BY e.emp_no,
	ti.to_date DESC;

SELECT *
FROM mentorship_eligibilty;