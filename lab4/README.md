# 📊 PROJECT REPORT - STUDENT MANAGEMENT SYSTEM

---

## 👨‍💻 STUDENT INFORMATION

- **Full Name:** Nguyen Viet Anh Khoa
- **Student ID:** ITCSIU22278
- **Completion Date:** November 10, 2025

---

## ✅ COMPLETED EXERCISES

### **Main Exercises:**

- [x] **Exercise 6: Validation Enhancement**
  - Enhanced regex patterns
  - Custom error messages
  - User-friendly validation feedback
  - Preserve form data after error

- [x] **Exercise 7: Pagination**
  - Student list pagination
  - 10 records per page
  - Previous/Next buttons
  - Clickable page numbers
  - SQL LIMIT and OFFSET
  - Dynamic total pages calculation

### **Advanced Exercises:**

- [ ] **Bonus 1: CSV Export**
  - Export student list to CSV file
  - *(Not completed)*

- [ ] **Bonus 2: Sortable Columns**
  - Sort by columns (ID, Name, Code, etc.)
  - Ascending/Descending order
  - *(Not completed)*

---

## 🚀 EXTRA FEATURES

Additional features added beyond requirements:

1. **Loading Indicator**
   - Display loading spinner when submitting form
   - Improve UX during request processing

2. **Responsive Design**
   - Responsive CSS for mobile/tablet
   - Scrollable table on small screens

3. **Success/Error Messages**
   - Success notification when add/edit/delete
   - Error notification with different colors
   - Auto-hide message after 5 seconds

4. **Enhanced UI/UX**
   - Modern card-based design
   - Color-coded buttons (Green=Add, Blue=Edit, Red=Delete)
   - Hover effects
   - Box shadows and border radius

5. **Data Validation**
   - Client-side validation (HTML5)
   - Server-side validation (Java regex)
   - Duplicate student code check
   - Enhanced email format validation

6. **Search with Pagination**
   - Pagination still works when searching
   - Preserve search keyword across pages
   - Display search results count

7. **Database Indexing**
   - UNIQUE constraint for student_code
   - AUTO_INCREMENT for ID
   - Timestamp for created_at

8. **Code Organization**
   - Separate process files (process_add.jsp, process_edit.jsp)
   - Reusable CSS styles
   - Clean code structure

---

## 🐛 KNOWN ISSUES

### **Fixed:**
1. ✅ ~~MySQL Access Denied Error~~ → Fixed by adding JDBC parameters
2. ✅ ~~Edit form missing ID parameter~~ → Fixed redirect URL
3. ✅ ~~Pagination not working~~ → Implemented LIMIT/OFFSET
4. ✅ ~~Search not preserving keyword~~ → Added URL parameter passing

### **Not Fixed:**
1. ❌ **CSV Export not implemented**
   - Need to add export to CSV functionality
   - Priority: Medium

2. ❌ **Sortable columns not implemented**
   - Need to add dynamic ORDER BY
   - Priority: Low

3. ❌ **No confirmation dialog when delete**
   - Should add JavaScript confirm() before deleting
   - Priority: High

4. ❌ **No authentication/authorization**
   - Anyone can access and edit
   - Priority: High (if deploying to production)

---

## ⏱️ TIME SPENT

**Total time:** Approximately 8-10 hours

### **Breakdown:**
- Environment setup (Tomcat, MySQL, Maven): 1 hour
- CRUD basic operations: 2 hours
- Database design and connection: 1 hour
- Form validation (client + server): 1.5 hours
- Search functionality: 1 hour
- Pagination: 1.5 hours
- UI/UX improvements: 1 hour
- Testing and bug fixes: 1 hour

---

## 📚 REFERENCES USED

### **Documentation:**
1. [Apache Tomcat 10 Documentation](https://tomcat.apache.org/tomcat-10.1-doc/)
   - Servlet specification
   - Deployment guide

2. [JSP Tutorial - JavaTpoint](https://www.javatpoint.com/jsp-tutorial)
   - JSP syntax
   - Implicit objects (request, response, session)

3. [MySQL 8.0 Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/)
   - SQL queries
   - LIMIT and OFFSET

4. [Maven Documentation](https://maven.apache.org/guides/index.html)
   - POM configuration
   - Build lifecycle

### **Tutorials:**
5. [W3Schools - JSP Forms](https://www.w3schools.com/jsp/)
   - Form handling
   - Request parameters

6. [Regex101](https://regex101.com/)
   - Testing regex patterns
   - Email validation regex

7. [Stack Overflow](https://stackoverflow.com/)
   - MySQL JDBC connection issues
   - JSP best practices

### **Tools:**
8. [Visual Studio Code](https://code.visualstudio.com/)
   - IDE for development

9. [DBeaver](https://dbeaver.io/) / MySQL Workbench
   - Database management
   - Query testing

---

## 🔧 TECHNOLOGIES USED

### **Backend:**
- JSP (JavaServer Pages)
- Java Servlet API
- JDBC (Java Database Connectivity)
- MySQL 8.0

### **Frontend:**
- HTML5
- CSS3
- JavaScript (minimal)

### **Build Tools:**
- Maven 3.x
- Apache Tomcat 10.1.48

### **Database:**
- MySQL 8.0
- JDBC Driver: mysql-connector-j 8.0.33

---

## 📝 ADDITIONAL NOTES

### **Project Strengths:**
- Clear code structure, easy to maintain
- Complete validation both client and server side
- User-friendly, modern UI/UX
- Good error handling
- Smooth search and pagination

### **Areas for Improvement:**
- Need to add authentication/authorization
- Implement CSV export
- Add sortable columns
- Add confirmation dialog when deleting
- Separate database connection into separate class
- Implement DAO pattern for cleaner code

### **Lessons Learned:**
- JSP should not contain too much Java code → Should use Servlet + JSP
- Regex validation is very important for security
- Pagination must calculate total records first
- JDBC connection must be closed in finally block
- Error handling needs redirect with clear message

---