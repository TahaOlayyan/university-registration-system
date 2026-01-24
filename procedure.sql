CREATE OR REPLACE PROCEDURE  PROC_ENROLL_STUDENT(p_student_id NUMBER,p_course_id NUMBER)
IS
    v_check_exists NUMBER;
    v_new_id       NUMBER;
    v_check        NUMBER;
    ex_duplicate_enroll EXCEPTION;
	
BEGIN

    SELECT 1 INTO v_check FROM STUDENTS WHERE student_id = p_student_id;
    SELECT 1 INTO v_check FROM COURSES WHERE course_id = p_course_id;
	
	SELECT COUNT(*) 
    INTO v_check_exists 
    FROM ENROLLMENTS 
    WHERE student_id = p_student_id AND course_id = p_course_id;
	
    IF v_check_exists > 0 THEN
        RAISE ex_duplicate_enroll;
    END IF;
	
	SELECT NVL(MAX(enroll_id), 0) + 1 INTO v_new_id FROM ENROLLMENTS;
	
	INSERT INTO ENROLLMENTS (enroll_id, student_id, course_id, enroll_date, mark, fee_paid, status) 
	VALUES (v_new_id,p_student_id,p_course_id,SYSDATE,NULL,'N','ACTIVE');
	COMMIT;
    DBMS_OUTPUT.PUT_LINE('Success: Student ' || p_student_id || ' enrolled in Course ' || p_course_id);
	
	EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Invalid Student ID or Course ID.');
        
    WHEN ex_duplicate_enroll THEN
        DBMS_OUTPUT.PUT_LINE('Error: Student is already enrolled in this course!');
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Something went wrong - ' || SQLERRM);
        ROLLBACK;
END;
