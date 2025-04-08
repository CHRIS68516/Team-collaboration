-- Drop tables if they exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE scores CASCADE CONSTRAINTS';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE exams CASCADE CONSTRAINTS';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE subjects CASCADE CONSTRAINTS';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE students CASCADE CONSTRAINTS';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Create tables again
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    gender VARCHAR(10),
    class VARCHAR(10)
);

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50)
);

CREATE TABLE exams (
    exam_id INT PRIMARY KEY,
    subject_id INT,
    exam_date DATE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

CREATE TABLE scores (
    score_id INT PRIMARY KEY,
    student_id INT,
    exam_id INT,
    score INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

-- Now safely insert the data again
-- (Add your insert statements here after this)


-- INSERT students
INSERT INTO students VALUES (1, 'Alice', 'F', 'A');
INSERT INTO students VALUES (2, 'Bob', 'M', 'A');
INSERT INTO students VALUES (3, 'Cathy', 'F', 'A');
INSERT INTO students VALUES (4, 'David', 'M', 'B');
INSERT INTO students VALUES (5, 'Ella', 'F', 'B');
INSERT INTO students VALUES (6, 'Frank', 'M', 'B');
INSERT INTO students VALUES (7, 'Gina', 'F', 'A');
INSERT INTO students VALUES (8, 'Henry', 'M', 'A');
INSERT INTO students VALUES (9, 'Ivy', 'F', 'B');
INSERT INTO students VALUES (10, 'Jake', 'M', 'B');
INSERT INTO students VALUES (11, 'Karen', 'F', 'A');
INSERT INTO students VALUES (12, 'Leo', 'M', 'A');
INSERT INTO students VALUES (13, 'Mona', 'F', 'B');
INSERT INTO students VALUES (14, 'Nate', 'M', 'A');
INSERT INTO students VALUES (15, 'Olivia', 'F', 'B');
INSERT INTO students VALUES (16, 'Paul', 'M', 'B');
INSERT INTO students VALUES (17, 'Queenie', 'F', 'A');
INSERT INTO students VALUES (18, 'Ray', 'M', 'A');
INSERT INTO students VALUES (19, 'Sophia', 'F', 'B');
INSERT INTO students VALUES (20, 'Tom', 'M', 'B');

-- INSERT subjects
INSERT INTO subjects VALUES (1, 'Math');
INSERT INTO subjects VALUES (2, 'Science');
INSERT INTO subjects VALUES (3, 'English');

-- INSERT exams
INSERT INTO exams VALUES (101, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO exams VALUES (102, 1, TO_DATE('2024-02-15', 'YYYY-MM-DD'));
INSERT INTO exams VALUES (103, 2, TO_DATE('2024-01-20', 'YYYY-MM-DD'));
INSERT INTO exams VALUES (104, 2, TO_DATE('2024-02-20', 'YYYY-MM-DD'));
INSERT INTO exams VALUES (105, 3, TO_DATE('2024-01-25', 'YYYY-MM-DD'));

-- INSERT scores
INSERT INTO scores VALUES (1, 1, 101, 85);
INSERT INTO scores VALUES (2, 2, 101, 90);
INSERT INTO scores VALUES (3, 3, 101, 88);
INSERT INTO scores VALUES (4, 4, 101, 70);
INSERT INTO scores VALUES (5, 5, 101, 72);
INSERT INTO scores VALUES (6, 6, 101, 70);

-- DELETE Example
DELETE FROM students WHERE student_id = 10;

-- LOOP Example
DECLARE
  v_score INT;
  CURSOR cur_scores IS SELECT score FROM scores;
BEGIN
  FOR rec IN cur_scores LOOP
    DBMS_OUTPUT.PUT_LINE('Score: ' || rec.score);
  END LOOP;
END;
/

-- WINDOW FUNCTIONS
-- Prev/Next score
SELECT 
    s.student_id,
    st.student_name,
    e.exam_date,
    s.score,
    LAG(s.score) OVER (PARTITION BY e.subject_id ORDER BY e.exam_date) AS prev_score,
    LEAD(s.score) OVER (PARTITION BY e.subject_id ORDER BY e.exam_date) AS next_score
FROM scores s
JOIN exams e ON s.exam_id = e.exam_id
JOIN students st ON s.student_id = st.student_id;

-- Rank and Dense Rank
SELECT 
    st.class,
    st.student_name,
    s.score,
    RANK() OVER (PARTITION BY st.class ORDER BY s.score DESC) AS rank_score,
    DENSE_RANK() OVER (PARTITION BY st.class ORDER BY s.score DESC) AS dense_rank_score
FROM scores s
JOIN students st ON s.student_id = st.student_id;

-- Top 3 per class
SELECT *
FROM (
    SELECT 
        st.class,
        st.student_name,
        s.score,
        RANK() OVER (PARTITION BY st.class ORDER BY s.score DESC) AS class_rank
    FROM scores s
    JOIN students st ON s.student_id = st.student_id
) sub
WHERE class_rank <= 3;

-- First 2 students by exam date
SELECT *
FROM (
    SELECT 
        st.class,
        st.student_name,
        e.exam_date,
        ROW_NUMBER() OVER (PARTITION BY st.class ORDER BY e.exam_date) AS rn
    FROM scores s
    JOIN students st ON s.student_id = st.student_id
    JOIN exams e ON s.exam_id = e.exam_id
) sub
WHERE rn <= 2;

-- Last 5 students per class by score
SELECT *
FROM (
    SELECT 
        st.class,
        st.student_name,
        s.score,
        ROW_NUMBER() OVER (PARTITION BY st.class ORDER BY s.score ASC) AS rn_asc
    FROM scores s
    JOIN students st ON s.student_id = st.student_id
) sub
WHERE rn_asc <= 5;

-- Aggregation: Max per class & overall
SELECT 
    st.class,
    st.student_name,
    s.score,
    MAX(s.score) OVER (PARTITION BY st.class) AS max_in_class,
    MAX(s.score) OVER () AS max_overall
FROM scores s
JOIN students st ON s.student_id = st.student_id;

-- FUNCTION: Get average score
CREATE OR REPLACE FUNCTION get_student_avg(p_student_id INT)
RETURN NUMBER IS
  avg_score NUMBER;
BEGIN
  SELECT AVG(score) INTO avg_score
  FROM scores
  WHERE student_id = p_student_id;

  RETURN avg_score;
END;
/

-- FUNCTION: Get rank in a subject
CREATE OR REPLACE FUNCTION get_student_rank(p_student_id INT, p_subject_id INT)
RETURN INT IS
  student_rank INT;
BEGIN
  SELECT rnk INTO student_rank
  FROM (
    SELECT 
      s.student_id,
      RANK() OVER (ORDER BY s.score DESC) AS rnk
    FROM scores s
    JOIN exams e ON s.exam_id = e.exam_id
    WHERE e.subject_id = p_subject_id
  )
  WHERE student_id = p_student_id;

  RETURN student_rank;
END;
/
SELECT * FROM students;
SELECT * FROM subjects;
SELECT * FROM exams;
SELECT * FROM scores;
