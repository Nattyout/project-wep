select MIN(s.id) from student s

select * from curriculum
where sex = 'F'

select * from student

update student
set prefix_id = 3
where sex = 'F'

select * from student_subject
where subject_id = 2243212 and number = 19
order by student_id


update student_subject 
set id = 1
where student_id = 1

update student_subject 
set id = 2
where student_id = 4

update student_subject 
set id = 3
where student_id = 7

update student_subject 
set id = 4
where student_id = 10

ทำไปจนกว่า student_id = 55

DO $$
DECLARE
    i INT := 3;  -- เริ่มที่ student_id = 1
    counter INT := 1;  -- เริ่มต้นที่ id = 1
BEGIN
    WHILE i <= 55 LOOP
        UPDATE student_subject SET id = counter WHERE student_id = i;
        counter := counter + 1;
        i := i + 3;  -- เพิ่มค่า student_id ทีละ 3
    END LOOP;
END $$;

update student_subject 
set id = 19
where student_id = 56

ALTER TABLE student_subject
ADD PRIMARY KEY (ID);


UPDATE student_list
SET status = 'I'
WHERE status = 'D';

insert into student_list(subject_id,student_id,active_date,status) values
(2241215,1,now(),'A');

create table subject (
    id serial not null,
    subject varchar(100) not null,
	credit int not null,
    primary key (id)
);

create table student_subject (
	id int not null,
    student_id int not null,
    subject_id int not null,
	section_id int not null,
    primary key (id,student_id, subject_id),
    foreign key (student_id) references student(id),
    foreign key (subject_id) references subject(id),
	foreign key (section_id) references section(id)
);

alter table student_subject
add foreign key (section_id) references section(id);

insert into section values
(1,'sec 1'),
(2,'sec 2'),
(3,'sec 3');

update section
set section = 'sec 1'
where id = 1;

update section
set section = 'sec 2'
where id = 2;

update section
set section = 'sec 3'
where id = 3;

select * from section

delete from section

create table student_list
(id INTEGER primary key,
subject_id int not null,
student_id int not null,
active_date timestamp not null,
status char(2) not null DEFAULT 'A',
foreign key (subject_id) references subject(id),
foreign key (student_id) references student(id));

CREATE TABLE users 
(id SERIAL PRIMARY KEY,
username VARCHAR(50) NOT NULL UNIQUE,
password VARCHAR(255) not null,
subject_id int not null,
foreign key (subject_id) references subject(id));

ALTER TABLE student_list
ALTER status SET DEFAULT 'A';

