-- 
SELECT * FROM departments;

select * from employees;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- 90,398
SELECT count(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT count(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;


-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date



SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Employee count by department number output to table for CSV
SELECT COUNT(ce.emp_no), de.dept_no 
INTO dept_emp_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

-- Query for list 1 based on employes, salaries and dept_emp
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender,
	s.salary,
    de.to_date
INTO emp_list1
FROM employees AS e
INNER JOIN salaries AS s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');


-- List 2 
SELECT dm.dept_no,
       d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments as d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS  ce
		ON (dm.emp_no = ce.emp_no);

SELECT ce.emp_no,
	   ce.first_name,
	   ce.last_name,
	   d.dept_name
INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);


-- Sales Info from retirment table
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
    de.to_date,
    d.dept_name
INTO sales_info
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
LEFT JOIN departments AS d
ON (de.dept_no = d.dept_no )
WHERE (d.dept_name = 'Sales' );

-- Sales and Development team list 
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
    d.dept_name
INTO salesdev_info
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
LEFT JOIN departments AS d
ON (de.dept_no = d.dept_no )
WHERE (d.dept_name in ('Sales', 'Development') );


SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
    d.dept_name
INTO salesdev_info
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
LEFT JOIN departments AS d
ON (de.dept_no = d.dept_no )
WHERE (d.dept_name in ('Sales', 'Development'))
AND (de.to_date = ('9999-01-01');
--
--


SELECT DISTINCT  ON (ce.emp_no, d.dept_name,t.from_date) 
		   ce.emp_no,
		   ce.first_name,
		   ce.last_name,
		   d.dept_name,
		   t.title,
		   t.from_date,
		   s.salary
	-- INTO titles_info
	FROM current_emp as ce
	RIGHT JOIN dept_emp as de
	ON ce.emp_no = de.emp_no
	RIGHT JOIN departments AS d
	ON (de.dept_no = d.dept_no )
	left JOIN titles AS t
	ON ce.emp_no = t.emp_no
	RIGHT JOIN salaries AS s
	ON (ce.emp_no = s.emp_no )
	WHERE
	(de.to_date = ('9999-01-01') and t.to_date = ('9999-01-01'))
 order by t.from_date DESC




SELECT ce.emp_no,
   	   ce.first_name,
	   ce.last_name,
       d.dept_name, 
	   COUNT(*)
-- INTO titles_info
FROM dept_emp AS de
RIGHT JOIN current_emp AS ce
ON ce.emp_no = de.emp_no AND (de.to_date = ('9999-01-01'))
RIGHT JOIN departments AS d
ON (de.dept_no = d.dept_no )
RIGHT JOIN titles AS t
ON ce.emp_no = t.emp_no
RIGHT JOIN salaries AS s
ON (ce.emp_no = s.emp_no )
GROUP BY ce.emp_no,
   	   ce.first_name,
	   ce.last_name,
       d.dept_name 
HAVING COUNT(*) > 1 


-- Partition 
SELECT * FROM 
(SELECT *, COUNT(*) OVER 
(PARTITION BY 
       ce.emp_no,
   	   ce.first_name,
	   ce.last_name,
       d.dept_name 
) AS count 
FROM current_emp AS ce
RIGHT JOIN dept_emp AS de
ON de.emp_no = ce.emp_no
RIGHT JOIN departments AS d
ON (de.dept_no = d.dept_no ) AND (de.to_date = ('9999-01-01'))
 RIGHT JOIN titles AS t  
ON t.emp_no = de.emp_no -- AND (t.to_date = ('9999-01-01'))
RIGHT JOIN salaries AS s
ON (ce.emp_no = s.emp_no )
) tableWithCount
WHERE tableWithCount.count >1 ;



