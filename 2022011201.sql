2022-0112-01)��¥�Լ�
 1)SYSDATE
  - �ý��ۿ��� �����ϴ� ��¥����(��,��,��,��,��,��) ��ȯ
  - ����(�巡�� �����ҳ�¥)�� ����(������ ��¥) ����
  - �ð�����(��,��,��)����� TO_CHAR �Լ� ���

 ��뿹)
   SELECT SYSDATE, SYSDATE - 20, SYSDATE + 20
     FROM DUAL;
     
   SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
          TO_CHAR(SYSDATE - 20, 'YYYY-MM-DD HH24:MI:SS'),
          TO_CHAR(SYSDATE + 20, 'YYYY-MM-DD HH24:MI:SS')
     FROM DUAL;     
     
 2)ADD_MONTHS(d1, n)
  - �־��� ��¥ d1�� n������ ���� ��¥ ��ȯ
  
 ��뿹)  
   SELECT ADD_MONTHS(SYSDATE,4) FROM DUAL;
   
   SELECT EMP_NAME AS �����,
          HIRE_DATE AS �Ի���,
          ADD_MONTHS(HIRE_DATE,3) AS �Ի���
     FROM HR.EMPLOYEES;
     
 3)NEXT_DAY(d1, c)
  - d1 �������� ���� ���� ������ c������ ��¥ ��ȯ
  - c�� ������ ��Ī�ϸ� '�Ͽ���', '��', '������', '��' ������ ���
  
 ��뿹) 
   SELECT NEXT_DAY(SYSDATE, '��'),
          NEXT_DAY(SYSDATE,'������')
     FROM DUAL;

 4)LAST_DAY(d1)
  - ���õ� ��¥ d1�� ���Ե� ���� ���������ڸ� ��ȯ
  - �ַ� 2���� ���������� ��ȯ ���� �� ���
  
 ��뿹)�������̺�(BUYPROD)���� 2005�� 2�� ���ں� �������踦 ��ȸ�Ͻÿ�
       Alias�� ����, �����հ�, �Ǹűݾ��հ�
       SELECT BUY_DATE AS ����,
              SUM(BUY_QTY) AS �����հ�,
              SUM(BUY_QTY * BUY_COST) AS ���Աݾ��հ�
         FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
        GROUP BY BUY_DATE
        ORDER BY 1;
     
 5)EXTRACT(fmt FROM d1)
  - ���õ� ��¥�ڷ� d1���� 'fmt'�� �ش��ϴ� ��Ҹ� �����Ͽ� ��ȯ
  - ��ȯ�Ǵ� ������ Ÿ���� ����
  - 'fmt(Format String : ���Ĺ��ڿ�)'�� YEAR, MONTH, DAY, HOUR, MINUTE, SECOND �� �ϳ��̾�� ��
 
 ��뿹)ȸ�����̺��� ������ ���ϰ� �� ���ɴ뺰 ȸ������ ��ȸ�Ͻÿ�
       Alias�� ���ɴ�, ȸ����
       SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)||'��' AS ���ɴ�, 
              COUNT(*) AS ȸ����
         FROM MEMBER
        GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)
        ORDER BY 1;
   
 ��뿹)������̺��� �Ի���� �̹����� ������� ��ȸ�Ͻÿ�.
       Alias�� �����ȣ, �����, �μ��ڵ�, �Ի���
       SELECT EMPLOYEE_ID AS �����ȣ,
              EMP_NAME AS �����,
              DEPARTMENT_ID AS �μ��ڵ�,
              HIRE_DATE AS �Ի���
         FROM HR.EMPLOYEES
        WHERE EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM HIRE_DATE)
        ORDER BY 4;
        
 6)MONTHS_BETWEEN(d1, d2)
  - ���õ� �� ��¥�ڷ� ������ ������ ��ȯ
  
 ��뿹)1998�� 3�� 10�Ͽ� �¾ ����� ��Ȯ�� ���̴�?
       SELECT TRUNC(ROUND(MONTHS_BETWEEN(SYSDATE, TO_DATE('19980310')))/12)||'��'||
              MOD(ROUND(MONTHS_BETWEEN(SYSDATE, TO_DATE('19980310'))),12)||'����'
         FROM DUAL;
 
 
 
 