insert into student(prefix_id, first_name, last_name, date_of_birth, sex, curriculum_id, previous_school, address, telephone, email, line_id) values
(1, 'ธนภัทร', 'ศรีสมบูรณ์', '2003-05-12', 'M', 1, 'โรงเรียนอุดรพิทยานุกูล', 'อุดรธานี', '0981234567', 'thanapat.sri@gmail.com', 'Thanapat123'),
(2, 'กานดา', 'สุนทรภักดี', '2004-08-19', 'F', 2, 'โรงเรียนสตรีวิทยา', 'กรุงเทพฯ', '0972345678', 'kanda.sun@gmail.com', 'Kanda567'),
(3, 'ชุติมา', 'พิทักษ์วงศ์', '2005-11-03', 'F', 1, 'โรงเรียนราชินี', 'นนทบุรี', '0963456789', 'chutima.p@gmail.com', 'ChutiPi889'),
(1, 'ปริญญา', 'สงวนศิลป์', '2002-02-14', 'M', 2, 'โรงเรียนสวนกุหลาบ', 'กรุงเทพฯ', '0954567890', 'parinya.s@gmail.com', 'ParinyaSky'),
(3, 'วราภรณ์', 'ดำรงรักษ์', '2004-07-21', 'F', 1, 'โรงเรียนสตรีสมุทรปราการ', 'สมุทรปราการ', '0945678901', 'wara.damrong@gmail.com', 'WaraLove23'),
(2, 'อรทัย', 'ชูชาติ', '2003-04-09', 'F', 2, 'โรงเรียนเตรียมอุดมศึกษา', 'กรุงเทพฯ', '0936789012', 'orn.chuchat@gmail.com', 'OrnChuchat'),
(1, 'สุรศักดิ์', 'จิตตะวงศ์', '2002-10-15', 'M', 1, 'โรงเรียนเบญจมราชูทิศ', 'นครศรีธรรมราช', '0927890123', 'surasak.j@gmail.com', 'SuraKing99'),
(3, 'พรทิพย์', 'สกุลเงิน', '2004-09-30', 'F', 2, 'โรงเรียนหอวัง', 'กรุงเทพฯ', '0918901234', 'porntip.sakul@gmail.com', 'PornyTee66'),
(1, 'วีระชัย', 'นาคแก้ว', '2003-06-17', 'M', 1, 'โรงเรียนชลราษฎร์บำรุง', 'ชลบุรี', '0909012345', 'veerachai.n@gmail.com', 'VeeraChill'),
(3, 'อภิสรา', 'เรืองศรี', '2005-12-25', 'F', 2, 'โรงเรียนพระหฤทัย', 'เชียงใหม่', '0890123456', 'apisara.r@gmail.com', 'ApiRuang55'),
(1, 'รัฐภูมิ', 'เกรียงไกร', '2002-01-05', 'M', 1, 'โรงเรียนเชียงใหม่คริสเตียน', 'เชียงใหม่', '0881234567', 'rattapoom.g@gmail.com', 'RatPoom123'),
(3, 'สิริกร', 'วัฒนานุกูล', '2004-04-22', 'F', 2, 'โรงเรียนบุญวาทย์วิทยาลัย', 'ลำปาง', '0872345678', 'sirikorn.w@gmail.com', 'SiiKorn888'),
(1, 'ก้องภพ', 'ธนรักษ์', '2003-07-19', 'M', 2, 'โรงเรียนปรินส์รอยแยลส์', 'เชียงใหม่', '0863456789', 'kongpop.t@gmail.com', 'KongPopCm'),
(2, 'อุบล', 'อินทรี', '2005-10-08', 'F', 1, 'โรงเรียนบวรนิเวศวิทยาลัย', 'กรุงเทพฯ', '0854567890', 'ubon.int@gmail.com', 'UbonInsee'),
(1, 'ภูริทัต', 'ธรรมรักษ์', '2002-03-11', 'M', 1, 'โรงเรียนสามเสนวิทยาลัย', 'กรุงเทพฯ', '0845678901', 'puritat.d@gmail.com', 'PuriTatT'),
(3, 'อาทิตยา', 'สุวรรณเพ็ญ', '2003-02-28', 'F', 2, 'โรงเรียนสายปัญญา', 'กรุงเทพฯ', '0836789012', 'arthitaya.su@gmail.com', 'ArtySunny'),
(1, 'ธีรเดช', 'พงษ์สถิต', '2004-06-25', 'M', 2, 'โรงเรียนเตรียมทหาร', 'นครนายก', '0827890123', 'teeradej.p@gmail.com', 'TheerD777'),
(3, 'ธนพร', 'เจริญทรัพย์', '2005-01-13', 'F', 1, 'โรงเรียนสาธิตเกษตร', 'กรุงเทพฯ', '0818901234', 'thanaporn.j@gmail.com', 'ThanaJai23'),
(2, 'สุพัตรา', 'สมานมิตร', '2003-09-05', 'F', 2, 'โรงเรียนมหาวีรวิทยา', 'สุพรรณบุรี', '0809012345', 'supattra.som@gmail.com', 'SPattra2020'),
(1, 'ศิรวิชญ์', 'โสภาวรรณ', '2004-11-17', 'M', 1, 'โรงเรียนอยุธยาวิทยาลัย', 'พระนครศรีอยุธยา', '0790123456', 'sirawit.sopa@gmail.com', 'SirawitGood');

