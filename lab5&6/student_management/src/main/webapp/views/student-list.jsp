<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Student List</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 20px;
                    background-color: #f5f5f5;
                }

                h1 {
                    color: #333;
                }

                th a {
                    color: white;
                    text-decoration: none;
                }

                th a:hover {
                    text-decoration: underline;
                }

                .navbar {
                    background: #2c3e50;
                    color: white;
                    padding: 15px 30px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .navbar h2 {
                    font-size: 20px;
                }

                .navbar-right {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                }

                .user-info {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .role-badge {
                    padding: 4px 12px;
                    border-radius: 12px;
                    font-size: 12px;
                    font-weight: 600;
                }

                .role-admin {
                    background: #e74c3c;
                }

                .role-user {
                    background: #3498db;
                }

                .message {
                    padding: 10px;
                    margin-bottom: 20px;
                    border-radius: 5px;
                }

                .btn-nav {
                    background: #1abc9c;
                    color: white;
                }


                .success {
                    background-color: #d4edda;
                    color: #155724;
                }

                .error {
                    background-color: #f8d7da;
                    color: #721c24;
                }

                .btn {
                    display: inline-block;
                    padding: 10px 20px;
                    margin-bottom: 20px;
                    background-color: #007bff;
                    color: white;
                    text-decoration: none;
                    border-radius: 5px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    background-color: white;
                }

                th {
                    background-color: #007bff;
                    color: white;
                    padding: 12px;
                    text-align: left;
                }

                td {
                    padding: 10px;
                    border-bottom: 1px solid #ddd;
                }

                tr:hover {
                    background-color: #f8f9fa;
                }

                .action-link {
                    color: #007bff;
                    text-decoration: none;
                    margin-right: 10px;
                }

                .delete-link {
                    color: #dc3545;
                }

                /* ========== BUTTONS COMMON STYLE ========== */
                .btn,
                .btn-add,
                .btn-edit,
                .btn-delete,
                .btn-nav,
                .btn-logout {
                    display: inline-block;
                    padding: 10px 18px;
                    border-radius: 6px;
                    text-decoration: none;
                    font-size: 14px;
                    font-weight: 600;
                    transition: 0.2s;
                }

                /* ========== NAVBAR BUTTONS ========== */
                .btn-nav {
                    background: #1abc9c;
                    color: white;
                }

                .btn-nav:hover {
                    background: #17a589;
                }

                .btn-logout {
                    background: #e74c3c;
                    color: white;
                }

                .btn-logout:hover {
                    background: #c0392b;
                }

                /* ========== ADD BUTTON ========== */
                .btn-add {
                    background: #28a745;
                    color: white;
                }

                .btn-add:hover {
                    background: #218838;
                }

                /* ========== ACTION BUTTONS (EDIT/DELETE) ========== */
                .btn-edit {
                    background: #f1c40f;
                    color: #333;
                    padding: 6px 12px;
                    font-size: 13px;
                }

                .btn-edit:hover {
                    background: #d4ac0d;
                }

                .btn-delete {
                    background: #e74c3c;
                    color: white;
                    padding: 6px 12px;
                    font-size: 13px;
                }

                .btn-delete:hover {
                    background: #c0392b;
                }

                /* Container wrapper */
                .container {
                    background: white;
                    margin-top: 20px;
                    padding: 25px 30px;
                    border-radius: 8px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                }

                /* ===== Table style polish ===== */
                table {
                    width: 100%;
                    border-collapse: collapse;
                    background-color: white;
                    border-radius: 8px;
                    overflow: hidden;
                }

                th {
                    background-color: #007bff;
                    color: white;
                    padding: 12px;
                    text-align: left;
                    font-size: 14px;
                }

                td {
                    padding: 12px;
                    border-bottom: 1px solid #e0e0e0;
                }

                tr:hover {
                    background-color: #f1f3f5;
                }

                /* Fix search & filter box readability */
                .search-box,
                .filter-box {
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
                }

                /* Role badge better UI */
                .role-badge {
                    color: white;
                    padding: 4px 10px;
                    border-radius: 12px;
                    font-size: 12px;
                    text-transform: capitalize;
                }

                .role-admin {
                    background: #e74c3c;
                }

                .role-user {
                    background: #3498db;
                }

                /* Success & Error message refine */
                .message.success {
                    border-left: 4px solid #28a745;
                }

                .message.error {
                    border-left: 4px solid #e74c3c;
                }
            </style>
        </head>

        <body>
            <div class="navbar">
                <h2>📚 Student Management System</h2>
                <div class="navbar-right">
                    <div class="user-info">
                        <span>Welcome, ${sessionScope.fullName}</span>
                        <span class="role-badge role-${sessionScope.role}">
                            ${sessionScope.role}
                        </span>
                    </div>
                    <a href="dashboard" class="btn-nav">Dashboard</a>
                    <a href="logout" class="btn-logout">Logout</a>
                </div>
            </div>

            <div class="container">


                <h1>📚 Student Management System (MVC)</h1>



                <!-- Search Box -->
                <div class="search-box"
                    style="background: white; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ddd;">
                    <form action="student" method="get" style="display: flex; gap: 10px; align-items: center;">

                        <!-- Hidden action field -->
                        <input type="hidden" name="action" value="search">

                        <!-- Text input -->
                        <input type="text" name="keyword" placeholder="🔍 Search by name, code, email..."
                            value="${keyword}"
                            style="flex: 1; padding: 10px; border: 1px solid #ccc; border-radius: 5px;">

                        <!-- Submit -->
                        <button type="submit"
                            style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;">
                            Search
                        </button>

                        <!-- Clear button (ONLY show when searching) -->
                        <c:if test="${not empty keyword}">
                            <a href="student"
                                style="padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 5px;">
                                Show All
                            </a>
                        </c:if>

                    </form>

                    <!-- Search message -->
                    <c:if test="${not empty keyword}">
                        <div style="margin-top: 10px; color: #555;">
                            Search results for: <strong>${keyword}</strong>
                        </div>
                    </c:if>
                </div>

                <!-- FILTER BY MAJOR -->
                <div class="filter-box"
                    style="background: white; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ddd;">
                    <form action="student" method="get" style="display: flex; gap: 10px; align-items: center;">
                        <input type="hidden" name="action" value="filter-sort">

                        <label style="font-weight: bold;">Filter by Major:</label>
                        <select name="major" style="padding: 8px; border-radius: 5px;">
                            <option value="">All Majors</option>

                            <option value="Computer Science" ${selectedMajor=='Computer Science' ? 'selected' : '' }>
                                Computer Science</option>
                            <option value="Information Technology" ${selectedMajor=='Information Technology'
                                ? 'selected' : '' }>Information Technology</option>
                            <option value="Software Engineering" ${selectedMajor=='Software Engineering' ? 'selected'
                                : '' }>Software Engineering</option>
                            <option value="Business Administration" ${selectedMajor=='Business Administration'
                                ? 'selected' : '' }>Business Administration</option>
                        </select>

                        <button type="submit"
                            style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 5px;">
                            Apply
                        </button>

                        <c:if test="${not empty selectedMajor}">
                            <a href="student?action=list"
                                style="padding: 10px 20px; background: #6c757d; color: white; border-radius: 5px; text-decoration: none;">
                                Clear
                            </a>
                        </c:if>
                    </form>

                    <!-- Show active filter -->
                    <c:if test="${not empty selectedMajor}">
                        <div style="margin-top: 10px;">
                            Filtering by: <strong>${selectedMajor}</strong>
                        </div>
                    </c:if>
                </div>


                <c:if test="${not empty param.message}">
                    <div class="message success">
                        ${param.message}
                    </div>
                </c:if>

                <c:if test="${not empty param.error}">
                    <div class="message error">
                        ${param.error}
                    </div>
                </c:if>

                <c:if test="${sessionScope.role eq 'admin'}">
                    <div style="margin: 20px 0;">
                        <a href="student?action=new" class="btn-add">➕ Add New Student</a>
                    </div>
                </c:if>

                <table>
                    <thead>
                        <tr>
                            <!-- ID -->
                            <th>
                                <a
                                    href="student?action=filter-sort&sortBy=id&order=${order == 'asc' ? 'desc' : 'asc'}&major=${selectedMajor}">
                                    ID
                                    <c:if test="${sortBy == 'id'}">
                                        ${order == 'asc' ? '▲' : '▼'}
                                    </c:if>
                                </a>
                            </th>

                            <!-- Code -->
                            <th>
                                <a
                                    href="student?action=filter-sort&sortBy=student_code&order=${order == 'asc' ? 'desc' : 'asc'}&major=${selectedMajor}">
                                    Student Code
                                    <c:if test="${sortBy == 'student_code'}">
                                        ${order == 'asc' ? '▲' : '▼'}
                                    </c:if>
                                </a>
                            </th>

                            <!-- Name -->
                            <th>
                                <a
                                    href="student?action=filter-sort&sortBy=full_name&order=${order == 'asc' ? 'desc' : 'asc'}&major=${selectedMajor}">
                                    Full Name
                                    <c:if test="${sortBy == 'full_name'}">
                                        ${order == 'asc' ? '▲' : '▼'}
                                    </c:if>
                                </a>
                            </th>

                            <!-- Email -->
                            <th>
                                <a
                                    href="student?action=filter-sort&sortBy=email&order=${order == 'asc' ? 'desc' : 'asc'}&major=${selectedMajor}">
                                    Email
                                    <c:if test="${sortBy == 'email'}">
                                        ${order == 'asc' ? '▲' : '▼'}
                                    </c:if>
                                </a>
                            </th>

                            <!-- Major -->
                            <th>
                                <a
                                    href="student?action=filter-sort&sortBy=major&order=${order == 'asc' ? 'desc' : 'asc'}&major=${selectedMajor}">
                                    Major
                                    <c:if test="${sortBy == 'major'}">
                                        ${order == 'asc' ? '▲' : '▼'}
                                    </c:if>
                                </a>
                            </th>
                            <c:if test="${sessionScope.role eq 'admin'}">
                                <th>Actions</th>
                            </c:if>

                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="student" items="${students}">
                            <tr>
                                <td>${student.id}</td>
                                <td>${student.studentCode}</td>
                                <td>${student.fullName}</td>
                                <td>${student.email != null ? student.email : 'N/A'}</td>
                                <td>${student.major != null ? student.major : 'N/A'}</td>

                                <!-- Action buttons - Admin only -->
                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <td>
                                        <a href="student?action=edit&id=${student.id}" class="btn-edit">Edit</a>
                                        <a href="student?action=delete&id=${student.id}" class="btn-delete"
                                            onclick="return confirm('Delete this student?')">Delete</a>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty students}">
                            <tr>
                                <td colspan="6" style="text-align: center;">
                                    No students found.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </body>

        </html>