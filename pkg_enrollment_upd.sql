CREATE OR REPLACE PACKAGE PKG_ENROLLMENT_UPD IS

    PROCEDURE PAY_FEES(p_enroll_id NUMBER);

    PROCEDURE UPDATE_MARK(p_enroll_id NUMBER, p_mark NUMBER);

END PKG_ENROLLMENT_UPD;
/

CREATE OR REPLACE PACKAGE BODY PKG_ENROLLMENT_UPD IS

  
    PROCEDURE PAY_FEES(p_enroll_id NUMBER) IS
	
        v_current_paid_status VARCHAR2(1); 
		
    BEGIN
        SELECT fee_paid 
        INTO v_current_paid_status 
        FROM ENROLLMENTS 
        WHERE enroll_id = p_enroll_id;

        IF v_current_paid_status = 'Y' THEN
            RAISE_APPLICATION_ERROR(-20001, 'Student has already paid fees for this enrollment!');
        ELSE
            UPDATE ENROLLMENTS
            SET fee_paid = 'Y'
            WHERE enroll_id = p_enroll_id;
            
            DBMS_OUTPUT.PUT_LINE('Fee status updated to PAID for Enrollment ID: ' || p_enroll_id);
        END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Enrollment ID not found!');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Unexpected Error: ' || SQLERRM);
    END PAY_FEES;
	
	-- PROCEDURE 2 
    PROCEDURE UPDATE_MARK(p_enroll_id NUMBER, p_mark NUMBER) IS
	
        v_check NUMBER; 
		
    BEGIN
	
        IF p_mark < 0 OR p_mark > 100 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Invalid Mark! Must be between 0 and 100.');
        END IF;

       
        SELECT 1 INTO v_check FROM ENROLLMENTS WHERE enroll_id = p_enroll_id;

        UPDATE ENROLLMENTS
        SET mark = p_mark,
            status = CASE     -- CASE Expression 
                        WHEN p_mark >= 50 THEN 'COMPLETED' 
                        ELSE 'ACTIVE' 
                     END
        WHERE enroll_id = p_enroll_id;

        DBMS_OUTPUT.PUT_LINE('Mark updated successfully.');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Enrollment ID not found! Cannot update mark.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'Error updating mark: ' || SQLERRM);
    END UPDATE_MARK;

END PKG_ENROLLMENT_UPD;
/
