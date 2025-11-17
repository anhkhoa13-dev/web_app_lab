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

                .message {
                    padding: 10px;
                    margin-bottom: 20px;
                    border-radius: 5px;
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
            </style>
        </head>

        <body>
            <h1>📚 Student Management System (MVC)</h1>

            <!-- Search Box -->
            <div class="search-box"
                style="background: white; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ddd;">
                <form action="student" method="get" style="display: flex; gap: 10px; align-items: center;">

                    <!-- Hidden action field -->
                    <input type="hidden" name="action" value="search">

                    <!-- Text input -->
                    <input type="text" name="keyword" placeholder="🔍 Search by name, code, email..." value="${keyword}"
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
                        <option value="Information Technology" ${selectedMajor=='Information Technology' ? 'selected'
                            : '' }>Information Technology</option>
                        <option value="Software Engineering" ${selectedMajor=='Software Engineering' ? 'selected' : ''
                            }>Software Engineering</option>
                        <option value="Business Administration" ${selectedMajor=='Business Administration' ? 'selected'
                            : '' }>Business Administration</option>
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

            <a href="student?action=new" class="btn">➕ Add New Student</a>

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

                        <th>Actions</th>
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
                            <td>
                                <a href="student?action=edit&id=${student.id}" class="action-link">✏️ Edit</a>
                                <a href="student?action=delete&id=${student.id}" class="action-link delete-link"
                                    onclick="return confirm('Are you sure?')">🗑️ Delete</a>
                            </td>
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
        </body>

        </html>