--use Kvashobase;


-- player part

/*
CREATE TABLE PLAYERS (
  player_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  nickname VARCHAR(50) UNIQUE,
  password VARCHAR(100),
  timestamp TIMESTAMP default now()
);
*/
-- drop table players

/*
INSERT INTO PLAYERS (first_name, last_name, nickname, password)
VALUES ('Mariam', 'Kelaptrishvili', 'Neimar', 'neimari1234');

*/

-- Quizes part

/*
CREATE TABLE QUIZES (
  quiz_id INT AUTO_INCREMENT PRIMARY KEY,
  player_id INT,
  name VARCHAR(100) UNIQUE,
  sorted TINYINT(1),
  one_or_multiple TINYINT(1),
  instant_feedback TINYINT(1),
  practice TINYINT(1),
  view_count INT default 0,
  timestamp TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (player_id) REFERENCES PLAYERS(player_id)
);

drop table Quizes


INSERT INTO QUIZES (player_id, name, sorted, one_or_multiple, instant_feedback, practice)
VALUES (3, 'Cars quiz', 1, 0, 1, 1);

*/

-- QUIZ History
/*
CREATE TABLE QUIZ_HISTORY (
  history_id INT AUTO_INCREMENT PRIMARY KEY,
  player_id INT,
  quiz_id INT,
  score DECIMAL(5,2),
  timestamp TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (player_id) REFERENCES PLAYERS(player_id),
  FOREIGN KEY (quiz_id) REFERENCES QUIZES(quiz_id)
);

INSERT INTO QUIZ_HISTORY (player_id, quiz_id, score)
VALUES (1, 1, 75.5),
       (3, 1, 80.0),
       (3, 1, 90.25),
       (4, 1, 95.75);

*/


/*

CREATE TABLE FRIENDS (
  friendship_id INT AUTO_INCREMENT PRIMARY KEY,
  player_one INT,
  player_two INT,
  timestamp TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (player_one) REFERENCES PLAYERS(player_id),
  FOREIGN KEY (player_two) REFERENCES PLAYERS(player_id)
);

INSERT INTO FRIENDS (player_one, player_two)
VALUES (1, 4),
       (4, 1),
       (3, 4),
       (4, 3);


*/


-- friendds request
/*

CREATE TABLE FRIEND_REQUESTS (
  friendship_id INT AUTO_INCREMENT PRIMARY KEY,
  player_one INT,
  player_two INT,
  timestamp TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (player_one) REFERENCES PLAYERS(player_id),
  FOREIGN KEY (player_two) REFERENCES PLAYERS(player_id)
);

INSERT INTO FRIEND_REQUESTS (player_one, player_two)
VALUES (1, 3);


*/

/*


CREATE TABLE CHALANGES(
  friendship_id INT AUTO_INCREMENT PRIMARY KEY,
  player_one INT,
  player_two INT,
  quiz_id INT,
  timestamp TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY (player_one) REFERENCES PLAYERS(player_id),
  FOREIGN KEY (player_two) REFERENCES PLAYERS(player_id),
  FOREIGN KEY (quiz_id) REFERENCES QUIZES(quiz_id)
);

INSERT INTO CHALANGES (player_one, player_two,quiz_id)
VALUES (1, 4,1);

select * from chalanges

*/



