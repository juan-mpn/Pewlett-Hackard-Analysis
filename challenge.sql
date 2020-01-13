-- 1. Number of [titles] Retiring
SELECT DISTINCT  ON (ce.emp_no, d.dept_name,t.from_date) 
		   ce.emp_no,
		   ce.first_name,
		   ce.last_name,
		   d.dept_name,
		   t.title,
		   t.from_date,
		   s.salary
	INTO titles_info
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


-- 2. Who’s Ready for a Mentor?
SELECT DISTINCT  ON (ce.emp_no, d.dept_name,t.from_date) 
		   ce.emp_no,
		   ce.first_name,
		   ce.last_name,
		   d.dept_name,
		   t.title,
		   t.from_date,t.to_date,
		   s.salary
	-- INTO mentor_info
	FROM current_emp as ce
	RIGHT JOIN dept_emp as de
	ON ce.emp_no = de.emp_no
	RIGHT JOIN departments AS d
	ON (de.dept_no = d.dept_no )
	left JOIN titles AS t
	ON ce.emp_no = t.emp_no
	left JOIN employees AS e
	ON ce.emp_no = e.emp_no AND (e.hire_date BETWEEN '1965-01-01' AND '1965-12-31')
	RIGHT JOIN salaries AS s
	ON (ce.emp_no = s.emp_no )
	WHERE
	(de.to_date = ('9999-01-01') and t.to_date = ('9999-01-01'))
 order by t.from_date DESC