insert into student(prefix_id, first_name, last_name, date_of_birth, sex, curriculum_id, previous_school, address, telephone, email, line_id) values
(1, 'กิตติพงษ์', 'จันทร์ประเสริฐ', '2003-03-21', 'M', 1, 'โรงเรียนขอนแก่นวิทยายน', 'ขอนแก่น', '0982345671', 'kittipong.ch@gmail.com', 'KittiBright'),
(1, 'สมชาย', 'สุภัทรกุล', '2004-04-25', 'M', 2, 'โรงเรียนสวนกุหลาบ', 'กรุงเทพฯ', '0973456782', 'somchai.su@gmail.com', 'SomChaiMan'),
(1, 'อธิชาติ', 'พงษ์พานิช', '2003-11-18', 'M', 1, 'โรงเรียนอัสสัมชัญ', 'กรุงเทพฯ', '0964567893', 'athichart.po@gmail.com', 'Athichart01'),
(1, 'ชยุต', 'มณีวัฒน์', '2002-12-22', 'M', 1, 'โรงเรียนสุราษฎร์ธานี', 'สุราษฎร์ธานี', '0955678904', 'chayut.manee@gmail.com', 'ChayutMTY'),
(1, 'ภูวนาท', 'อินทนนท์', '2005-05-17', 'M', 2, 'โรงเรียนยุพราชวิทยาลัย', 'เชียงใหม่', '0946789015', 'puwanat.in@gmail.com', 'PuwantTon'),
(1, 'ศักดิ์ดา', 'พุทธรักษา', '2004-01-29', 'M', 1, 'โรงเรียนราชสีมาวิทยาลัย', 'นครราชสีมา', '0937890126', 'sakda.puttaraksa@gmail.com', 'SakdaPRAK'),
(1, 'นพเก้า', 'ทวีโชค', '2003-07-03', 'M', 2, 'โรงเรียนบางแสนวิทยา', 'ชลบุรี', '0928901237', 'noppakao.ta@gmail.com', 'NopTweeChok'),
(1, 'พงษ์ศิริ', 'กาญจนะ', '2002-09-14', 'M', 1, 'โรงเรียนลำปางกัลยาณี', 'ลำปาง', '0919012348', 'pongsiri.kana@gmail.com', 'PongSirKan'),
(1, 'ธนบดี', 'จันทนา', '2004-06-11', 'M', 2, 'โรงเรียนวัดสุทธิวราราม', 'กรุงเทพฯ', '0900123459', 'thanabodi.ja@gmail.com', 'ThanabodiCJ'),
(1, 'สุรเดช', 'พิริยชัย', '2002-08-27', 'M', 1, 'โรงเรียนศรีสะเกษวิทยาลัย', 'ศรีสะเกษ', '0891234560', 'suradech.pi@gmail.com', 'SuraPiriChai'),
(1, 'รัฐพล', 'อิทธิโชติ', '2003-02-13', 'M', 1, 'โรงเรียนสาธิตมศว', 'นครนายก', '0882345671', 'ratthapol.it@gmail.com', 'RathItto13'),
(1, 'พงศกร', 'ทวีทรัพย์', '2004-03-15', 'M', 2, 'โรงเรียนปรินส์รอยแยลส์วิทยาลัย', 'เชียงใหม่', '0873456782', 'pongsakorn.tawee@gmail.com', 'PongTweeSap'),
(1, 'อัครพล', 'วัฒนะกิจ', '2005-07-19', 'M', 1, 'โรงเรียนสารวิทยา', 'กรุงเทพฯ', '0864567893', 'akkrapol.wat@gmail.com', 'AkkraWat19'),
(1, 'ณัฐพล', 'วิชัยมงคล', '2003-04-25', 'M', 1, 'โรงเรียนสตรีนครสวรรค์', 'นครสวรรค์', '0855678904', 'natthapon.vi@gmail.com', 'NattVi25'),
(1, 'วีรภัทร', 'สุวรรณจิต', '2002-10-18', 'M', 2, 'โรงเรียนอัสสัมชัญศรีราชา', 'ชลบุรี', '0846789015', 'weeraphat.su@gmail.com', 'WeeraSun18'),
(1, 'ศุภกิตติ์', 'ศิริธนานนท์', '2004-12-20', 'M', 1, 'โรงเรียนบดินทรเดชา', 'กรุงเทพฯ', '0837890126', 'suppakit.si@gmail.com', 'SupaKitiDec'),
(1, 'ณัฐนนท์', 'วิสุทธิผล', '2005-09-01', 'M', 2, 'โรงเรียนหาดใหญ่วิทยาลัย', 'สงขลา', '0828901237', 'natthanon.wi@gmail.com', 'NatWiSo123'),
(1, 'ปฏิพล', 'สุทธิศรี', '2002-11-23', 'M', 1, 'โรงเรียนบุญวาทย์วิทยาลัย', 'ลำปาง', '0819012348', 'patipol.su@gmail.com', 'PatSutSir'),
(1, 'กฤษดา', 'ชูสกุล', '2003-01-17', 'M', 1, 'โรงเรียนพนัสศึกษาลัย', 'ชลบุรี', '0800123459', 'krisada.ch@gmail.com', 'KriChu17'),
(1, 'นนทกร', 'พึ่งเกียรติ', '2004-08-06', 'M', 2, 'โรงเรียนสตรีวิทยา 2', 'กรุงเทพฯ', '0892345670', 'nontakorn.pu@gmail.com', 'NonPuekAug'),
(1, 'ภูวดล', 'ธำรงชัย', '2005-10-14', 'M', 1, 'โรงเรียนสาธิตพิบูลบำเพ็ญ', 'ชลบุรี', '0883456781', 'phuwadol.th@gmail.com', 'PhuWaaChai'),
(1, 'ภาณุวัฒน์', 'อำพล', '2003-05-22', 'M', 1, 'โรงเรียนสุโขทัยวิทยาคม', 'สุโขทัย', '0874567892', 'panuwat.am@gmail.com', 'PanuApol22'),
(1, 'วีรเทพ', 'บัวศรี', '2002-07-08', 'M', 2, 'โรงเรียนมัธยมวัดสิงห์', 'กรุงเทพฯ', '0865678903', 'weerathep.bu@gmail.com', 'WeeBuSing08'),
(1, 'จักรพงษ์', 'ทองประทีป', '2004-09-03', 'M', 1, 'โรงเรียนเสนาเสนีย์', 'พระนครศรีอยุธยา', '0856789014', 'jakrapong.to@gmail.com', 'JakkToSep03'),
(1, 'ธนากร', 'สุขสวัสดิ์', '2002-03-28', 'M', 2, 'โรงเรียนเทพศิรินทร์', 'กรุงเทพฯ', '0847890125', 'tanakorn.suk@gmail.com', 'TanSukWad'),
(1, 'เกรียงศักดิ์', 'พิพัฒน์วงศ์', '2003-11-04', 'M', 1, 'โรงเรียนอำนาจเจริญพิทยาคม', 'อำนาจเจริญ', '0838901236', 'kriangsak.pi@gmail.com', 'KriPatNov04'),
(1, 'ฐาปนวัฒน์', 'พลธร', '2005-06-30', 'M', 2, 'โรงเรียนเตรียมอุดมศึกษา', 'กรุงเทพฯ', '0829012347', 'tapana.wat@gmail.com', 'TapaJune30'),
(1, 'ธีรเดช', 'คงสุวรรณ', '2004-02-07', 'M', 1, 'โรงเรียนเทพศิรินทร์', 'กรุงเทพฯ', '0810123458', 'theeradej.kon@gmail.com', 'TheeKongFeb07'),
(3, 'วิไลลักษณ์', 'พิมพ์วงศ์', '2005-03-21', 'F', 1, 'โรงเรียนเซนต์โยเซฟ', 'กรุงเทพฯ', '0802345679', 'wilailak.pim@gmail.com', 'WilaPimWong'),
(2, 'มยุรี', 'ไพศาล', '2003-06-08', 'F', 1, 'โรงเรียนสตรีราชินูทิศ', 'อุดรธานี', '0893456781', 'mayuree.pai@gmail.com', 'MayureePrai');

