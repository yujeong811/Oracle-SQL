2022-0203-01)
2.WHILE �� 
 - ���߾���� WHILE���� ���� ���� �� ��� ���� 
 
 (�������)
 WHILE ���ǹ� LOOP
    �ݺ�ó����ɹ�(��);
    
    END LOOP; 
    .���ǹ��� �Ǵ� ����� ���̸� �ݺ�����, �����̸� �ݺ����� 
     ��� 
-- ��κ��� �ݺ����� Ŀ������ �Բ� ���. 
��뿹) �������� 6���� WHILE������ �����Ͻÿ�. 

    DECLARE 
        V_CNT NUMBER := 1;
        V_RES VARCHAR2(100);
    BEGIN 
        WHILE V_CNT <10 LOOP
        V_RES:= '6 * ' || V_CNT|| '='||V_CNT*6;
        DBMS_OUTPUT.PUT_LINE(V_RES);
        V_CNT:= V_CNT+1;
        END LOOP;
    END; 
    
��뿹) 2005�⵵�� ��ٱ������̺��� �з��ڵ� 'P102'�� ����
       ��ǰ���� �������踦 ���Ͻÿ�(Ŀ���̿�) 
    Alias ��ǰ�ڵ�, ��ǰ��, ����, �ݾ� 
    
    ('P102'�� ���� ��ǰ�ڵ�)
    
    SELECT PROD_ID
    FROM PROD
    WHERE PROD_LGU='P102';
    
    DECLARE 
      V_PID PROD.PROD_ID%TYPE;
      V_PNAME PROD.PROD_NAME%TYPE;
      V_QTY NUMBER:=0; --�����հ�
      V_AMT NUMBER:=0; --�ݾ��հ�
      CURSOR CUR_CART01 IS SELECT PROD_ID
    FROM PROD
    WHERE PROD_LGU='P102';
    BEGIN
    OPEN CUR_CART01; 
    FETCH CUR_CART01 INTO V_PID;
    WHILE CUR_CART01%FOUND LOOP
    SELECT B.PROD_NAME, SUM(A.CART_QTY),SUM(A.CART_QTY*B.PROD_PRICE)
    INTO V_PNAME, V_QTY, V_AMT
    FROM CART A, PROD B
    WHERE B.PROD_ID = V_PID 
    AND A.CART_PROD = B.PROD_ID
    AND A.CART_NO LIKE '2005%'
    GROUP BY B.PROD_NAME;
    DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ�' || V_PID);
    DBMS_OUTPUT.PUT_LINE('��ǰ��' || V_PNAME);
    DBMS_OUTPUT.PUT_LINE('����' || V_QTY);
    DBMS_OUTPUT.PUT_LINE('�ݾ�' || V_AMT);
    DBMS_OUTPUT.PUT_LINE('------------------------');
    FETCH CUR_CART01 INTO V_PID;
    END LOOP;
    CLOSE CUR_CART01;
    END;

3. FOR �� 
 - ���߾���� FOR���� ���� ��� ���� 
 - �ݺ� Ƚ���� �߿��ϰų� �ݺ�Ƚ���� ��Ȯ�� �˰� �ִ� ��� ��� 
 (�������- �Ϲ� FOR��) 
    FOR �ε��� IN[REVERSE] �ʱⰪ.. ������
    LOOP
        �ݺ�ó�� ��ɹ�(��); 
        
    END LOOP; 
    . '�ε���' : ����� ����(�ý��ۿ��� �ڵ� ����) 
    . 'REVERSE' : �������� �ݺ��ϴ� ��� 
    . '�ʱⰪ.. ������' : �ʱⰪ���� ���������� 1�� �������� �ε����� �Ҵ� 
    
��뿹) �������� 6���� ��� 

    DECLARE 
    
    BEGIN
     FOR I IN 1..9 LOOP 
        DBMS_OUTPUT.PUT_LINE('6 * '||I||' = ' || 6*I);
     END LOOP;
    END;  

(�������- Ŀ�� FOR��) 
    FOR ���ڵ��  IN Ŀ���� | Ŀ���� 
    LOOP
        �ݺ�ó�� ��ɹ�(��); 
        
    END LOOP;     
    . CURSOR���� FOR���� �̿��Ͽ� ó���ϴ� ��� OPEN/FETCH/CLOSE�� ���� 
    . Ŀ�� ���𹮵� FOR�� �ȿ� IN-LINE ���������������� ��� ���� 
    . Ŀ������ �÷��� '���ڵ��.�÷���'���� ���� �Ѵ�. 
