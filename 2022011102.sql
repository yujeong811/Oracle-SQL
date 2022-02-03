2022-0111-02)�����Լ�
 1)������ �Լ�
  - ABS, SIGN, SQRT, POWER ���� ����
  - ABS(n1) : n1�� ���밪
  - SIGN(n1) : n1�� ��ȣ�� ���� ����̸� 1, �����̸� -1, 0�̸� 0�� ��ȯ
  - SQRT(n1) : n1�� ���� �� ��ȯ --��Ʈ��
  - POWER(n1,n2) : n1�� n2�� �� 
  
��뿹)
  SELECT ABS(100), ABS(-100),
         SIGN(-9000), SIGN(-0.0009), SIGN(100000), SIGN(0.000001), SIGN(0),
         SQRT(10), SQRT(81),
         POWER(2,10), POWER(2,32)
    FROM DUAL;
    
 2)GREATEST(n1[,n2,...]), LEAST(n1[,n2,...])
   - GREATEST(n1[,n2,...]) : ���õ� n1[,n2,...]���� ���� ū ���� ��ȯ
   - LEAST(n1[,n2,...]) : ���õ� n1[,n2,...]���� ���� ���� ���� ��ȯ

 ��뿹) 
   SELECT GREATEST(100,500,20),
          GREATEST('ȫ�浿','ȫ���','������')  --ù���ں��� �� ȫ > �� / �� < ��
     FROM DUAL;
     
 ��뿹)ȸ�����̺��� ���ϸ����� 1000������ ȸ���� ���ϸ����� 1000���� �ٲپ� ��ȸ�Ͻÿ�
       Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ����̴�.
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����, 
              MEM_JOB AS ����, 
              MEM_MILEAGE AS �������ϸ���,
              GREATEST(MEM_MILEAGE, 1000) AS ���ϸ���
         FROM MEMBER;
      
       SELECT MAX(MEM_MILEAGE),
              MIN(MEM_MILEAGE)
         FROM MEMBER;
   
 3)ROUND(n1,1), TRUNC(n1,1)
  - ROUND(n1,1) : ���õ� �� n1���� �Ҽ������� 1+1��° �ڸ����� �ݿø��Ͽ� 1�ڸ����� ��ȯ
  - TRUNC(n1,1) : ���õ� �� n1���� �Ҽ������� 1+1��° �ڸ����� �����Ͽ� 1�ڸ����� ��ȯ
  - 1�� �����Ǹ� 0���� ����
  - 1�� �����̸� ����(�Ҽ����̻�)�κ��� 1��° �ڸ����� �ݿø�(ROUND) �Ǵ� ����(TRUNC)
   
 4)FLOOR(n1), CEIL(n1)
   - FLOOR(n1) : n1�� ���ų� ������ �� ���� ū ����
   - CEIL(n1) : n1�� ���ų� ū�� �� ���� ���� ���� => �Ҽ��� ������ ���� �����ϸ� ������ �ݿø��� �� ��ȯ 
   - �޿�, ���� �� �ݾ׿� ���õ� �׸� �ַ� ���
   
