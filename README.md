# 🎓 Student Enrollment System (Oracle PL/SQL)

A robust database management system built with **Oracle PL/SQL** to handle student enrollments, course management, grade processing, and financial reporting. This project demonstrates advanced database programming concepts including **Packages**, **Stored Procedures**, **Exception Handling**, and **Cursor-based Reporting**.

---

## 🚀 Features & Functionality

This system provides a backend logic to simulate a university registration system:

* **Data Integrity:** Strong database schema with `PRIMARY KEY`, `FOREIGN KEY`, and `CHECK` constraints (e.g., marks between 0-100, valid status).
* **Student Enrollment:** A dedicated procedure to enroll students while preventing duplicates and validating IDs.
* **Transactional Safety:** Includes `COMMIT` and `ROLLBACK` logic to ensure data consistency.
* **Modular Architecture (Packages):**
    * `PKG_ENROLLMENT_UPD`: Handles business logic for payments and grade updates.
    * `PKG_ENROLLMENT_RPT`: Generates detailed textual reports for students using cursors.
* **Business Logic Automation:** Automatically updates enrollment status (e.g., `ACTIVE` to `COMPLETED`) based on the student's mark.
* **Error Handling:** Custom user-defined exceptions (e.g., `ex_duplicate_enroll`) and standard system exception handling.

---

## 🛠️ Database Schema

The system is built on three main relational tables:

1.  **STUDENTS**: Stores student details (ID, Name, Mobile).
2.  **COURSES**: Stores course metadata (ID, Name, Fee).
3.  **ENROLLMENTS**: The junction table linking Students and Courses, tracking:
    * `mark`: Student's grade.
    * `fee_paid`: Payment status ('Y'/'N').
    * `status`: 'ACTIVE', 'COMPLETED', or 'DROPPED'.

---

## 📂 Project Structure (PL/SQL Components)

### 1. Enrollment Procedure (`PROC_ENROLL_STUDENT`)
* **Goal:** Register a student in a course.
* **Logic:** Checks if the student/course exists, ensures no duplicate enrollment, generates a new ID, and inserts the record.
* **Output:** Success message or specific error messages.

### 2. Update Package (`PKG_ENROLLMENT_UPD`)
Contains two main procedures:
* `PAY_FEES(p_enroll_id)`:
    * Updates `fee_paid` to 'Y'.
    * **Validation:** Throws an error if fees are already paid.
* `UPDATE_MARK(p_enroll_id, p_mark)`:
    * Updates the student's mark.
    * **Logic:** Automatically sets status to `COMPLETED` if mark >= 50, otherwise keeps it `ACTIVE`.

### 3. Reporting Package (`PKG_ENROLLMENT_RPT`)
* `PRINT_STUDENT_REPORT(p_student_id)`:
    * Uses an **Explicit Cursor** to iterate through student courses.
    * Calculates total fees, count of paid/unpaid courses.
    * Uses `DBMS_OUTPUT` to print a formatted table to the console.

---

## 💻 How to Run

### Prerequisites
* Oracle Database (11g, 12c, 19c, or 21c).
* A client tool like **SQL Developer**, **Toad**, or **SQLPlus**.

### Installation Steps
1.  **Execute the DDL Script:** Run the table creation scripts (`CREATE TABLE...`).
2.  **Seed Data:** Run the `INSERT` statements to populate initial data.
3.  **Compile Objects:** Run the `CREATE OR REPLACE...` scripts for the Procedure and Packages (Spec & Body).
4.  **Enable Output:** If using SQL Developer/SQLPlus, ensure output is on:
    ```sql
    SET SERVEROUTPUT ON;
    ```

---

## 🧪 Usage Examples (Test Cases)

Here is how you can interact with the system after installation:

### 1. Enroll a New Student
```sql
BEGIN
    -- Enroll Student 101 into Course 40
    PROC_ENROLL_STUDENT(101, 40);
END;
/

```

### 2. Pay Fees

```sql
BEGIN
    -- Pay fees for Enrollment ID 11 (generated from previous step)
    PKG_ENROLLMENT_UPD.PAY_FEES(11);
END;
/

```

### 3. Update Mark (Auto-Status Update)

```sql
BEGIN
    -- Update mark to 85 (Status should change to COMPLETED)
    PKG_ENROLLMENT_UPD.UPDATE_MARK(11, 85);
END;
/

```

### 4. Generate Student Report

```sql
BEGIN
    PKG_ENROLLMENT_RPT.PRINT_STUDENT_REPORT(101);
END;
/

```

**Expected Report Output:**

```text
--------------------------------------------------
STUDENT REPORT: Ahmed Ali
--------------------------------------------------
Course Name          | Fee    | Paid?  | Status
--------------------------------------------------
Database 1           | 250    | Y      | COMPLETED
System Analysis      | 350    | Y      | COMPLETED
...
--------------------------------------------------
SUMMARY:
Total Courses: 2
Total Fees:    600
...

```

---

## 📝 Learning Outcomes

This project was created to master:

* Relational Database Design.
* PL/SQL Modular Programming.
* Complex Business Logic Implementation in the Database Layer.

---

### Author

[Taha Walid Olayyan]

