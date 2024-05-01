

create database if not exists Cloud;

USE  Cloud;


create table departments
(
 department_code int primary key,
 department_name varchar(50)
);

create table students
(
 student_id int primary key,
 first_name varchar(30),
 last_name varchar(30),
 hours_assigned int,
 academic_year int,
 c_gpa numeric(3,2),
 born_year int,
 nationality varchar(30),
 department_code int, -- foreign key
 
 constraint department_student_fk foreign key(department_code)
 references departments(department_code)
);


CREATE TABLE courses
(
 course_code INT PRIMARY KEY,
 course_name VARCHAR(70),
 prerequisite_code INT,
 credit_hour INT,
 semester INT
);


--relation

create table enrollment
(
 mid_degree int,
 quizs_degree int,
 assignment_degree int,
 project_degree int,
 final_degree int,
 student_id int,
 course_code int,

 constraint student_enrollment_fk foreign key(student_id)
 references students(student_id),

 constraint course_enrollment_fk foreign key(course_code)
 references courses(course_code)
);

--relation
create table course_department
(
 course_code int,
 department_code int,

 constraint course_belongto_department_fk foreign key(course_code)
 references courses(course_code),

 constraint department_belongto_course_fk foreign key(department_code)
 references departments(department_code)
);



-- Inserting data into the students table
INSERT INTO students (student_id, first_name, last_name, hours_assigned, academic_year, c_gpa, department_code) VALUES
(22010021, 'Ahmed', 'Samy', 20, 1, 3.60, 1),
(22010072, 'Pola', 'Maher', 19, 1, 3.70, 1),
(22010225, 'Mohamed', 'Atef', 17, 1, 3.30, 1),
(22010276, 'Mina', 'Adly', 19, 1, 3.50, 1),
(22010362, 'Abdullah', 'Tarek', 18, 1, 2.90, 1);

-- Inserting data into the enrollment table
INSERT INTO enrollment (student_id, course_code) VALUES
(22010021, 022401202), -- Data Science Methodology
(22010021, 022401205), -- Field Training
(22010021, 022400205), -- Machine Learning
(22010021, 022401204), -- Regression Analysis
(22010021, 022401405), -- Social Data Analytics

(22010072, 022400204), -- Cloud Computing
(22010072, 022400206), -- Data Mining and Analytics
(22010072, 22401305), --  survey
(22010072, 022401407), -- Stream Processing
(22010072, 022401402), -- Introduction to Social Network

(22010225, 022400204), -- Cloud Computing
(22010225, 022400206), -- Data Mining and Analytics
(22010225, 022401202), -- Data Science Methodology
(22010225, 022401204), -- Regression Analysis
(22010225, 022401403), -- Simulation

(22010276, 022401303), -- Data Visualization Tools
(22010276, 022401302), -- Design and Analysis of Experiment
(22010276, 022400202), -- Introduction to Databases
(22010276, 022400205), -- Machine Learning
(22010276, 022401204), -- Regression Analysis

(22010362, 022400102), -- Calculus
(22010362, 022400206), -- Data Mining and Analytics
(22010362, 022400109), -- Introduction to Artificial Intelligence
(22010362, 022400110), -- Programming 2
(22010362, 022401204); -- Regression Analysis



SELECT 
    S.student_id,
    CONCAT(S.first_name, ' ', S.last_name) AS 'Student Name',
    S.hours_assigned,
    S.c_gpa,
    D.department_name,
    D.department_code,
    MAX(CASE WHEN C.rn = 1 THEN C.course_name END) AS course_1,
    MAX(CASE WHEN C.rn = 2 THEN C.course_name END) AS course_2,
    MAX(CASE WHEN C.rn = 3 THEN C.course_name END) AS course_3,
    MAX(CASE WHEN C.rn = 4 THEN C.course_name END) AS course_4,
    MAX(CASE WHEN C.rn = 5 THEN C.course_name END) AS course_5
FROM 
    students S
JOIN 
    departments D ON S.department_code = D.department_code
