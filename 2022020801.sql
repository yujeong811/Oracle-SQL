2022-0208-01)Ʈ����
 ** HR ������ ������̺� �������� �÷��� �߰��Ͻÿ�.
    ALTER TABLE EMPLOYEES ADD(RETIRE_DATE DATE);
    
 ** HR ������ ������ ���̺��� �����Ͻÿ�.
    ���̺�� : RETIRES
    �÷���       ������Ÿ��       NULLABLE       PK/FK
 -------------------------------------------------------
  EMPLOYEE_ID   NUMBER(6)       N.N          PK & FK
  RETIRE_DATE   DATE
  JOB_ID        VARCHAR2(10)                 FK
  DEPARTMENT_ID NUMBER(4)                    FK
 -------------------------------------------------------
    CREATE TABLE RETIRES(
      EMPLOYEE_ID   NUMBER(6),
      RETIRE_DATE   DATE,
      JOB_ID        VARCHAR2(10),
      DEPARTMENT_ID NUMBER(4),
      CONSTRAINT pk_retires PRIMARY KEY(EMPLOYEE_ID),
      CONSTRAINT fk_ret_emp FOREIGN KEY(EMPLOYEE_ID)
        REFERENCES EMPLOYEES(EMPLOYEE_ID),
      CONSTRAINT fk_ret_jobs FOREIGN KEY(JOB_ID)
        REFERENCES JOBS(JOB_ID),
      CONSTRAINT fk_ret_dept FOREIGN KEY(DEPARTMENT_ID)
        REFERENCES DEPARTMENTS(DEPARTMENT_ID)); 
      
      
        
 ��뿹) ������̺��� 2002�� ������ �Ի��� ������� ���� ó���Ϸ��Ѵ�.
        �����ڴ� ������̺� �������ڿ� ���� ��¥�� �����ϱ� �� ���������̺� ������ �Է��ؾ��Ѵ�.
        --������̺� �����ڷḦ ������Ʈ �ϱ� �� ������ ���̺�� �̵� 
        --Ʈ���Ŵ� BEFORE, �̺�Ʈ�� EMP ���̺� UPDATE, RETIRES ���̺� �ڷ� �Է�
    CREATE TRIGGER tg_retires
     BEFORE  UPDATE ON EMPLOYEES 
     FOR EACH ROW --UPDATE �� �� �ึ�� Ʈ���� ���� (�� 8�� INSERT ��� ����)
     --DECLARE > ������ ������� ���� ��� �ݾ���
     
     BEGIN
      INSERT INTO RETIRES
      --�� ���� �÷� �ϳ��� ��Ī�� �� :OLD.������
        VALUES(:OLD.EMPLOYEE_ID,SYSDATE,:OLD.JOB_ID,:OLD.DEPARTMENT_ID);
     END;
     
     
     UPDATE EMPLOYEES
        SET RETIRE_DATE = SYSDATE
      WHERE HIRE_DATE <= TO_DATE('20021231');  --8���� �ڷᰡ �Űܿ�
      