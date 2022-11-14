
-- 사용자 테이블 만들기
create table users(
id varchar2(28) primary key,
password varchar2(8) not null,
name varchar2(30) not null,
role varchar2(5) default 'User'
)

delete from users

-- 사용자 테이블 삭제
drop table users

-- 사용자 추가
insert into users values('hong','hong123','홍길동','Admin');
insert into users values('abc','abc123','임꺽정','User');
insert into users values('guest','guest123','일지매','Guest');
insert into users values('root','root1234','관리자','Admin')

-- 사용자 조회
select * from users
select * from users where id='hong' and password='hong1234'

-- 게시판 테이블 생성
create table board(
seq number(5) primary key,   -- 순번
title varchar2(200) not null,-- 제목
nickname varchar2(30) not null, -- 이름
content varchar2(2000) not null, -- 내용
regdate date default sysdate, -- 게시일 (생략시 오늘날짜 입력)
cnt number(5) default 0, -- 조회수
userid varchar2(8)
)

-- 공감,비공감 테이블 만들기
create table boardlike(
id varchar2(28) not null,
seq number(5) not null,
good number(5),
bad number(5),
isCheckCode varchar(10) default 'G0B0',  
-- 공감,비공감을 눌렀는지 여부 체크 코드 삽입.(차후에 해당 눌렀는지 여부가 저장이 되어야 하기 때문)
primary key(id,seq)
)

-- 공감,비공감 테이블 삭제
drop table boardlike

-- 공감,비공감 레코드 삭제
delete from boardlike

-- 샘플 데이터 추가 공감을 누른 경우
-- hong이 1번 게시글에 공감을 누른 경우와 비공감을 누른 경우
-- 처음 boardlike테이블이 만들어질 때는 good과 bad가 둘 다 0인 경우는 없다.
insert into boardlike(id,seq,good,bad,isCheckCode) values('hong',1,1,0,'G1B0');
insert into boardlike(id,seq,good,bad,isCheckCode) values('kim',1,1,0,'G1B0');
insert into boardlike(id,seq,good,bad,isCheckCode) values('park',2,1,0,'G1B0');
insert into boardlike(id,seq,good,bad,isCheckCode) values('oh',1,1,0,'G1B0');
insert into boardlike(id,seq,good,bad,isCheckCode) values('bang',3,1,0,'G1B0');
insert into boardlike(id,seq,good,bad,isCheckCode) values('hong',2,1,0,'G1B0')

-- 같은 id를 가진 사람이 같은 게시글에 good과 bad를 설정할 수 없다. 기본키 제약조건에 레코드 삽입 불가.
insert into boardlike(id,seq,good,bad) values('hong',1,0,1,'G0B1')

-- 공감,비공감 증가 확인
select * from boardlike

-- 공감 비호감 눌렀는지 여부 확인 SQL
select isCheckCode from boardlike where id='hong' and seq=1

select * from board
delete from board

-- 공감 누를 경우..(id가 hong인 사람이 1번 게시글에 공감 누른 경우)
update boardlike set good=1,bad=0 where seq=1 and id='hong'

-- 공감 누를 경우..(id가 kim인 사람이 1번 게시글에 공감 누른 경우)
update boardlike set good=1,bad=0 where seq=1 and id='kim'

-- 비공감 누를 경우....(id가 hong인 사람이 2번 게시글에 비공감 누른 경우)
update boardlike set bad=1,good=0 where seq=2 and id='hong'

-- 특정 게시글에 대한 공감의 개수 구하기 (1번 게시글의 공감 개수 구하기)
select sum(good) as goodcnt from boardlike where seq=1

-- 특정 게시글에 대한 비공감의 개수 구하기 (2번 게시글의 비공감 개수 구하기)
select sum(bad) as badcnt from boardlike where seq=2

-- id가 'hong'이 3번 게시글에 공감 비공감을 체크하지 않은 경우 
-- 아래의 SQL은 값이 나오지 않는다. 이 조건을 이용해 해당 게시글에 대한 공감 비공감
-- 체크 여부를 판정한다.
select * from boardlike where id='hong' and seq=3
select * from boardlike where id='hong' and seq=1

-- 위의 체크 여부를 판정하였다면 공감이냐 비공감이냐 체크의 SQL도 일단 만들어 보자.
-- good이 1이면 공감 체크,bad1이면 비공감 체크
select good from boardlike where id='hong' and seq=1
select bad from boardlike where id='hong' and seq=1


-- 게시판 내용 레코드 삽입
insert into board(seq,title,nickname,content,regdate,userid)
values(1,'첫 번째 게시물','홍길동','첫 번째 게시물 내용.','2022-08-24','hong');
insert into board(seq,title,nickname,content,regdate,userid)
values(2,'두 번째 게시물','홍길동','두 번째 게시물 내용.','2022-08-25','hong');
insert into board(seq,title,nickname,content,regdate,userid)
values(3,'세 번째 게시물','홍길동','세 번째 게시물 내용.','2022-08-25','hong');
insert into board(seq,title,nickname,content,regdate,userid)
values(4,'네 번째 게시물','홍길동','네 번째 게시물 내용.','2022-08-25','hong');
insert into board(seq,title,nickname,content,regdate,userid)
values(5,'다섯 번째 게시물','일지매','다섯 번째 게시물 내용.','2022-08-25','guest');
insert into board(seq,title,nickname,content,regdate,userid)
values(6,'여섯 번째 게시물','일지매','여섯 번째 게시물 내용.','2022-08-25','guest');



