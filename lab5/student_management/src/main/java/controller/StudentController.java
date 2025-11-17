package controller;

import dao.StudentDAO;
import model.Student;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/student")
public class StudentController extends HttpServlet {

    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();

        List<Student> results = studentDAO.searchStudents("john");
        System.out.println("Found " + results.size() + " students");
        for (Student s : results) {
            System.out.println(s);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listStudents(request, response);
                break;
            case "search":
                searchStudents(request, response);
                break;
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            case "filter-sort":
                filterAndSortStudents(request, response);
                break;
            default:
                listStudents(request, response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "insert";
        }

        switch (action) {
            case "insert":
                insertStudent(request, response);
                break;
            case "update":
                updateStudent(request, response);
                break;
            default:
                listStudents(request, response);
                break;
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudentById(id);

        request.setAttribute("student", student);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-form.jsp");
        dispatcher.forward(request, response);
    }

    private void insertStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get form parameters
        String code = request.getParameter("studentCode");
        String name = request.getParameter("fullName");
        String email = request.getParameter("email");
        String major = request.getParameter("major");

        Student student = new Student();
        student.setStudentCode(code);
        student.setFullName(name);
        student.setEmail(email);
        student.setMajor(major);

        // 2. Validate before insert
        if (!validateStudent(student, request)) {
            request.setAttribute("student", student);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-form.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // 3. Valid & insert student
        if (studentDAO.addStudent(student)) {
            response.sendRedirect("student?action=list&message=Student added successfully");
        } else {
            response.sendRedirect("student?action=list&error=Failed to add student");
        }
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("studentCode");
        String name = request.getParameter("fullName");
        String email = request.getParameter("email");
        String major = request.getParameter("major");

        Student student = new Student();
        student.setId(id);
        student.setFullName(name);
        student.setEmail(email);
        student.setMajor(major);
        student.setStudentCode(code);

        // 2. Validate before update
        if (!validateStudent(student, request)) {
            request.setAttribute("student", student); // keep data
            RequestDispatcher dispatcher = request.getRequestDispatcher("views/student-form.jsp");
            dispatcher.forward(request, response);
            return; // STOP
        }

        // 3. Update DB
        if (studentDAO.updateStudent(student)) {
            response.sendRedirect("student?action=list&message=Student updated successfully");
        } else {
            response.sendRedirect("student?action=list&error=Failed to update student");
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        if (studentDAO.deleteStudent(id)) {
            response.sendRedirect("student?action=list&message=Student deleted successfully");
        } else {
            response.sendRedirect("student?action=list&error=Failed to delete student");
        }
    }

    private void searchStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<Student> students = studentDAO.searchStudents(keyword.trim());

        request.setAttribute("students", students);
        request.setAttribute("keyword", keyword);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-list.jsp");
        dispatcher.forward(request, response);
    }

    private boolean validateStudent(Student student, HttpServletRequest request) {
        boolean isValid = true;

        // 1. Validate Student Code
        String code = student.getStudentCode();
        String codePattern = "[A-Z]{2}[0-9]{3,}";

        if (code == null || code.trim().isEmpty()) {
            request.setAttribute("errorCode", "Student code is required.");
            isValid = false;
        } else if (!code.matches(codePattern)) {
            request.setAttribute("errorCode", "Invalid code format. Use 2 uppercase letters + 3+ digits (e.g., SV001)");
            isValid = false;
        }

        // 2. Validate Full Name
        String name = student.getFullName();

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorName", "Full name is required.");
            isValid = false;
        } else if (name.trim().length() < 2) {
            request.setAttribute("errorName", "Full name must be at least 2 characters.");
            isValid = false;
        }

        // 3. Validate Email
        String email = student.getEmail();
        String emailPattern = "^[A-Za-z0-9+_.-]+@(.+)$";

        if (email != null && !email.trim().isEmpty()) {
            if (!email.matches(emailPattern)) {
                request.setAttribute("errorEmail", "Invalid email format.");
                isValid = false;
            }
        }

        // 4. Validate Major
        String major = student.getMajor();

        if (major == null || major.trim().isEmpty()) {
            request.setAttribute("errorMajor", "Major is required.");
            isValid = false;
        }

        return isValid;
    }

    private void filterAndSortStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String major = request.getParameter("major");
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order");

        List<Student> students = studentDAO.getStudentsFiltered(major, sortBy, order);

        request.setAttribute("students", students);
        request.setAttribute("selectedMajor", major);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("order", order);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/student-list.jsp");
        dispatcher.forward(request, response);
    }

}
