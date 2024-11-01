-- Active: 1730032806293@@127.0.0.1@5432@university_db

-- Student table create and course, enrollment, student data added etc.
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(20) NOT NULL,
    age INTEGER,
    email VARCHAR(50),
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(10)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(30) NOT NULL,
    credits INTEGER
);

CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students (student_id),
    course_id INTEGER REFERENCES courses (course_id)
);

INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Sameer',
        21,
        'sameer@example.com',
        48,
        60,
        NULL
    ),
    (
        'Zoya',
        23,
        'zoya@example.com',
        52,
        58,
        NULL
    ),
    (
        'Nabil',
        22,
        'nabil@example.com',
        37,
        46,
        NULL
    ),
    (
        'Rafi',
        24,
        'rafi@example.com',
        41,
        40,
        NULL
    ),
    (
        'Sophia',
        22,
        'sophia@example.com',
        50,
        52,
        NULL
    ),
    (
        'Hasan',
        23,
        'hasan@gmail.com',
        43,
        39,
        NULL
    ),
    (
        'Example',
        25,
        'example@gmail.com',
        40,
        39,
        NULL
    );

INSERT INTO
    courses (course_name, credits)
VALUES ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);

INSERT INTO
    enrollment (student_id, course_id)
VALUES (1, 1),
    (1, 2),
    (2, 1),
    (3, 2);

SELECT * FROM students;

SELECT * FROM courses;

SELECT * FROM enrollment;

-- Solution: 1.
INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Riaz Uddin',
        27,
        'riaz@gmail.com',
        48,
        40,
        NULL
    );

-- Solution: 2.
SELECT student_name
FROM
    students
    INNER JOIN enrollment ON students.student_id = enrollment.student_id
    INNER JOIN courses ON courses.course_id = enrollment.course_id
WHERE
    course_name = 'Next.js';

-- Solution: 3
UPDATE students
SET
    status = 'Awarded'
WHERE
    student_id = (
        SELECT student_id
        FROM (
                SELECT (frontend_mark + backend_mark) AS total, student_id
                FROM students
                GROUP BY
                    student_id
                ORDER BY total DESC
                LIMIT 1
            )
    );

SELECT * FROM students;

-- Solution: 4

DELETE FROM courses
WHERE
    course_id NOT IN (
        SELECT DISTINCT
            course_id
        FROM enrollment
    );

SELECT * FROM courses;

-- Solution: 5
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2
OFFSET
    2;

-- Problem No: 6
SELECT
    count(*) AS students_enrolled,
    course_name
FROM
    students
    INNER JOIN enrollment USING (student_id)
    INNER JOIN courses USING (course_id)
GROUP BY
    course_name;

-- Solution: 7.
SELECT ROUND(AVG(age), 2) AS average_age FROM students;

-- Solution: 8.
SELECT student_name FROM students WHERE email LIKE '%example.com%';