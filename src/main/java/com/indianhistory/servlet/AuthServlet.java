package com.indianhistory.servlet;

import com.indianhistory.dao.UserDAO;
import com.indianhistory.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    // ── GET: show login or register form ─────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "/login";

        if ("/register".equals(path)) {
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
        } else if ("/logout".equals(path)) {
            req.getSession().invalidate();
            res.sendRedirect(req.getContextPath() + "/");
        } else {
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
        }
    }

    // ── POST: handle login / register ────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String path = req.getPathInfo();
        if (path == null) path = "/login";

        if ("/login".equals(path)) {
            handleLogin(req, res);
        } else if ("/register".equals(path)) {
            handleRegister(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/auth/login");
        }
    }

    // ── Login ─────────────────────────────────────────────────
    private void handleLogin(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String identifier = req.getParameter("identifier");
        String password   = req.getParameter("password");

        if (identifier == null || identifier.isBlank() || password == null || password.isBlank()) {
            req.setAttribute("error", "Please fill in all fields.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
            return;
        }

        try {
            User user = userDAO.authenticate(identifier.trim(), password);
            if (user == null) {
                req.setAttribute("error", "Invalid username/email or password.");
                req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("loggedUser", user);
            session.setMaxInactiveInterval(60 * 60); // 1 hour

            if (user.isAdmin()) {
                res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                res.sendRedirect(req.getContextPath() + "/");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Login failed. Please try again.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
        }
    }

    // ── Register ──────────────────────────────────────────────
    private void handleRegister(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String fullName  = req.getParameter("fullName");
        String username  = req.getParameter("username");
        String email     = req.getParameter("email");
        String password  = req.getParameter("password");
        String confirm   = req.getParameter("confirmPassword");

        // Validation
        if (isBlank(fullName, username, email, password, confirm)) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
            return;
        }
        if (!password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
            return;
        }
        if (password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters.");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
            return;
        }

        try {
            if (userDAO.usernameExists(username.trim())) {
                req.setAttribute("error", "Username '" + username + "' is already taken.");
                req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
                return;
            }
            if (userDAO.emailExists(email.trim())) {
                req.setAttribute("error", "An account with this email already exists.");
                req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
                return;
            }

            User user = new User();
            user.setFullName(fullName.trim());
            user.setUsername(username.trim());
            user.setEmail(email.trim().toLowerCase());
            user.setPasswordHash(password); // DAO will hash it

            if (userDAO.registerUser(user)) {
                req.setAttribute("success", "Account created! You can now log in.");
                req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, res);
            } else {
                req.setAttribute("error", "Registration failed. Please try again.");
                req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
            }

        } catch (Exception e) {
            req.setAttribute("error", "Registration error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
        }
    }

    private boolean isBlank(String... values) {
        for (String v : values) if (v == null || v.isBlank()) return true;
        return false;
    }
}
