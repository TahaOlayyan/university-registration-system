SET SERVEROUTPUT ON;


BEGIN
    -- إضافة طالبين (واحد للتسجيل وواحد للفحص الفاضي)
    INSERT INTO STUDENTS (student_id, full_name, mobile, created_at)
    VALUES (990, 'Zaid Test User', '0799999999', SYSDATE);

    INSERT INTO STUDENTS (student_id, full_name, mobile, created_at)
    VALUES (991, 'Empty Student', '0788888888', SYSDATE);

    -- إضافة مادتين
    INSERT INTO COURSES (course_id, course_name, course_fee)
    VALUES (5001, 'Database Systems', 300);

    INSERT INTO COURSES (course_id, course_name, course_fee)
    VALUES (5002, 'Java Programming', 250);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Data might already exist, continuing...');
END;
/

-- ==========================================
-- 2. TEST DELIVERABLE 1: Enrollment Procedure
-- ==========================================

-- أ) تسجيل ناجح (Success Case)
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>> 1.A: Attempting successful enrollment...');
    PROC_ENROLL_STUDENT(990, 5001); -- تسجيل الطالب 990 في المادة 5001
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Student 990 enrolled in Course 5001.');
    
    PROC_ENROLL_STUDENT(990, 5002);
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Student 990 enrolled in Course 5002.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('FAIL: ' || SQLERRM);
END;
/

-- ب) تجربة التكرار (Duplicate Error Case)
-- لازم يطلع مسج إنه الطالب مسجل مسبقاً
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>> 1.B: Attempting duplicate enrollment (Should Fail)...');
    PROC_ENROLL_STUDENT(990, 5001); -- بنحاول نسجله بنفس المادة
    
    -- إذا وصل هون معناها الكود ما مسك الغلط
    DBMS_OUTPUT.PUT_LINE('FAIL: Duplicate enrollment was allowed!');
EXCEPTION
    WHEN OTHERS THEN
        -- إذا دخل هون معناها الـ Exception اشتغل صح
        DBMS_OUTPUT.PUT_LINE('PASS: Expected Error Caught -> ' || SQLERRM);
END;
/

-- ==========================================
-- 3. TEST DELIVERABLE 2: UPDATE Package (Fees & Marks)
-- ==========================================

DECLARE
    v_enroll_id NUMBER;
BEGIN
    -- بنجيب رقم التسجيل للطالب 990 عشان نعدل عليه
    SELECT MAX(enroll_id) INTO v_enroll_id 
	FROM ENROLLMENTS 
	WHERE student_id = 990;

    -- أ) تجربة دفع الرسوم (Success)
    DBMS_OUTPUT.PUT_LINE('>>> 2.A: Paying Fees for Enrollment ID: ' || v_enroll_id);
    PKG_ENROLLMENT_UPD.PAY_FEES(v_enroll_id);
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Fees paid.');

    -- ب) تجربة الدفع مرة ثانية (Already Paid Error)
    DBMS_OUTPUT.PUT_LINE('>>> 2.B: Attempting to pay again (Should Fail)...');
    PKG_ENROLLMENT_UPD.PAY_FEES(v_enroll_id);

EXCEPTION
    -- لازم يصيد الخطأ الخاص (-20001 مثلاً)
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('PASS: Expected Error Caught -> ' || SQLERRM);
END;
/

DECLARE
    v_enroll_id NUMBER;
BEGIN
    SELECT MAX(enroll_id) INTO v_enroll_id FROM ENROLLMENTS WHERE student_id = 990;

    -- ج) تحديث علامة (Valid Mark)
    DBMS_OUTPUT.PUT_LINE('>>> 2.C: Updating Mark to 85 (Success)...');
    PKG_ENROLLMENT_UPD.UPDATE_MARK(v_enroll_id, 85);
    DBMS_OUTPUT.PUT_LINE('SUCCESS: Mark updated.');

    -- د) تحديث علامة خاطئة (Invalid Mark)
    DBMS_OUTPUT.PUT_LINE('>>> 2.D: Updating Mark to 150 (Should Fail)...');
    PKG_ENROLLMENT_UPD.UPDATE_MARK(v_enroll_id, 150);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('PASS: Expected Error Caught -> ' || SQLERRM);
END;
/

-- ==========================================
-- 4. TEST DELIVERABLE 3: REPORT Package
-- ==========================================

-- أ) تقرير طالب عنده مواد (Student 990)
BEGIN
    PKG_ENROLLMENT_RPT.PRINT_STUDENT_REPORT(990);
END;
/


-- ب) تقرير طالب ما عنده مواد (Student 991)
BEGIN
    PKG_ENROLLMENT_RPT.PRINT_STUDENT_REPORT(991);
END;
/

-- ج) تقرير طالب مش موجود أصلاً
BEGIN
    PKG_ENROLLMENT_RPT.PRINT_STUDENT_REPORT(9999);
END;
/