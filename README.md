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
<img width="805" alt="1" src="https://github.com/user-attachments/assets/1e460cfb-2214-4280-a223-5e38770cb1d4" />
<img width="727" alt="2" src="https://github.com/user-attachments/assets/5f2f026a-20bc-4aac-8fd2-79a2d81ee085" />
<img width="720" alt="3" src="https://github.com/user-attachments/assets/42223249-b363-4d80-875f-0b6103aba0a3" />
<img width="944" alt="5" src="https://github.com/user-attachments/assets/ac251c8c-0fcc-4730-b5f2-4aa81ebfb376" />


🧠 Custom Functions
Two reusable SQL functions are created for deeper insights:

1. get_student_avg(student_id)
Purpose: Returns the average score of a student across all exams.

Use case: Useful for tracking overall student performance and eligibility for honors or academic interventions.

2. get_student_rank(student_id, subject_id)
Purpose: Returns the rank of a student within a specific subject.

Use case: Enables per-subject performance tracking and comparisons between students.

These functions encapsulate logic that can be reused in reports or application logic.

<img width="860" alt="9" src="https://github.com/user-attachments/assets/43126478-a2e9-4dcf-94ca-147bd0b242b9" />


🔍 Sample Queries for Data Review
The script concludes by displaying all records from the core tables:

students
<img width="485" alt="10" src="https://github.com/user-attachments/assets/7bcc380f-253b-4b27-996c-0d0463547511" />


scores
<img width="315" alt="11" src="https://github.com/user-attachments/assets/0207c653-7557-4311-a81b-07d27de4cd18" />


exams
<img width="486" alt="13" src="https://github.com/user-attachments/assets/8f0b377c-70df-425b-8fb4-3d6eba15a6bb" />


subjects
<img width="447" alt="12" src="https://github.com/user-attachments/assets/8e9b4c1e-bcb8-45cd-b3d2-2c2680fb1907" />

 Conceptual Diagram

 <img width="649" alt="MODEL1" src="https://github.com/user-attachments/assets/2d3669c4-8896-4325-842d-34007691f844" />
 
 <img width="590" alt="model 2" src="https://github.com/user-attachments/assets/5e270483-fa7e-40dd-8bbd-69830ffff846" />
 
 <img width="365" alt="model 3" src="https://github.com/user-attachments/assets/278139b9-7981-430d-8fa4-6735a18aaf21" />

Conception Model

![ERD](https://github.com/user-attachments/assets/8102a7cd-eea0-4fcc-8f8a-49744fdcea6b)



🛠️ System Requirements
Database: Oracle DB (tested with Oracle 12c and later)

Tools: SQL*Plus, Oracle SQL Developer, or any compatible IDE

Optional: Enable output for PL/SQL (SET SERVEROUTPUT ON in SQL*Plus)




🧪 Suggested Enhancements & Testing
You can extend and experiment with the system using the following ideas:

Add more subjects, students, and scores to simulate larger datasets.

Modify the analytics queries to group by gender or specific date ranges.

Create views for common queries (e.g., top performers per subject).

Implement triggers to validate data on insert/update.

Create procedures for bulk data loading or automated ranking generation.



🙌 Final Note

"All knowledge and understanding come from God. To Him be the glory for every line of code, every insight revealed, and every challenge overcome."

This project was developed with diligence, purpose, and a heart of gratitude. May it serve as a helpful tool for learning, analysis, and growth.


