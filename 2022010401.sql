2022-0104-01)사용자 생성
 . CREATE USER - 사용자 생성
 . GRANT - 권한 부여

1) 사용자 생성
 CREATE USER 유저명 IDENTIFIED BY 암호;
 CREATE USER LYJ98 IDENTIFIED BY java;

2) 권한 부여
 GRANT 권한명1[,권한명2,...] TO 유저명;
 GRANT CONNECT, RESOURCE, DBA TO LYJ98;
 
 
 