-- 게시판 내용 조회(최근 내용부터 검색)
select * from board order by seq desc

-- 페이징 테스트를 위해 다수의 레코드를 삽입
insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'1 번째 게시물','일지매','1 번째 게시물 내용.','2022-02-01','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'2 번째 게시물','일지매','2 번째 게시물 내용.','2022-02-02','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'3 번째 게시물','일지매','3 번째 게시물 내용.','2022-02-03','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'4 번째 게시물','일지매','4 번째 게시물 내용.','2022-02-04','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'5 번째 게시물','일지매','5 번째 게시물 내용.','2022-02-05','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'6 번째 게시물','일지매','6 번째 게시물 내용.','2022-02-06','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'7 번째 게시물','일지매','7 번째 게시물 내용.','2022-02-07','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'8 번째 게시물','일지매','8 번째 게시물 내용.','2022-02-08','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'9 번째 게시물','일지매','9 번째 게시물 내용.','2022-02-09','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'10 번째 게시물','일지매','10 번째 게시물 내용.','2022-02-10','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'11 번째 게시물','일지매','11 번째 게시물 내용.','2022-02-11','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'12 번째 게시물','일지매','12 번째 게시물 내용.','2022-02-12','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'13 번째 게시물','일지매','13 번째 게시물 내용.','2022-02-13','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'14 번째 게시물','일지매','14 번째 게시물 내용.','2022-02-14','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'15 번째 게시물','일지매','15 번째 게시물 내용.','2022-02-15','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'16 번째 게시물','일지매','16 번째 게시물 내용.','2022-02-16','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'17 번째 게시물','일지매','17 번째 게시물 내용.','2022-02-17','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'18 번째 게시물','일지매','18 번째 게시물 내용.','2022-02-18','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'19 번째 게시물','일지매','19 번째 게시물 내용.','2022-02-19','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'20 번째 게시물','일지매','20 번째 게시물 내용.','2022-02-20','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'21 번째 게시물','일지매','21 번째 게시물 내용.','2022-02-21','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'22 번째 게시물','일지매','22 번째 게시물 내용.','2022-02-22','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'23 번째 게시물','일지매','23 번째 게시물 내용.','2022-02-23','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'24 번째 게시물','일지매','24 번째 게시물 내용.','2022-02-24','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'25 번째 게시물','일지매','25 번째 게시물 내용.','2022-02-25','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'26 번째 게시물','일지매','26 번째 게시물 내용.','2022-02-26','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'27 번째 게시물','일지매','27 번째 게시물 내용.','2022-02-27','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'28 번째 게시물','일지매','28 번째 게시물 내용.','2022-02-28','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'29 번째 게시물','일지매','29 번째 게시물 내용.','2022-02-28','guest');

insert into board(seq,title,nickname,content,regdate,userid)
values ((select nvl(max(seq),0)+1 from board),'30 번째 게시물','일지매','30 번째 게시물 내용.','2022-02-28','guest');

-- seq값이 null값이면 (게시글이 없으면) 0으로 값을 대체. 게시글이 존재하면 seq값 제일 큰 수에서 
-- 1더한 수를 seq로 설정.
(select nvl(max(seq),0)+1 from board--)

-- 게시판 테이블 삭제
drop table board

-- 게시판 테이블 레코드 삭제
delete from board

-- 게시판 테이블 레코드 삭제(조건값 포함)
delete from board where seq=3

-- cnt update
update board set cnt=(select cnt+1 from board where seq=5) where seq=5

update board set title='비가 오는 월요일 아침',content='날씨가 선선해졌어요.' where seq=2

-- 글 리스트 검색(작성자 검색)
select * from board where nickname like '%홍길동%' order by seq desc 

-- 글 리스트 검색(제목 검색)
select * from board where title like '%번째%' order by seq desc

-- 글 리스트 검색(내용 검색)
select * from board where content like '%날씨%' order by seq desc

-- 답글 게시판. 원래 게시판의 seq값을 참조하여 그 값에 해당하는 seq의 페이지
-- (getBoard.jsp)를 찾아 해당 댓글을 출력
create table replyboard(
boardseq number(5) not null, -- board테이블에서 seq를 참고하는 필드
seq number(5) not null,--같은 글번호에서 댓글의 순번을 지정하는 필드
nickname varchar2(30) not null,--댓글 남긴 사람 이름
regdate date default sysdate, -- 글쓴 날짜
content varchar2(2000) not null,-- 본문내용
userid varchar2(8), -- 댓글 수정 삭제 인증을 위한 userid추가
primary key(boardseq,seq) -- 두 개의 필드 조합으로 기본키 설정
)

insert into replyboard

-- 답글 게시판 조회
select boardseq,seq,nickname,to_char(regdate,'yyyy-mm-dd HH24:MI:SS') as regdate,content from replyboard