insert into student_subject(number,subject_id,student_id) values
(1,2241215, 1),
(1,2233322, 2),
(1,2243212, 3),
(2,2241215, 4),
(2,2233322, 5),
(2,2243212, 6),
(3,2241215, 7),
(3,2233322, 8),
(3,2243212, 9),
(4,2241215, 10),
(4,2233322, 11),
(4,2243212, 12),
(5,2241215, 13),
(5,2233322, 14),
(5,2243212, 15),
(6,2241215, 16),
(6,2233322, 17),
(6,2243212, 18),
(7,2241215, 19),
(7,2233322, 20),
(7,2243212, 21),
(8,2241215, 22),
(8,2233322, 23),
(8,2243212, 24),
(9,2241215, 25),
(9,2233322, 26),
(9,2243212, 27),
(10,2241215, 28),
(10,2233322, 29),
(10,2243212, 30),
(11,2241215, 31),
(11,2233322, 32),
(11,2243212, 33),
(12,2241215, 34),
(12,2233322, 35),
(12,2243212, 36),
(13,2241215, 37),
(13,2233322, 38),
(13,2243212, 39),
(14,2241215, 40),
(14,2233322, 41),
(14,2243212, 42),
(15,2241215, 43),
(15,2233322, 44),
(15,2243212, 45),
(16,2241215, 46),
(16,2233322, 47),
(16,2243212, 48),
(17,2241215, 49),
(17,2233322, 50),
(17,2243212, 51),
(18,2241215, 52),
(18,2233322, 53),
(18,2243212, 54),
(19,2241215, 55),
(19,2233322, 56);

