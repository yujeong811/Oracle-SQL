2022-0110-02)�Լ�(FUNCTION)
 - ���� ���Ǵ� ����� �̸� �������Ͽ� ���� ������ ���·� ����� ���α׷�
 - ����Ŭ���� �����ϴ� �Լ��� ����ڰ� �ۼ��ϴ� �Լ��� �ִ�.
 - �Լ��� ��ø����� ����(���ܷ� �����Լ����� ��ø�� ������ ����)
 - ���ڿ��Լ�, �����Լ�, ��¥�Լ�, ����ȯ�Լ�, ��ó���Լ�, �����Լ� ���� ����
 1. ���ڿ��Լ�
  1)CONCAT(c1, c2) --�� �Ⱦ�
   * �־��� �� ���ڿ� c1, c2�� �����Ͽ� ���ο� ���ڿ� ��ȯ
   * ���ڿ� ���� ������ '||'�� ���� ���
   
��뿹)������̺��� FIRST_NAME�� LAST_NAME�� �����Ͽ� ����Ͻÿ�.
      SELECT EMPLOYEE_ID AS �����ȣ,
             FIRST_NAME AS �̸�1,
             LAST_NAME AS �̸�2,
             CONCAT(FIRST_NAME, LAST_NAME) AS "���յ� �̸�"  --FIRST NAME�� LAST NAME ���� ���� ����
        FROM HR.EMPLOYEES;
   
      SELECT EMPLOYEE_ID AS �����ȣ,
             FIRST_NAME AS �̸�1,
             LAST_NAME AS �̸�2,
             CONCAT(CONCAT(FIRST_NAME, ' '),LAST_NAME) AS "���յ� �̸�1",
             FIRST_NAME||' '||LAST_NAME AS "���յ� �̸�2"
        FROM HR.EMPLOYEES;
        
  2)LOWER(c1), UPPER(c1), INITCAB(c1)
   * LOWER(c1) : �־��� ���ڿ� c1�� ���Ե� ��� ���ڸ� �ҹ��ڷ� ��ȯ
   * UPPER(c1) : �־��� ���ڿ� c1�� ���Ե� ��� ���ڸ� �빮�ڷ� ��ȯ
   * INITCAB(c1) : �־��� ���ڿ� c1�� �ܾ� ���۱��ڸ� �빮�ڷ� ��ȯ
   
��뿹)��ǰ���̺��� �з��ڵ尡 'p102'�� ���� ��ǰ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰���, ���Ⱑ���̴�.
      SELECT PROD_ID AS ��ǰ�ڵ�,
             PROD_NAME AS ��ǰ��, 
             PROD_COST AS ���԰���,
             PROD_PRICE AS ���Ⱑ��
        FROM PROD
       WHERE LOWER(PROD_LGU) = 'p102';
       
 ** ������̺��� FIRST_NAME�� LAST_NAME�� ��� �ҹ��ڷ� �����Ͽ� �����Ͻÿ�   
    UPDATE HR.EMPLOYEES
       SET FIRST_NAME = LOWER(FIRST_NAME),
           LAST_NAME = LOWER(LAST_NAME);
           
    COMMIT;
   
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
      FROM HR.EMPLOYEES;
      
��뿹)������̺��� FIRST_NAME�� LAST_NAME�� �����ϵ� �߰��� ������ �����ϰ� �ܾ� ù���ڸ� �빮�ڷ� ��ȯ�Ͽ� ����Ͻÿ�.
      SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,
             INITCAP(FIRST_NAME||' '||LAST_NAME)
        FROM HR.EMPLOYEES;
        
        
        
        
        
        
        
   