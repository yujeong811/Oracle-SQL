2022-0107-01)
 3. DELETE ��
  - ���̺��� �ڷḦ �����Ҷ� ���
  - ROLLBACK�� ���
  (�������)
   DELETE FROM ���̺��
     [WHERE ����];
     * WHERE ���� �����Ǹ� ��� �ڷḦ ����
     
��뿹)���̺� GOODS�� ��� �ڷḦ ����
  DELETE FROM GOODS;
  
  COMMIT;
  
��뿹)���̺� GOODS�� �ڷ� �� ��ǰ�ڵ尡 'P102'���� ū �ڷḦ ����
  DELETE FROM GOODS
   WHERE GOOD_ID >= 'P102';
   
  SELECT * FROM GOODS;
   
   
   