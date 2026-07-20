package com.indianhistory.servlet;

import com.indianhistory.dao.StoryDAO;
import com.indianhistory.dao.TopicDAO;
import com.indianhistory.dao.UserDAO;
import com.indianhistory.model.Story;
import com.indianhistory.model.Topic;
import com.indianhistory.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final StoryDAO storyDAO = new StoryDAO();
    private final TopicDAO topicDAO = new TopicDAO();
    private final UserDAO  userDAO  = new UserDAO();

    // ── Guard: only ADMIN may access ─────────────────────────
    private boolean isAdmin(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null) { res.sendRedirect(req.getContextPath() + "/auth/login"); return false; }
        User user = (User) session.getAttribute("loggedUser");
        if (user == null || !user.isAdmin()) { res.sendRedirect(req.getContextPath() + "/auth/login"); return false; }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (!isAdmin(req, res)) return;

        String path = req.getPathInfo();
        if (path == null) path = "/dashboard";

        if ("/dashboard".equals(path)) {
            showDashboard(req, res);
        } else if ("/stories".equals(path)) {
            listStories(req, res);
        } else if ("/story/add".equals(path)) {
            showAddStory(req, res);
        } else if ("/story/edit".equals(path)) {
            showEditStory(req, res);
        } else if ("/topics".equals(path)) {
            listTopics(req, res);
        } else if ("/users".equals(path)) {
            listUsers(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (!isAdmin(req, res)) return;
        req.setCharacterEncoding("UTF-8");

        String path = req.getPathInfo();
        if (path == null) path = "";

        if ("/story/save".equals(path)) {
            saveStory(req, res);
        } else if ("/story/delete".equals(path)) {
            deleteStory(req, res);
        } else if ("/topic/save".equals(path)) {
            saveTopic(req, res);
        } else if ("/user/toggle".equals(path)) {
            toggleUser(req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    // ── Dashboard ─────────────────────────────────────────────
    private void showDashboard(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            java.util.List<Story> allStories = storyDAO.getAllStoriesAdmin();
            req.setAttribute("totalStories",  allStories.size());
            req.setAttribute("totalTopics",   topicDAO.getAllTopics().size());
            req.setAttribute("totalUsers",    userDAO.getAllUsers().size());
            req.setAttribute("latestStories", allStories.subList(0, Math.min(5, allStories.size())));
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, res);
    }

    // ── Stories ───────────────────────────────────────────────
    private void listStories(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("stories", storyDAO.getAllStoriesAdmin());
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/stories.jsp").forward(req, res);
    }

    private void showAddStory(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("topics", topicDAO.getAllTopics());
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/story-form.jsp").forward(req, res);
    }

    private void showEditStory(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            req.setAttribute("story",  storyDAO.getStoryByIdAdmin(id));
            req.setAttribute("topics", topicDAO.getAllTopics());
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/story-form.jsp").forward(req, res);
    }

    private void saveStory(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String idStr = req.getParameter("id");
        User admin   = (User) req.getSession().getAttribute("loggedUser");

        Story story = new Story();
        story.setTopicId(Integer.parseInt(req.getParameter("topicId")));
        story.setTitle(req.getParameter("title"));
        story.setSummary(req.getParameter("summary"));
        story.setContent(req.getParameter("content"));
        story.setImageUrl(req.getParameter("imageUrl"));
        story.setEra(req.getParameter("era"));
        story.setPublished("on".equals(req.getParameter("isPublished")));
        story.setAuthorId(admin.getId());

        try {
            if (idStr != null && !idStr.isBlank()) {
                story.setId(Integer.parseInt(idStr));
                storyDAO.updateStory(story);
            } else {
                storyDAO.addStory(story);
            }
        } catch (Exception e) {
            // log silently
        }
        res.sendRedirect(req.getContextPath() + "/admin/stories");
    }

    private void deleteStory(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            storyDAO.deleteStory(Integer.parseInt(req.getParameter("id")));
        } catch (Exception ignored) {}
        res.sendRedirect(req.getContextPath() + "/admin/stories");
    }

    // ── Topics ────────────────────────────────────────────────
    private void listTopics(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("topics", topicDAO.getAllTopics());
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/topics.jsp").forward(req, res);
    }

    private void saveTopic(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String idStr = req.getParameter("id");
        Topic topic  = new Topic();
        topic.setName(req.getParameter("name"));
        topic.setSlug(req.getParameter("name").toLowerCase().replaceAll("\\s+", "-").replaceAll("[^a-z0-9-]", ""));
        topic.setDescription(req.getParameter("description"));
        topic.setIcon(req.getParameter("icon"));
        topic.setColor(req.getParameter("color"));

        try {
            if (idStr != null && !idStr.isBlank()) {
                topic.setId(Integer.parseInt(idStr));
                topicDAO.updateTopic(topic);
            } else {
                topicDAO.addTopic(topic);
            }
        } catch (Exception ignored) {}
        res.sendRedirect(req.getContextPath() + "/admin/topics");
    }

    // ── Users ─────────────────────────────────────────────────
    private void listUsers(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("users", userDAO.getAllUsers());
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, res);
    }

    private void toggleUser(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            userDAO.toggleUserActive(Integer.parseInt(req.getParameter("id")));
        } catch (Exception ignored) {}
        res.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
