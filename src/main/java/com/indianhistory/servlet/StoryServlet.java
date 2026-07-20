package com.indianhistory.servlet;

import com.indianhistory.dao.StoryDAO;
import com.indianhistory.model.Story;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/story/*")
public class StoryServlet extends HttpServlet {

    private final StoryDAO storyDAO = new StoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            res.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String slug = path.substring(1);
        try {
            Story story = storyDAO.getStoryBySlug(slug);
            if (story == null) {
                res.sendError(HttpServletResponse.SC_NOT_FOUND, "Story not found.");
                return;
            }
            req.setAttribute("story", story);
            req.getRequestDispatcher("/WEB-INF/views/story.jsp").forward(req, res);

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/story.jsp").forward(req, res);
        }
    }
}
