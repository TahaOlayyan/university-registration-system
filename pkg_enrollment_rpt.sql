CREATE OR REPLACE PACKAGE PKG_ENROLLMENT_RPT IS
    PROCEDURE PRINT_STUDENT_REPORT(p_student_id NUMBER);
END PKG_ENROLLMENT_RPT;
/

CREATE OR REPLACE PACKAGE BODY PKG_ENROLLMENT_RPT IS

    PROCEDURE PRINT_STUDENT_REPORT(p_student_id NUMBER) IS
	
        v_c_name        COURSES.course_name%TYPE;
        v_c_fee         COURSES.course_fee%TYPE;
        
        v_student_name  STUDENTS.full_name%TYPE;
        v_total_courses NUMBER := 0;
        v_total_fees    NUMBER := 0;
        v_paid_count    NUMBER := 0;
        v_unpaid_count  NUMBER := 0;

        CURSOR c_student_courses IS
            SELECT course_id,    
                   enroll_date, 
                   mark, 
                   fee_paid, 
                   status
            FROM ENROLLMENTS
            WHERE student_id = p_student_id;

    BEGIN
        SELECT full_name INTO v_student_name 
        FROM STUDENTS 
        WHERE student_id = p_student_id;

        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('STUDENT REPORT: ' || v_student_name);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(RPAD('Course Name', 20) || ' | ' || RPAD('Fee', 6) || ' | ' || RPAD('Paid?', 6) || ' | ' || 'Status');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');

        FOR rec IN c_student_courses LOOP
            
            SELECT course_name, course_fee
            INTO v_c_name, v_c_fee
            FROM COURSES
            WHERE course_id = rec.course_id;

            DBMS_OUTPUT.PUT_LINE(RPAD(v_c_name, 20) || ' | ' || 
                                 RPAD(v_c_fee, 6)   || ' | ' || 
                                 RPAD(rec.fee_paid, 6) || ' | ' || 
                                 rec.status);

            v_total_courses := v_total_courses + 1;
            v_total_fees    := v_total_fees + v_c_fee; 

            IF rec.fee_paid = 'Y' THEN
                v_paid_count := v_paid_count + 1;
            ELSE
                v_unpaid_count := v_unpaid_count + 1;
            END IF;
            
        END LOOP; 

        IF v_total_courses = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No enrollments found.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('SUMMARY:');
            DBMS_OUTPUT.PUT_LINE('Total Courses: ' || v_total_courses);
            DBMS_OUTPUT.PUT_LINE('Total Fees:    ' || v_total_fees);
            DBMS_OUTPUT.PUT_LINE('Paid:          ' || v_paid_count);
            DBMS_OUTPUT.PUT_LINE('Unpaid:        ' || v_unpaid_count);
        END IF;
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: Student ID not found.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END PRINT_STUDENT_REPORT;

END PKG_ENROLLMENT_RPT;
/