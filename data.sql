INSERT INTO STUDENTS (student_id, full_name, mobile) VALUES (101, 'Ahmed Ali', '0790000001');
INSERT INTO STUDENTS (student_id, full_name, mobile) VALUES (102, 'Sara Sameer', '0790000002');
INSERT INTO STUDENTS (student_id, full_name, mobile) VALUES (103, 'Omar Khaled', '0790000003');
INSERT INTO STUDENTS (student_id, full_name, mobile) VALUES (104, 'Laila Hasan', '0790000004');
INSERT INTO STUDENTS (student_id, full_name, mobile) VALUES (105, 'Khaled Nabil', '0790000005');

INSERT INTO COURSES (course_id, course_name, course_fee) VALUES (10, 'Database 1', 250);
INSERT INTO COURSES (course_id, course_name, course_fee) VALUES (20, 'Java Programming', 300);
INSERT INTO COURSES (course_id, course_name, course_fee) VALUES (30, 'Web Development', 400);
INSERT INTO COURSES (course_id, course_name, course_fee) VALUES (40, 'System Analysis', 350);


INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (1, 101, 10, 85, 'Y', 'COMPLETED');

INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (2, 101, 20, NULL, 'N', 'ACTIVE');

INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (3, 102, 30, 100, 'Y', 'COMPLETED');

INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (4, 103, 10, 0, 'Y', 'COMPLETED'); 

INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (5, 103, 40, 60, 'Y', 'ACTIVE');

INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (6, 104, 10, 70, 'Y', 'COMPLETED');

INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (7, 104, 20, 90, 'Y', 'COMPLETED');

INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (8, 104, 30, NULL, 'N', 'ACTIVE');

INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (9, 105, 40, NULL, 'Y', 'DROPPED');

INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, mark, fee_paid, status) 
VALUES (10, 102, 10, 45, 'Y', 'ACTIVE');

COMMIT;