LEFT JOIN (
    SELECT 
        e.student_id,
        c.course_name,
        ROW_NUMBER() OVER (PARTITION BY e.student_id ORDER BY c.course_name) AS rn
    FROM 
        enrollment e
    JOIN 
        courses c ON e.course_code = c.course_code
) AS C ON S.student_id = C.student_id
GROUP BY 
    S.student_id, S.first_name, S.last_name, S.hours_assigned, S.c_gpa, D.department_name, D.department_code;




insert into departments
(department_code,department_name)
values
(1,'Computing & Data Science'),
(2,'Cyper Security'),
(3,'Intelligent System');



-- insert course table  data science(44 corses)
-------------------------------------------------------------------

insert into courses
(course_code,course_name,prerequisite_code,credit_hour,semester)

values

-- semester 1

(022400101,'linear algebra',0,3,1),
(022400102,'calculas',0,3,1),
(022400103,'introduction to computer system',0,3,1),
(022400104,'introduction to data science',0,3,1),
(022400105,'programming 1',0,3,1),
(020000010,'critical thinking',0,2,1),


-- semester 2

(022400106,'probability and statistics 1',0,3,2),
(022400107,'discrete structure',0,3,2),
(022400108,'data structure and alghorithm',022400105,3,2),
(022400109,'intoduction to artificial intelligent',022400103,3,2),
(022400110,'programming 2',022400105,3,2),
(020000011,'innovation and entrepreneurship',0,2,2),


(022400201,'probability and statistics 2',022400106,3,3),
(022400202,'introduction to databases',022400105,3,3),
(022400203,'numerical computation',022400101,3,3),
(022401201,'advanced calculus',022400102,3,3),
(022401202,'data science methodolgy',022400104,3,3),
(020000012,'human rights',0,2,3),


(022400204,'cloud computing',022400108,3,4),
(022400205,'machine learning',022400109,3,4),
(022400206,'data mining and analytics',022400201,3,4),
(022401203,'data science tools and software',022400105,3,4),
(022401204,'regression analysis',022400201,3,4),
(020000013,'first aid',0,2,4),



(022401301,'stochastic process',022400101,3,5),
(022401302,'design and analysis of experiment',022400201,3,5),
(022401303,'data visualization tools',022401202,3,5),
(022401413,'data compression techniques',022400108,3,5),
(020000014,'human and environment',0,2,5),



(022401304,'data computation and analysis',022400205,3,6),
(022401305,'survey methodology',022400201,3,6),
(022401306,'computing intensive statistical method',022400201,3,6),
(022401416,'advanced database system',022400202,3,6),
(022401205,'field training',0,2,6),



(022401401,'big data analytics',022400105,3,7),
(022401402,'introduction to social network',022400201,3,7),
(022401403,'simulation',022400105,3,7),
(022401409,'convex optimization',022400101,3,7),
(022401404,'Project 1',0,3,7),



(022401405,'social data analytics',022400101,3,8),
(022401406,'distributed data analytics',022400202,3,8),
(022401407,'stream processing',022400108,3,8),
(022401408,'Project 2',0,3,8),
(022401411,'multivariate statistical analysis',022400201,3,8);




-- insert cybercourse 44 course
-------------------------------------------------------------------
insert into courses
(course_code,course_name,prerequisite_code,credit_hour,semester)

values


(032400101,'linear algebra',0,3,1),
(032400102,'calculus',0,3,1),
(032400103,'introduction to computer system,',0,3,1),
(032400104,'introduction to data science',0,3,1),
(032400105,'programming 1',0,3,1),
(030000021,'critical thinking',0,2,1),



(032400106,'probability and statistics 1',0,3,2),
(032400107,'discrete structure',0,3,2),
(032400108,'data structure and alghorithm',032400105,3,2),
(032400109,'introduction to artificial intelligent',032400103,3,2),
(032400110,'programming 2',032400105,3,2),
(030000022,'innovation and entrepreneurship',0,2,2),



(032400201,'probability and statistics',032400106,3,3),
(032400202,'introduction to database',032400105,3,3),
(032400203,'numerical computitation',032400101,3,3),
(032406201,'introduction to cybersecurity',0,3,3),
(032406202,'number theory',032400101,3,3),
(030000023,'first aid',0,2,3),



