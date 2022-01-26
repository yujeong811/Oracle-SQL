2022-0126-01)
 1. SYNONYM(���Ǿ�)
 - ����Ŭ ��ü�� �ο��ϴ� ��Ī
 - �� �̸��� ��ü�� �ٸ� ��� ������ ��ü�� �����Ҷ� �ַ� ���
 - ���̺� ��Ī, �÷� ��Ī���� �������� QUERY�� ������� ��� ����
 (�������)
   CREATE [OR REPLACE] SYNONYM ���Ǿ�
     FOR ��ü��;
     
 ��뿹)
   CREATE OR REPLACE SYNONYM EMP
     FOR HR.EMPLOYEES;
   
   CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;
   
   SELECT * FROM EMP;  
   
   SELECT * FROM DEPT;
   
   CREATE OR REPLACE SYNONYM MYDUAL FOR SYS.DUAL;
   
   SELECT SYSDATE FROM MYDUAL;
   
 2. INDEX
 - ������ �˻�ȿ���� �����Ű�� ���� ����
 - WHERE �������� ���Ǵ� �÷�, ����(ORDER BY), �׷�ȭ(GROUP BY)�� ���� �÷��� ����Ͽ� ó�� ȿ���� ����
 - �ε����� ���� ������ �������� �ҿ�ǰ�, �ý����� �ڿ��� �Һ��
 - �������� ������ ���� ��� �ε��� ������ ���ſ� ���� �ð��� �ڿ��� �䱸��
 - �ε����� ����
  * Unique/Non-Unique : �ε����� �ߺ����� ����ϴ��� ���ο� ���� �з� 'Unique'�ε����� null���� ����ϳ� �ϳ��� null�� ����
  * Single/Composite : �ε��� ���� �÷��� 1���� ���(Single), 2�� �̻��� �÷����� ����(Composite)�� ���
  * Normal Index : Default �ε����� �÷����� rowid(������ ��ġ����)�� ������� �ּҰ� ���Ǹ� Ʈ������ �̿�
  * Bitmap Index : �÷����� rowid(������ ��ġ����)�� 2������ �����Ͽ� �ּҰ���ϸ�, Cardinality�� ���� ��� ȿ������ ���
  * Function-Based Normal Index : �ε��� �����÷��� �Լ��� ����� ���� �� �ε����� �̿��Ͽ� �ڷḦ �˻��ϴ� ���
                                  �ε��� ������ ���� �Լ��� ����ϴ� ���� ���� ȿ����

 (�������)
   CREATE [UNIQUE|BITMAP] INDEX �ε�����
     ON ���̺��(�÷���[,�÷���,...])[ASC|DESC];
    * 'ASC|DESC' : �ε��� ������ ���� ���(�⺻�� ASC)
    
 ��뿹)��ǰ������ �ε����� �����Ͻÿ�
   CREATE INDEX idx_prod_name
     ON PROD(PROD_NAME);
 
   DROP INDEX idx_prod_name;
 
   SELECT * FROM PROD
    WHERE PROD_NAME = '��� VTR 6���';
    
 ��뿹)������̺��� 'TJ Olson'��� ������ ��ȸ�Ͻÿ�.
   SELECT *
     FROM EMP
    WHERE EMP_NAME = 'TJ Olson';
    
   CREATE INDEX idx_prod_name   --�ڷᰡ ���ƾ� �ε��� ȿ���� �� �� ����
     ON EMP(EMP_NAME);

 **�ε��� �籸��
  - �ڷ��� ����/������ �뷮 �߻��� ���
  - ���̺��� ���� ��ġ(TABLE SPACE)�� ����� ���
   (�������)
   ALTER INDEX �ε����� REBUILD;  --���ο� ��ġ������ �ε����� �����ؾ� �� �ʿ䰡 ���� ��� ���
  
   ALTER INDEX idx_prod_name REBUILD;