update student_subject
set section_id = 1
where subject_id = 2241215

update student_subject
set section_id = 2
where subject_id = 2233322

update student_subject
set section_id = 3
where subject_id = 2243212

select * from student_subject
order by student_id

insert into student_subject(number,subject_id,student_id) values
(19,2243212, 1)

SELECT s.id, sdsj.number, p.prefix, s.first_name, s.last_name, st.section, sj.subject
FROM student s
INNER JOIN prefix p ON s.prefix_id = p.id
INNER JOIN student_subject sdsj ON s.id = sdsj.student_id
INNER JOIN section st ON sdsj.section_id = st.id
INNER JOIN subject sj ON sdsj.subject_id = sj.id
where sj.id = 2241215
ORDER BY s.id

//ดู student_list พร้อม เลขที่
select sl.id, sl.student_id, sdsj.number, p.prefix, s.first_name, s.last_name, sj.subject, sl.active_date, sl.status
from student_list sl
inner join student s on sl.student_id = s.id
inner join student_subject sdsj on s.id = sdsj.student_id
INNER JOIN prefix p ON s.prefix_id = p.id
INNER JOIN subject sj ON sdsj.subject_id = sj.id
where sl.student_id = 3
where sj.subject =

SELECT sl.id, sl.student_id, sdsj.number, p.prefix, s.first_name, s.last_name, sj.subject, sl.active_date, sl.status
FROM student_list sl
LEFT JOIN student s ON sl.student_id = s.id
LEFT JOIN student_subject sdsj ON s.id = sdsj.student_id
LEFT JOIN prefix p ON s.prefix_id = p.id
LEFT JOIN subject sj ON sdsj.subject_id = sj.id
WHERE s.id = 1;

select * from student_list

//reset ค่า serial ที่ student_list_id_seq = 1
ALTER SEQUENCE student_list_id_seq RESTART WITH 1;

//ดูทุกค่าของ sequences
SELECT * FROM information_schema.sequences

delete from student_list
where id = 21


inner join subject sj on sdsj.subject_id = sj.id

SELECT sl.id, sdsj.number, p.prefix, s.first_name, s.last_name, sj.subject, sl.student_id, sl.active_date, sl.status
            FROM student_list sl
            INNER JOIN student s ON sl.student_id = s.id
            INNER JOIN student_subject sdsj ON s.id = sdsj.student_id
            INNER JOIN prefix p ON s.prefix_id = p.id
            INNER JOIN subject sj ON sdsj.subject_id = sj.id
            WHERE sl.student_id = 1

select * from users
SELECT id, password FROM users WHERE username = 'a'

insert into users values
(1,'aa','aa',2241215),
(2,'bb','bb',2233322),
(3,'cc','cc',2243212);

delete from student_subject

select * from student_subject

select sl.id, sl.student_id, sdsj.number, p.prefix, s.first_name, s.last_name, sj.subject, sl.active_date, sl.status
                from student_list sl
                inner join student s on sl.student_id = s.id
                inner join student_subject sdsj on s.id = sdsj.student_id
                INNER JOIN prefix p ON s.prefix_id = p.id
                INNER JOIN subject sj ON sdsj.subject_id = sj.id
                WHERE sj.id = $1
                ORDER BY sdsj.number

alter table student_subject
add foreign key (section_id) references section(id)

