create table users(
userno number primary key,
id varchar2(50) not null unique,
username varchar2(100) not null,
password varchar2(50) not null,
joindate date not null
);

create sequence seq_users_no
increment by 1
start with 1
nocache;

create table blog(
userno number primary key,
blogtitle varchar2(200) not null,
logofile varchar2(200),
constraint c_blog_fk foreign key(userno) references users(userno)
);

create sequence seq_blog_no
increment by 1
start with 1
nocache;

create table category(
cateno number primary key,
userno number not null,
catename varchar2(200) not null,
description varchar2(500),
regdate date not null,
constraint c_category_fk foreign key(userno) references blog(userno)
);

create sequence seq_category_no
increment by 1
start with 1
nocache;

create table post(
postno number primary key,
cateno number not null,
posttitle varchar2(300),
postcontent varchar2(4000),
regdate date not null,
constraint c_post_fk foreign key(cateno) references category(cateno)
);

create sequence seq_post_no
increment by 1
start with 1
nocache;

create table comments(
cmtno number primary key,
userno number not null,
postno number not null,
comcontent varchar2(1000) not null,
regdate date not null,
constraint c_comments_fk foreign key(postno) references post(postno)
);

create sequence seq_comments_no
increment by 1
start with 1
nocache;

create table files(
file_no number,
file_save_dir varchar2(200),
file_orginal_name varchar2(200),
file_ex_name varchar2(100),
file_save_name varchar2(300),
file_path varchar2(500),
file_size number,
file_reg_date date
);

create sequence seq_file_no
increment by 1
start with 1
nocache;






drop table comments;
drop table post;
drop table category;
drop table blog;
drop table users;
drop table files;

drop sequence seq_comments_no;
drop sequence seq_post_no;
drop sequence seq_category_no;
drop sequence seq_blog_no;
drop sequence seq_users_no;
drop sequence seq_file_no;
