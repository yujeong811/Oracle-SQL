2022-0117-02)ROLLUP�� CUBE
 - GROUP BY ������ ���Ǿ� �پ��� ���踦 ����
 1)ROLLUP
   * �׷쳻�� ���踦 ����� �÷����� �������� �����Ͽ� ������ ����� ��ü ���踦 ��ȯ
   * �ݵ�� GROUP BY �������� ����ؾ� ��
   (�������)
    GROUP BY ROLLUP(�÷���1[,�÷���2,...�÷���n])[,�÷���,..]
     - ROLLUP( )�ȿ� ����� �÷���n���� �÷���1���� ������ �ο��Ͽ� �� ������ ����� ��ü�����ȯ
     - ROLLUP( )�ȿ� ����� �÷��� ���� n���̸� ��ü ������ ������ n+1����
     - �÷���1[,�÷���2,...�÷���n ��θ� �������� ���踦 ��ȯ�� �� �÷���1[,�÷���2�� �������� ���� ��ȯ, ��ü�����ȯ
     
 ��뿹)2005�� 4~7�� ������ �Ǹ��ڷḦ �������  ����, ȸ����, ��ǰ�� �Ǹ����踦 ���Ͻÿ�.
       Alias�� ��, ȸ����ȣ , ��ǰ��ȣ, �Ǹż�������
    (GROUP BY ���� ���)
       SELECT SUBSTR(CART_NO,5,2) AS ��,
              CART_MEMBER AS ȸ����ȣ,
              CART_PROD AS ��ǰ��ȣ,
              SUM(CART_QTY) AS �Ǹż�������
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD
        ORDER BY 1;
-------------------------------------------------------------------------      
    (ROLLUP ���� ���)
       SELECT SUBSTR(CART_NO,5,2) AS ��,
              CART_MEMBER AS ȸ����ȣ,
              CART_PROD AS ��ǰ��ȣ,
              SUM(CART_QTY) AS �Ǹż�������
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER, CART_PROD)
        ORDER BY 1;
        
 **�κ� ROLLUP
  - GROUP BY���� ���� �÷� �� �Ϻθ� ROLLUP�� ����� �Ǵ� ���
  ex)GROUP BY A1,ROLLUP(B1,B2,B3) �� ����� ���
     * A1,B1,B2,B3 �÷��� �������� �հ� ��ȯ
     * A1,B1,B2 �÷��� �������� �հ� ��ȯ
     * A1,B1 �÷��� �������� �հ� ��ȯ
     * A1 �÷��� �������� �հ� ��ȯ
     
 ��뿹) 
       SELECT SUBSTR(CART_NO,5,2) AS ��,
              CART_MEMBER AS ȸ����ȣ,
              CART_PROD AS ��ǰ��ȣ,
              SUM(CART_QTY) AS �Ǹż�������
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY SUBSTR(CART_NO,5,2),ROLLUP(CART_MEMBER,CART_PROD)
        ORDER BY 1;        
        
       SELECT SUBSTR(CART_NO,5,2) AS ��,      --��ǰ�� ����
              CART_MEMBER AS ȸ����ȣ,
              CART_PROD AS ��ǰ��ȣ,
              SUM(CART_QTY) AS �Ǹż�������
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY ROLLUP(SUBSTR(CART_NO,5,2),CART_MEMBER),CART_PROD
        ORDER BY 1;           
        
 2)CUBE
   * �׷쳻�� ���踦 ����� �÷����� ���� ������ ����� ������ ��ŭ ���� ��ȯ
   * �ݵ�� GROUP BY �������� ����ؾ� ��
   (�������)
    GROUP BY CUBE(�÷���1[,�÷���2,...�÷���n])[,�÷���,..]
     - CUBE�ȿ� ���� �÷��� ���� n���̸� 2�� n�� ������ŭ ������ ������ ��ȯ
     ex)GROUP BY CUBE(A1,B1,C1)
      => A1,B1,C1�� �������� �ϴ� ����
         A1,B1�� �������� �ϴ� ����
         A1,C1�� �������� �ϴ� ����
         B1,C1�� �������� �ϴ� ����        
         A1�� �������� �ϴ� ����
         B1�� �������� �ϴ� ����
         C1�� �������� �ϴ� ����
         ��ü ����
         
 ��뿹)
       SELECT SUBSTR(CART_NO,5,2) AS ��,    
              CART_MEMBER AS ȸ����ȣ,
              CART_PROD AS ��ǰ��ȣ,
              SUM(CART_QTY) AS �Ǹż�������
         FROM CART
        WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200507'
        GROUP BY CUBE(SUBSTR(CART_NO,5,2),CART_MEMBER,CART_PROD)
        ORDER BY 1;    
         
     
        
        
      