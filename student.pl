% University and department relationships
university(uap).

department(cse, uap).
department(ce, uap).
department(eee, uap).
department(bba, uap).

% Professors in departments
professor(dr_smith, cse).
professor(dr_clive, ce).
professor(dr_johnson, eee).
professor(ms_clark, bba).

% Student records
student(john, cse).
student(lisa, ce).
student(emily, eee).
student(alex, bba).
student(sophia, cse).

% Course records
course(algorithm, cse).
course(ml, cse).
course(physics, ce).
course(circuits, eee).
course(accounting, bba).

% Course instructors
teaches(dr_smith, algorithm).
teaches(dr_smith, ml).
teaches(dr_clive, physics).
teaches(dr_johnson, circuits).
teaches(ms_clark, accounting).

% Enrollment records
enrolled(john, algorithm).
enrolled(john, ml).
enrolled(lisa, physics).
enrolled(emily, circuits).
enrolled(alex, accounting).
enrolled(sophia, ml).

% Student grades
grade(john, algorithm, a).
grade(john, ml, b).
grade(lisa, physics, a).
grade(emily, circuits, a).
grade(alex, accounting, c).
grade(sophia, ml, a).

% Class schedules (course, day, time)
schedule(algorithm, monday, '10:00 AM').
schedule(ml, wednesday, '2:00 PM').
schedule(physics, wednesday, '2:00 PM').  % Potential conflict with ml
schedule(circuits, tuesday, '11:00 AM').
schedule(accounting, thursday, '1:00 PM').

% ----------------------------------------
%               RULES
% ----------------------------------------

% Find students in a university
student_in_university(Student, University) :-
    student(Student, Dept), department(Dept, University).

% Find students in a department
students_in_department(Dept, Student) :-
    student(Student, Dept).

% Find courses in a department
course_in_department(Course, Department) :-
    course(Course, Department).

% Check if a student is enrolled in a course
student_enrolled_in_course(Student, Course) :-
    enrolled(Student, Course).

% Get professor teaching a course
professor_of_course(Professor, Course) :-
    teaches(Professor, Course).

% Find courses taught by a professor
courses_by_professor(Professor, Course) :-
    teaches(Professor, Course).

% Find students taught by a professor
students_of_professor(Professor, Student) :-
    teaches(Professor, Course),
    enrolled(Student, Course).

% Get a student's grade in a course
student_grade(Student, Course, Grade) :-
    grade(Student, Course, Grade).

% Get the schedule of a course
course_schedule(Course, Day, Time) :-
    schedule(Course, Day, Time).

% Detect scheduling conflicts (same time, same day, different courses)
schedule_conflict(Course1, Course2, Day, Time) :-
    schedule(Course1, Day, Time),
    schedule(Course2, Day, Time),
    Course1 \= Course2.