-- 답글 게시판 조회(특정 게시판 번호 답글 조회)
select boardseq,seq,nickname,to_char(regdate,'yyyy-mm-dd HH24:MI:SS') as regdate,content from replyboard where boardseq=2 order by seq desc

-- 답글 게시판 레코드 삭제
delete from replyboard

-- 답글 게시판 테이블 삭제
drop table replyboard

-- 답글의 답글 게시판
-- 테이블 만들기
create table replyboard_2(
boardseq number(5) not null, -- 원(할아버지 댓글..) 게시글을 참고하기 위한 게시글 번호
seq number(5) not null,-- 부모 댓글을 참고하기 위한 게시글 번호
rseq number(5) not null,-- 답글의 답글 게시글 번호(일련 번호로 만든다.) 자기자신-손자
-- 이름은 rseq로 정하기로 함.
nickname varchar2(30) not null,--댓글 남긴 사람 이름
regdate date default sysdate, -- 글쓴 날짜
content varchar2(2000) not null,-- 본문내용
userid varchar2(8), -- 댓글 수정 삭제 인증을 위한 userid추가
primary key(boardseq,seq,rseq) -- 세 개의 필드 조합으로 기본키 설정
)

-- 답글의 답글 게시판 글 조회
select boardseq,seq,rseq,nickname,to_char(regdate,'yyyy-mm-dd HH24:MI:SS') 
as regdate,content,userid from replyboard_2 order by boardseq desc,seq desc,rseq desc

-- 답글의 답글 게시판 글 조회(특정 게시판 번호 답글 조회)
select boardseq,seq,rseq,nickname,to_char(regdate,'yyyy-mm-dd HH24:MI:SS') 
as regdate,content from replyboard_2 where boardseq=1 and seq=1

-- 답글의 답글 게시판 글 삽입
insert into replyboard_2(boardseq,seq,rseq,nickname,regdate,content,userid) 
values(1,2,(select nvl(max(rseq),0)+1 from replyboard_2),
'일지매',sysdate,'1게시물 2번 답글의 답글입니다.','guest')

-- 답글의 답글 게시판 레코드 삭제
delete from replyboard_2 

-- 답글의 답글 게시판 레코드 삭제 (조건 삭제)
delete from replyboard_2 where boardseq=1 and seq=2;

-- 답글의 답글 게시판 글 테이블 삭제
drop table replyboard_2


-- 여기부터는 페이징 관련 SQL
-- 게시판 전체 게시글 개수
select count(seq) from board

-- rownum이라는 레코드의 논리적 번호를 함께 출력. board테이블의 모든 레코드와
-- rownum값을 같이 출력
select rownum,B.* from board B order by B.seq desc

select rownum as rnum,B.* from (select * from board order by seq desc) B
-- rownum을 기준으로 seq를 활용 글 최신번호를 먼저 출력되게 inline쿼리를 이용하여 쿼리문을 만듬.
-- seq는 글의 순번을 나타냄. seq가 가장 최신 번호가 앞으로 오게 함. inline뷰를 활용하지 않으면
-- order by보다 먼저 rownum이 번호가 매겨져 최신 번호부터 출력이 되지 않는다. 그래서 inline뷰를
-- 사용.  from()  ()안에 select하위쿼리를 사용하는 것을 인라인뷰라고 함.(oracle교재 참고)

-- page   : between  rnum 시작값  page*10-9  and rnum 종료값 page*10
select * from (select rownum as rnum,B.* from (select * from board order by seq desc) B)
where rnum between 1 and 10
-- 1 - 10

select * from (select rownum as rnum,B.* from (select * from board order by seq desc) B)
where rnum between 11 and 20
-- 11 - 20

select * from (select rownum as rnum,B.* from (select * from board order by seq desc) B)
where rnum between 21 and 30
-- 21 - 30

select * from (select rownum as rnum,B.* from (select * from board order by seq desc) B)
where rnum between 31 and 40
-- 31 - 40


-- rownum을 기준으로 조건을 넣을 때는 데이터가 연쇄적으로 나와야 다음 조건이 나오기 때문에
-- 일단 1차적으로 rownum을 사용해서 출력을 하고 그 출력물을 inline뷰로 묶어서 다시 where조건을
-- 사용해야 함.(oracle의 경우..)  my-sql은 limit이라는 키워드로 쉽게 사용할 수 있다.

select * from (select seq,title,nickname,content,to_char(regdate,'yyyy-mm-dd') 
as regdate,cnt,userid from board order by seq desc) B

-- 페이징 처리 SQL
select * from
(select rownum as rnum,B.* 
from(select seq,title,nickname,content,to_char(regdate,'yyyy-mm-dd') 
as regdate,cnt,userid from board order by seq desc) B)
where rnum between 1 and 10

-- 검색 리스트 페이징 처리 SQL
select * from
(select rownum as rnum,B.* from (select seq,title,nickname,content,to_char(regdate,'yyyy-mm-dd') 
as regdate,cnt,userid from board 
where "+searchCondition+" like '%' || ? || '%' order by seq desc) B)
where rnum between 1 and 10




