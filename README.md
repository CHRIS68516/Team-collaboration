🎓 Student Performance & Analytics System

🎓 Student Performance & Analytics System

📌 Overview
The Student Performance & Analytics System is a comprehensive Oracle SQL-based solution designed to manage and analyze student academic performance across multiple subjects and exams. This system focuses on database creation, data management, and the generation of advanced insights through SQL queries and PL/SQL procedures.

With this system, educational institutions can:

Efficiently manage student and exam data.

Monitor individual and group performance over time.

Generate rankings and identify top-performing or struggling students.

Provide a foundation for data-driven decision-making in academic administration.



⚙️ Database Structure & Logic
🔄 1. Dropping Existing Tables
Before recreating the database schema, the script ensures that any previously existing tables (scores, exams, subjects, students) are safely dropped to avoid duplication errors. Each DROP TABLE operation is encapsulated in a PL/SQL block to suppress errors if the table does not already exist.


<img width="884" alt="drop table " src="https://github.com/user-attachments/assets/b99b4cce-247c-4e9b-810b-0d1234b7ca6c" />


🧱 2. Creating Tables

The system consists of four interconnected tables:

students: Contains personal details about each student, such as their ID, name, gender, and class grouping.


<img width="763" alt="create table student" src="https://github.com/user-attachments/assets/1a534805-58a9-4a5d-a1c9-bb3881234526" />

subjects: Defines the list of subjects offered (e.g., Math, Science, English).

exams: Captures exam-specific details, including the subject and the date on which the exam was conducted.

scores: Records individual student scores for each exam, linking to both the student and the exam.

Each table uses primary keys to uniquely identify rows and foreign keys to maintain referential integrity between related data.

<img width="932" alt="create table " src="https://github.com/user-attachments/assets/17b992d1-125a-43a5-ad25-108faa1ef8c1" />

📥 Data Population
👨‍🎓 Students
The script inserts records for 20 students, distributed across two classes: Class A and Class B. Both male and female students are represented to simulate a realistic academic environment.
<img width="815" alt="insert into students " src="https://github.com/user-attachments/assets/2556f893-5124-4710-907a-57c644f9b4aa" />

📚 Subjects
Three foundational academic subjects are added:

Mathematics

Science

English

📝 Exams
Five exams are associated with the above subjects, each with specific exam dates, to simulate a real academic term with multiple assessments.

🧾 Scores
A few initial scores are entered to provide a working dataset for analytics. These records link students to specific exams and capture their performance numerically.

<img width="944" alt="insert " src="https://github.com/user-attachments/assets/6f56da04-198b-4031-86a4-329bf430a1ac" />


🧹 Data Modification Example
An example DELETE statement is included to show how to remove a student from the system (student_id = 10). This can be adapted for other use cases like removing dropped students or correcting errors.

<img width="800" alt="delete " src="https://github.com/user-attachments/assets/8125572a-edf4-44b8-8e52-dad95f0f6229" />

🔁 PL/SQL Looping Example
The script uses a PL/SQL cursor loop to iterate through the scores table and display each score using DBMS_OUTPUT.PUT_LINE. This demonstrates procedural control and output in Oracle SQL and is useful for batch processing or diagnostics.

<img width="822" alt="procedure  " src="https://github.com/user-attachments/assets/256e991d-1366-49ee-a930-e03e87ebf0c8" />

📊 Advanced Analytics Using Window Functions
Window functions are powerful SQL features that provide row-wise calculations without collapsing rows (unlike aggregate functions). This script demonstrates multiple use cases:

LAG & LEAD: Show previous and next scores to understand trends.

RANK & DENSE_RANK: Rank students within their class based on performance.

ROW_NUMBER: Identify the order of student scores or participation in exams.

Top Performers: Extract the top 3 students in each class.

Lowest Performers: Extract the bottom 5 students per class.

Aggregate Max Scores: Display the maximum score in each class and overall, alongside student details.

These queries help identify top talent, students needing support, and patterns in performance.

<img width="815" alt="select" src="https://github.com/user-attachments/assets/86c960dd-adb4-4786-9281-e0a2d16d3200" />

