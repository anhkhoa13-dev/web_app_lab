<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
        h1 { color: #333; }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
        tr:hover { background-color: #f8f9fa; }
        .action-link {
            color: #007bff;
            text-decoration: none;
            margin-right: 10px;
        }
        .delete-link { color: #dc3545; }
        .search-box {
            margin-bottom: 20px;
            background: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .search-box input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-right: 10px;
        }
        .search-box button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .search-box .clear-btn {
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
            padding: 20px;
            background: white;
            border-radius: 5px;
        }
        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .pagination a:hover {
            background-color: #0056b3;
        }
        .pagination strong {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            background-color: #28a745;
            color: white;
            border-radius: 5px;
        }
        .pagination .disabled {
            background-color: #6c757d;
            cursor: not-allowed;
            opacity: 0.5;
        }
    </style>
</head>
<body>
    <h1>📚 Student Management System</h1>
    
    <!-- Search Form -->
    <div class="search-box">
        <form action="list_students.jsp" method="GET" style="display: inline;">
            <input type="text" name="keyword" placeholder="🔍 Search by name or student code..." 
                   value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
            <button type="submit">Search</button>
            <a href="list_students.jsp" class="clear-btn">Clear</a>
        </form>
    </div>
    
    <% if (request.getParameter("message") != null) { %>
        <div class="message success">
            <%= request.getParameter("message") %>
        </div>
    <% } %>
    
    <% if (request.getParameter("error") != null) { %>
        <div class="message error">
            <%= request.getParameter("error") %>
        </div>
    <% } %>
    
    <a href="add_student.jsp" class="btn">➕ Add New Student</a>
    
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Student Code</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Major</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet countRs = null;
    
    // Pagination parameters
    String pageParam = request.getParameter("page");
    int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
    int recordsPerPage = 10;
    int offset = (currentPage - 1) * recordsPerPage;
    
    // Get search keyword
    String keyword = request.getParameter("keyword");
    
    int totalRecords = 0;
    int totalPages = 0;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/student_management?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
            "root",
            "123456"
        );
        
        String sql;
        String countSql;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            // Count total records for search
            countSql = "SELECT COUNT(*) as total FROM students WHERE full_name LIKE ? OR student_code LIKE ?";
            pstmt = conn.prepareStatement(countSql);
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            countRs = pstmt.executeQuery();
            if (countRs.next()) {
                totalRecords = countRs.getInt("total");
            }
            countRs.close();
            pstmt.close();
            
            // Search query with pagination
            sql = "SELECT * FROM students WHERE full_name LIKE ? OR student_code LIKE ? ORDER BY id DESC LIMIT ? OFFSET ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            pstmt.setInt(3, recordsPerPage);
            pstmt.setInt(4, offset);
            rs = pstmt.executeQuery();
        } else {
            // Count total records
            countSql = "SELECT COUNT(*) as total FROM students";
            stmt = conn.createStatement();
            countRs = stmt.executeQuery(countSql);
            if (countRs.next()) {
                totalRecords = countRs.getInt("total");
            }
            countRs.close();
            stmt.close();
            
            // Normal query with pagination
            sql = "SELECT * FROM students ORDER BY id DESC LIMIT ? OFFSET ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, recordsPerPage);
            pstmt.setInt(2, offset);
            rs = pstmt.executeQuery();
        }
        
        // Calculate total pages
        totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        
        while (rs.next()) {
            int id = rs.getInt("id");
            String studentCode = rs.getString("student_code");
            String fullName = rs.getString("full_name");
            String email = rs.getString("email");
            String major = rs.getString("major");
            Timestamp createdAt = rs.getTimestamp("created_at");
%>
            <tr>
                <td><%= id %></td>
                <td><%= studentCode %></td>
                <td><%= fullName %></td>
                <td><%= email != null ? email : "N/A" %></td>
                <td><%= major != null ? major : "N/A" %></td>
                <td><%= createdAt %></td>
                <td>
                    <a href="edit_student.jsp?id=<%= id %>" class="action-link">✏️ Edit</a>
                    <a href="delete_student.jsp?id=<%= id %>" 
                       class="action-link delete-link"
                       onclick="return confirm('Are you sure?')">🗑️ Delete</a>
                </td>
            </tr>
<%
        }
    } catch (ClassNotFoundException e) {
        out.println("<tr><td colspan='7'>Error: JDBC Driver not found!</td></tr>");
        e.printStackTrace();
    } catch (SQLException e) {
        out.println("<tr><td colspan='7'>Database Error: " + e.getMessage() + "</td></tr>");
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (countRs != null) countRs.close();
            if (pstmt != null) pstmt.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
        </tbody>
    </table>
    
    <!-- Pagination -->
    <% if (totalPages > 1) { %>
    <div class="pagination">
        <% if (currentPage > 1) { %>
            <a href="list_students.jsp?page=<%= currentPage - 1 %><%= (keyword != null && !keyword.isEmpty()) ? "&keyword=" + keyword : "" %>">« Previous</a>
        <% } else { %>
            <a href="#" class="disabled">« Previous</a>
        <% } %>
        
        <% 
        // Show page numbers (with limit to avoid too many pages)
        int startPage = Math.max(1, currentPage - 2);
        int endPage = Math.min(totalPages, currentPage + 2);
        
        if (startPage > 1) {
            out.println("<a href='list_students.jsp?page=1" + ((keyword != null && !keyword.isEmpty()) ? "&keyword=" + keyword : "") + "'>1</a>");
            if (startPage > 2) {
                out.println("<span style='padding: 8px 12px;'>...</span>");
            }
        }
        
        for (int i = startPage; i <= endPage; i++) { 
            if (i == currentPage) { %>
                <strong><%= i %></strong>
            <% } else { %>
                <a href="list_students.jsp?page=<%= i %><%= (keyword != null && !keyword.isEmpty()) ? "&keyword=" + keyword : "" %>"><%= i %></a>
            <% } 
        }
        
        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                out.println("<span style='padding: 8px 12px;'>...</span>");
            }
            out.println("<a href='list_students.jsp?page=" + totalPages + ((keyword != null && !keyword.isEmpty()) ? "&keyword=" + keyword : "") + "'>" + totalPages + "</a>");
        }
        %>
        
        <% if (currentPage < totalPages) { %>
            <a href="list_students.jsp?page=<%= currentPage + 1 %><%= (keyword != null && !keyword.isEmpty()) ? "&keyword=" + keyword : "" %>">Next »</a>
        <% } else { %>
            <a href="#" class="disabled">Next »</a>
        <% } %>
        
        <span style="margin-left: 20px; color: #666;">
            Page <%= currentPage %> of <%= totalPages %> (Total: <%= totalRecords %> students)
        </span>
    </div>
    <% } %>
</body>
</html>
