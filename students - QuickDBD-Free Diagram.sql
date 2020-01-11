-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/ZKJKJL
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "students" (
    "id" integer   NOT NULL,
    "last_name" varchar   NOT NULL,
    "first_name" varchar   NOT NULL,
    CONSTRAINT "pk_students" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "courses" (
    "id" integer   NOT NULL,
    "course_name" varchar   NOT NULL,
    CONSTRAINT "pk_courses" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "student_courses_junction" (
    "student_id" integer   NOT NULL,
    "course_id" integer   NOT NULL,
    "term" varchar   NOT NULL
);

ALTER TABLE "student_courses_junction" ADD CONSTRAINT "fk_student_courses_junction_student_id" FOREIGN KEY("student_id")
REFERENCES "students" ("id");

ALTER TABLE "student_courses_junction" ADD CONSTRAINT "fk_student_courses_junction_course_id" FOREIGN KEY("course_id")
REFERENCES "courses" ("id");