��뿹)
  SELECT FLOOR(12.987), FLOOR(12), FLOOR(-12.987), FLOOR(-12),
         CEIL(12.987), CEIL(12), CEIL(-12.987), CEIL(-12)
    FROM DUAL;
    
 5)MOD(n1, e), REMAINDER(n1, e)
   - MOD(n1, e) : n1�� e�� ���� ������ ��ȯ
   - REMAINDER(n1, e) : n1�� e�� ���� ���� �Ҽ������ϰ� 0.5���� ũ��(�������� e�� �߰������� ũ��) ���� ���� �Ǳ����� �� ��ȯ
   - ������ ó�� ����� ����
   - MOD : ������ = n1 - e * FLOOR(n1 / e)
   - REMAINDER : ������ = n1 - e * ROUND(n1 / e)
   
  ex) MOD(15, 4)
      15 - 4 * FLOOR(15 / 4)
      15 - 4 * FLOOR(3.75)
      15 - 4 * 3
      15 - 12 = 3
      
      REMAINDER(15, 4)
      15 - 4 * ROUND(15 / 4)
      15 - 4 * ROUND(3.75)
      15 - 4 * 4
      15 - 16 = -1      
      
  ex) MOD(13, 4)
      13 - 4 * FLOOR(13 / 4)
      13 - 4 * FLOOR(3.25)
      13 - 4 * 3
      13 - 12 = 1
      
      REMAINDER(13, 4)
      13 - 4 * ROUND(13 / 4)
      13 - 4 * ROUND(3.25)
      13 - 4 * 3
      13 - 12 = 1     
   
 ��뿹)
   SELECT CASE MOD((TRUNC(SYSDATE) - TO_DATE('00010101')-1),7)
               WHEN 0 THEN '�Ͽ���'
               WHEN 1 THEN '������'
               WHEN 2 THEN 'ȭ����'
               WHEN 3 THEN '������'
               WHEN 4 THEN '�����'
               WHEN 5 THEN '�ݿ���'
               ELSE '�����'
          END AS ����
     FROM DUAL;
     
 5)WIDTH_BUCKET(val,min,max,b) --���� ���� ������ ���Ե�����, ���� ���� ������ ���Ե��� ����   
   - ���� �� min���� ���� �� max�� b���� �������� ���������� ���õ� �� val�� ��� ������ ���ϴ����� �Ǵ��Ͽ� ������ index�� ��ȯ
   
 ��뿹)ȸ�����̺� �� ȸ������ ���ϸ����� �Է¹޾� ���ϸ��� 1000~9000 ���̸� 9�� �������� �����Ҷ� �� ���� ��������� ���ϴ��� �Ǻ��Ͻÿ�.
       Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ������
       SELECT MEM_ID AS ȸ����ȣ, 
              MEM_NAME AS ȸ����, 
              MEM_MILEAGE AS ���ϸ���, 
              WIDTH_BUCKET(MEM_MILEAGE,1000,9000,9) AS ������ 
         FROM MEMBER;
   
 ��뿹)ȸ�����̺� �� ȸ������ ���ϸ����� �Է¹޾� ���ϸ��� 1000~9000 ���̸� 9�� �������� �����Ҷ� �� ���� ��������� ���ϴ��� �Ǻ��Ͽ�
       ����� ��Ÿ���ÿ�. ��, ���� ���ϸ����� ������ �ִ� ȸ���� 1�����
       Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ���   
       SELECT MEM_ID AS ȸ����ȣ, 
              MEM_NAME AS ȸ����, 
              MEM_MILEAGE AS ���ϸ���, 
              WIDTH_BUCKET(MEM_MILEAGE,9000,1000,9) AS ��� 
           -- 10 - WIDTH_BUCKET(MEM_MILEAGE,1000,9000,9) AS ��� 
         FROM MEMBER;   
   
 ��뿹)������̺��� ������� �޿��� 2000-5000 ���̿� ���ϸ� '���ӱ� ���', 5001-10000 ���̿� ���ϸ� '����ӱ� ���',
       10001-25000 ���̿� ���ϸ� '���ӱ� ���'�� ����� ����Ͻÿ�
       Alias�� �����ȣ, �����, �μ��ڵ�, �����ڵ�, �޿�
       SELECT EMPLOYEE_ID AS �����ȣ, 
              FIRST_NAME||' '||LAST_NAME AS �����,
              DEPARTMENT_ID AS �μ��ڵ�,
              JOB_ID AS �����ڵ�,
              SALARY AS �޿�,
              CASE WIDTH_BUCKET(SALARY,1,25000,5)
                   WHEN 1 THEN '���ӱ� ���'
                   WHEN 2 THEN '����ӱ� ���'
                   ELSE '���ӱ� ���'
              END AS ���      
         FROM HR.EMPLOYEES;
  