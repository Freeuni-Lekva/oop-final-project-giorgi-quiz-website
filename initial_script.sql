use
QUIZ_DB;


-- player part

DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS ACHIEVEMENTS;
DROP TABLE IF EXISTS QUIZES;
DROP TABLE IF EXISTS QUIZ_HISTORY;
DROP TABLE IF EXISTS FRIENDS;
DROP TABLE IF EXISTS FRIEND_REQUESTS;
DROP TABLE IF EXISTS CHALLENGES;
DROP TABLE IF EXISTS NOTE_MAIL;
DROP TABLE IF EXISTS QUESTIONS;
DROP TABLE IF EXISTS ANSWERS;
DROP TABLE IF EXISTS POSSIBLE_ANSWERS;
DROP TABLE IF EXISTS ANNOUNCEMENTS;

CREATE TABLE USERS
(
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50),
    last_name     VARCHAR(50),
    username      VARCHAR(50) UNIQUE,
    bio           VARCHAR(300),
    password      VARCHAR(100),
    creation_date TIMESTAMP default now(),
    is_admin      TINYINT(1) DEFAULT '0'
);

INSERT INTO USERS (first_name, last_name, username, bio, password, is_admin)
VALUES ('Mariam', 'Kelaptrishvili', 'Neimar', 'Zalian chkviani', 'neimari1234', 1),
       ('Tamazi', 'Mukeria', 'Tazuka', 'bote', 'tamazi111', 1),
       ('Sandro', 'Khutchua', 'Sandrika', 'injineri', 'jandieri111', 0);


CREATE TABLE ACHIEVEMENTS
(
    user_id     INT,
    achievement VARCHAR(50)
);

INSERT INTO ACHIEVEMENTS (user_id, achievement)
VALUES (1, 'I AM THE GRATEST'),
       (1, 'AMATEUR AUTHOR'),
       (2, 'AMATEUR AUTHOR'),
       (2, 'QUIZ MACHINE');

INSERT INTO ACHIEVEMENTS (user_id, achievement)
VALUES (1, 'WELCOME TO OUT WEB SITE');


CREATE TABLE ANNOUNCEMENTS
(
    user_id      INT,
    announcement TEXT
);

-- Quizes part

CREATE TABLE QUIZES
(
    quiz_id          INT AUTO_INCREMENT PRIMARY KEY,
    player_id        INT,
    name             VARCHAR(100) UNIQUE,
    description      VARCHAR(300),
    sorted           TINYINT(1),
    one_or_multiple  TINYINT(1),
    instant_feedback TINYINT(1),
    practice_mode    TINYINT(1),
    view_count       INT       default 0,
    timestamp        TIMESTAMP DEFAULT NOW()
);


INSERT INTO QUIZES (player_id, name, description, sorted, one_or_multiple, instant_feedback, practice_mode)
VALUES (1, 'Cars quiz', 'magari', 1, 0, 1, 1);

-- QUIZ History

CREATE TABLE QUIZ_HISTORY
(
    player_id INT,
    quiz_id   INT,
    score     DECIMAL(5, 2),
    timestamp TIMESTAMP DEFAULT NOW()
);

INSERT INTO QUIZ_HISTORY (player_id, quiz_id, score)
VALUES (1, 1, 75.5),
       (2, 1, 80.0),
       (2, 1, 90.25),
       (1, 1, 95.75);


CREATE TABLE FRIENDS
(
    player_one          INT,
    player_two          INT,
    relationship_status VARCHAR(100),
    timestamp           TIMESTAMP DEFAULT NOW()
);

INSERT INTO FRIENDS (player_one, player_two, relationship_status)
VALUES (1, 2, 'FRIENDS');


-- friend request

CREATE TABLE FRIEND_REQUESTS
(
    player_one INT,
    player_two INT,
    timestamp  TIMESTAMP DEFAULT NOW()
);

INSERT INTO FRIEND_REQUESTS (player_one, player_two)
VALUES (1, 3);


CREATE TABLE CHALLENGES
(
    player_one  INT,
    player_two  INT,
    quiz_id     INT,
    description VARCHAR(100),
    timestamp   TIMESTAMP DEFAULT NOW()
);

INSERT INTO CHALLENGES (player_one, player_two, quiz_id, description)
VALUES (2, 1, 1, 'aba qeni');

CREATE TABLE NOTE_MAIL
(
    player_one INT,
    player_two INT,
    note       VARCHAR(300),
    timestamp  TIMESTAMP DEFAULT NOW()
);

INSERT INTO NOTE_MAIL (player_one, player_two, note)
VALUES (1, 3, 'damamate');


CREATE TABLE QUESTIONS
(
    question_id   INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id       INT,
    picture_url   VARCHAR(2050) DEFAULT '',
    question_type VARCHAR(50),
    question      TEXT,
    sort_order    INT(11) NOT NULL DEFAULT '0'
);

INSERT INTO QUESTIONS (quiz_id, question_type, question)
VALUES (1, 'QUESTION-RESPONSE', 'Ra hqvia Giorgis?');

CREATE TABLE ANSWERS
(
    question_id INT,
    answer      varchar(256)
);

INSERT INTO ANSWERS (question_id, answer)
VALUES (1, 'Giorgi'),
       (1, 'Gio');

CREATE TABLE POSSIBLE_ANSWERS
(
    question_id     INT,
    possible_answer varchar(256)
)

