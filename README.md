# SQL and ERD Assignments

Student: Elvin Səfiyev  
Group: 845İ

## Files
* `SQL_Assignments.sql` - Table creation, sample data, and all tasks
* `Sales_Database_ERD.png` - Assignment 4 (Sales Database ERD)
* `University_Registration_ERD.png` - Assignment 5 (University Course Registration ERD)

---

## Assignment 4 - Sales Database ERD

![Sales Database ERD](Sales_Database_ERD.png)

### Relationship Explanations:
1. **Customers to Orders (1:N):** One customer can place many orders, but each order belongs to only one customer (`Orders.CustomerID -> Customers.CustomerID`).
2. **Products to Orders (1:N):** One product can appear in multiple orders, but each order row refers to one product (`Orders.ProductID -> Products.ProductID`).
3. **Employees to Orders (1:N):** A sales employee can process many orders, each order is handled by one salesperson (`Orders.SalesPersonID -> Employees.EmployeeID`).
4. **Employees Self-Reference (1:N):** An employee can report to another employee who is their manager (`Employees.ManagerID -> Employees.EmployeeID`). One manager can supervise several employees.

---

## Assignment 5 - University Course Registration ERD

![University Registration ERD](University_Registration_ERD.png)

### Explanations:
1. **Instructors to Courses (1:N):** Each course is taught by one instructor, but an instructor can teach several courses.
2. **Students to Enrollments (1:N) & Courses to Enrollments (1:N):** Students and courses have a Many-to-Many relationship. The `Enrollments` table acts as a junction table connecting students and courses, storing enrollment date, grade, and status.
3. **Preventing duplicate registration:** Handled by a composite unique constraint `UNIQUE (StudentID, CourseID)` so that a student cannot register twice for the same course.
