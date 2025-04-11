-- ======================================
-- Student Performance & Analytics System
-- FUNCTIONS AND PROCEDURES ONLY
-- ======================================

-- 🔧 FUNCTION: Get Average Score of a Student
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

-- 🔧 FUNCTION: Get Rank of a Student in a Subject
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

-- ⚙ PROCEDURE: Show All Scores for a Student
CREATE OR REPLACE PROCEDURE show_scores(p_student_id INT) IS
BEGIN
  FOR rec IN (
    SELECT e.exam_date, sub.subject_name, s.score
    FROM scores s
    JOIN exams e ON s.exam_id = e.exam_id
    JOIN subjects sub ON e.subject_id = sub.subject_id
    WHERE s.student_id = p_student_id
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Subject: ' || rec.subject_name || 
                         ' | Date: ' || TO_CHAR(rec.exam_date, 'YYYY-MM-DD') || 
                         ' | Score: ' || rec.score);
  END LOOP;
END;
/

-- ⚙ PROCEDURE: Show Average Score of a Student
CREATE OR REPLACE PROCEDURE show_student_avg(p_student_id INT) IS
  avg_score NUMBER;
BEGIN
  avg_score := get_student_avg(p_student_id);
  DBMS_OUTPUT.PUT_LINE('Student ID: ' || p_student_id || 
                       ' | Average Score: ' || avg_score);
END;
/

-- ⚙ PROCEDURE: Show Top N Students per Class
CREATE OR REPLACE PROCEDURE show_top_students(p_n INT) IS
BEGIN
  FOR rec IN (
    SELECT * FROM (
      SELECT 
        st.class,
        st.student_name,
        s.score,
        RANK() OVER (PARTITION BY st.class ORDER BY s.score DESC) AS class_rank
      FROM scores s
      JOIN students st ON s.student_id = st.student_id
    ) 
    WHERE class_rank <= p_n
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Class: ' || rec.class || 
                         ' | Name: ' || rec.student_name || 
                         ' | Score: ' || rec.score || 
                         ' | Rank: ' || rec.class_rank);
  END LOOP;
END;


