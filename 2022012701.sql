2022-0127-01)�񱳹�
 - ����Ŭ�� �б⹮���� IF�� CASE WHEN ~ THEN�� ����
 - IF���� ���߾���� IF�� ���� ���
 - CASE WHEN ~ THEN�� ���߾���� ���� �б�� ���� ���
 1. IF ��
  - ���õ� ������ �Ǵ��Ͽ� ���� �ٸ� �������� ���� �̵�
  (������� - 1)
  IF ���ǽ� THEN 
     ���-1;
 [ELSE
     ���-2;]
  END IF;
  
  (������� - 2)
  IF ���ǽ�-1 THEN 
     ���-1;
  ELSIF ���ǽ�-2 THEN
     ���-2;
       :
  ELSE
     ���-n
  END IF;  
  
  (������� - 3)
  IF ���ǽ�-1 THEN 
     IF ���ǽ�-2 THEN 
        ���-1;
     ELSE
        ���-2;
     END IF;   
  ELSIF ���ǽ�-3 THEN
     ���-3;
       :
  ELSE
     ���-n
  END IF;   
  
 ��뿹)ù���� 100��, ��°������ ������ 2�辿 ������ �� ���ʷ� 100������ �Ѵ� ���� �׶����� ����� �ݾ��� ���Ͻÿ�.
       DECLARE
         V_DAYS NUMBER:=1; --����
         V_SUM NUMBER:=0;  --������ �ݾ� �հ�(������)
         V_AMT NUMBER:=100; --������ �ݾ�
       BEGIN
         LOOP
           V_SUM:=V_SUM+V_AMT;
           EXIT WHEN V_SUM >= 1000000;
           V_AMT:=V_AMT*2;
           V_DAYS:=V_DAYS+1;
         END LOOP;
         DBMS_OUTPUT.PUT_LINE('����ϼ� : '||V_DAYS);
         DBMS_OUTPUT.PUT_LINE('����ݾ� : '||V_SUM);         
       END;
  
 ��뿹)ȸ�����̺��� ȸ������ ���ϸ����� ��ȸ�Ͽ� ���ϸ����� 0-1000 �̸� '�Ϲ�ȸ��', 1001-2000 �̸� '����ȸ��', 2001 �̻��̸� 'VIPȸ��'��
       ����ϴ� ���ν����� �ۼ��Ͻÿ�. Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ���
       DECLARE
         V_MID MEMBER.MEM_ID%TYPE;
         V_MNAME MEMBER.MEM_NAME%TYPE;
         V_MILE NUMBER:=0;
         V_REMARKS VARCHAR2(50);
         CURSOR CUR_MEM01  --�ڹ� -> �迭, ����Ŭ -> Ŀ��
         IS
           SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
           FROM MEMBER;           
       BEGIN
         OPEN CUR_MEM01;
         DBMS_OUTPUT.PUT_LINE('ȸ����ȣ  ȸ����  ���ϸ���    ���');
         DBMS_OUTPUT.PUT_LINE('---------------------------------');   
         
         LOOP
           FETCH CUR_MEM01 INTO V_MID,V_MNAME,V_MILE; 
           EXIT WHEN CUR_MEM01%NOTFOUND;
           IF V_MILE <=1000 THEN
              V_REMARKS:='�Ϲ�ȸ��';
           ELSIF V_MILE <=2000 THEN
              V_REMARKS:='����ȸ��';
           ELSE
              V_REMARKS:='VIPȸ��';
           END IF;   
           DBMS_OUTPUT.PUT_LINE(V_MID||'    '||V_MNAME||'    '||V_MILE||'    '||V_REMARKS);  
           DBMS_OUTPUT.PUT_LINE('---------------------------------');                   
         END LOOP;
         DBMS_OUTPUT.PUT_LINE('��üȸ����: '||CUR_MEM01%ROWCOUNT);
         CLOSE CUR_MEM01;
       END;
       
       ROLLBACK;
       
  
  
  
  
  
  
  