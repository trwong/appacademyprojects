DROP TABLE if exists users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE if exists questions;

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE if exists questions_follows;

CREATE TABLE questions_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE if exists replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE if exists questions_likes;

CREATE TABLE questions_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Taylor', 'Wong'),
  ('Mike', 'Salisbury');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('meaning of life?', "??", (SELECT id FROM users WHERE fname = 'Taylor')),
  ('p == np', 'true', (SELECT id FROM users WHERE fname = 'Mike')),
  ('p != np', 'true', (SELECT id FROM users WHERE fname = 'Mike'));

INSERT INTO
  questions_follows(user_id, question_id)
VALUES
  (2, 1),
  (1, 2),
  (1, 1);

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 1, "Taylor's body"),
  (1, 1, 2, "Mike's body");

INSERT INTO
  questions_likes (user_id, question_id)
VALUES
  (1, 2),
  (1, 1),
  (2, 1),
  (1, 3),
  (2, 3);
