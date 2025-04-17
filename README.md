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
