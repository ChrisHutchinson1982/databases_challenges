
TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE; 

INSERT INTO cohorts (name, starting_date) VALUES ('Cohort 1', '2022-11-01');
INSERT INTO cohorts (name, starting_date) VALUES ('Cohort 2', '2022-12-01');

INSERT INTO students (name, cohort_id) VALUES ('Name 1', 1);
INSERT INTO students (name, cohort_id) VALUES ('Name 2', 1);
INSERT INTO students (name, cohort_id) VALUES ('Name 3', 1);
INSERT INTO students (name, cohort_id) VALUES ('Name 4', 2);
INSERT INTO students (name, cohort_id) VALUES ('Name 5', 2);