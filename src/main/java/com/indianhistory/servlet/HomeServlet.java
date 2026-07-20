package com.indianhistory.servlet;

import com.indianhistory.dao.StoryDAO;
import com.indianhistory.dao.TopicDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/")
public class HomeServlet extends HttpServlet {

    private final TopicDAO topicDAO = new TopicDAO();
    private final StoryDAO storyDAO = new StoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("topics",       topicDAO.getAllTopics());
            req.setAttribute("latestStories", storyDAO.getLatestStories(6));
        } catch (Exception e) {
            req.setAttribute("error", "Unable to load content: " + e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, res);
    }
}
