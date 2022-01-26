2022-0126-02)PL/SQL(Procedural Language SQL)
 - 표준 SQL에 절차적 언어의 특징이 추가
 - block 구조로 구성됨
 - DBMS에 미리 컴파일되어 저장되므로 빠른 실행과 네트워크를 효율적으로 이용하여 전체 SQL실행 효율을 증대
 - 변수, 상수, 반복처리, 비교판단, 에러처리 가능
 - 표준 문법이 없음
 - User Defined Function, Stored Procedure, Trigger, Package, Anonymous block 등이 제공 --익명블록
 
 1. Anonymous Block(익명블록)
  - PL/SQL의 기본 구조
  - 재사용할 수 없음
  (사용형식)
    DECLARE
      선언부-변수, 상수, 커서 선언;
    BEGIN
      실행부-문제해결을 위한 비지니스 로직처리 SQL문;
      
     [EXCEPTION
       예외처리부;]
    END;
    
 사용예) 1부터 100사이의 짝수의 합과 홀수의 합을 구하시오
   DECLARE
     V_CNT NUMBER:=1;  --(:=) 할당연산자
     V_ESUM NUMBER:=0; -- 짝수
     V_OSUM NUMBER:=0; -- 홀수
   BEGIN  
     LOOP  -- 반복문의 기본 구조
       IF MOD(V_CNT,2)=0 THEN 
         V_ESUM:=V_ESUM+V_CNT;
       ELSE
         V_OSUM:=V_OSUM+V_CNT;
   END IF;
   EXIT WHEN V_CNT>=100;  -- 조건이 참이면 루프 탈출
   V_CNT:=V_CNT+1;
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('짝수의 합 : '||V_ESUM); --DBMS_OUTPUT.PUT_LINE : 출력 명령
 DBMS_OUTPUT.PUT_LINE('홀수의 합 : '||V_OSUM); 
 
 END;
   
   
   
   
   
   
   
   
   