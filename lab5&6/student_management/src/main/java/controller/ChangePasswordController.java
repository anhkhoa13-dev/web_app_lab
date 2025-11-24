package controller;

import dao.UserDAO;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            resp.sendRedirect("login");
            return;
        }
        req.getRequestDispatcher("/views/change-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");

        // 1. Check login
        if (currentUser == null) {
            resp.sendRedirect("login");
            return;
        }

        // 2. Get parameters
        String currentPassword = req.getParameter("currentPassword"); // Mật khẩu nhập vào (plain text)
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        // 3. Validate basic input (Rỗng)
        if (currentPassword == null || newPassword == null || confirmPassword == null ||
                currentPassword.isEmpty() || newPassword.isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
            req.getRequestDispatcher("/views/change-password.jsp").forward(req, resp);
            return;
        }

        // 4. Validate length
        if (newPassword.length() < 8) {
            req.setAttribute("error", "Mật khẩu mới phải tối thiểu 8 ký tự.");
            req.getRequestDispatcher("/views/change-password.jsp").forward(req, resp);
            return;
        }

        // 5. Validate match
        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            req.getRequestDispatcher("/views/change-password.jsp").forward(req, resp);
            return;
        }

        boolean checkPass = BCrypt.checkpw(currentPassword, currentUser.getPassword());

        if (!checkPass) {
            req.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            req.getRequestDispatcher("/views/change-password.jsp").forward(req, resp);
            return;
        }

        String hashedNewPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        boolean isUpdated = userDAO.updatePassword(currentUser.getId(), hashedNewPassword);

        if (isUpdated) {
            currentUser.setPassword(hashedNewPassword);
            session.setAttribute("user", currentUser);

            req.setAttribute("message", "Đổi mật khẩu thành công!");
        } else {
            req.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại.");
        }

        req.getRequestDispatcher("/views/change-password.jsp").forward(req, resp);
    }
}