(032400204,'cloud computing',032400108,3,4),
(032400205,'machine learning',032400109,3,4),
(032400206,'data mining and analytics',032400201,3,4),
(032406203,'cryptograohy',032406201,3,4),
(032400307,'operating system',032400103,3,4),
(030000024,'human rights',0,2,4),



(032400308,'computer network',032400103,3,5),
(032406302,'operating system security',032400307,3,5),
(032406303,'secure software development',032400110,3,5),
(032406411,'software security engineering',032400301,3,5),
(032406409,'AI security issues',032400109,3,5),



(032406304,'computer and network security',032400308,3,6),
(032406305,'data integrity and authentication',032400202,3,6),
(032406306,'information security management',032400202,3,6),
(032406415,'internet of things',032400308,3,6),
(032406307,'field training',0,2,6),



(032406401,'social network computing',032400308,3,7),
(032406402,'security of distributed system',032400307,3,7),
(032406403,'human security',032406201,3,7),
(032406404,'project 1',0,3,7),
(032406416,'mobile computing',032400308,3,7),


(032406405,'cybersecurity risk management',032400205,3,8),
(032406406,'digital forensics',032400307,3,8),
(032406407,'law and cybersecurity',032406201,3,8),
(032406412,'blockchain and security blockchain',032400202,3,8),
(032406408,'project 2',0,3,8);




-- insert intelligant system courses 44 course

insert into courses
(course_code,course_name,prerequisite_code,credit_hour,semester)

values



(042400101,'linear algebra',0,3,1),
(042400102,'calculus',0,3,1),
(042400103,'introduction to computer cystem',0,3,1),
(042400104,'introduction to data science',0,3,1),
(042400105,'programming 1',0,3,1),
(040000031,'critical thinking',0,2,1),


(042400106,'probability and statistics 1',0,3,2),
(042400107,'discrete structure',0,3,2),
(042400108,'data structure and alghorithms',042400105,3,2),
(042400109,'introduction to artificial intelligence',042400103,3,2),
(042400110,'programming 2',042400105,3,2),
(040000032,'innovation and entrepreneurship',0,2,2),



(042400201,'probability and statistics 2',042400106,3,3),
(042400202,'introduction to databases',042400105,3,3),
(042400203,'numerical computation',042400101,3,3),
(042403201,'smart systemand computational intelligence',042400109,3,3),
(042403202,'operations research',042400106,3,3),
(040000033,'first aid',0,2,3),



(042400204,'cloud computing',042400108,3,4),
(042400205,'machine learning',042400109,3,4),
(042400206,'data mining and analytics',042400201,3,4),
(042403203,'pattern recognition',042400101,3,4),
(042403204,'neural network',042400109,3,4),
(042403205,'field training 1',0,2,4),


(042403301,'intelligent programming',042400105,3,5),
(042403302,'deep learining',042403204,3,5),
(042403303,'modern control system',042400101,3,5),
(042403416,'game theory',042403202,3,5),
(042403307,'field taining 2',0,2,5),


(042403304,'embedded system',042403303,3,6),
(042403305,'computer vision',042400109,3,6),
(042403306,'AI security issues',042400109,3,6),
(042403415,'virtual realtial',042404401,3,6),
(042403410,'natural language understanding',042403403,3,6),

(042403401,'AI platforms',042400109,3,7),
(042403402,'internet of things 1',042403304,3,7),
(042403403,'natural language processing',042400205,3,7),
(042403409,'speech recognition',042400204,3,7),
(042403404,'project',0,3,7),

(042403405,'reinforcement learning',042403202,3,8),
(042403406,'AI for robotics',042403304,3,8),
(042403407,'visual recognition',042403305,3,8),
(042403413,'internet of things 2',042403402,3,8),
(042403408,'project 2',0,3,8);




INSERT INTO students (student_id, first_name, last_name, hours_assigned, academic_year, c_gpa, department_code) VALUES 
(22500963, 'motaz', 'mohamed', 15, 1, 3.20, 1)