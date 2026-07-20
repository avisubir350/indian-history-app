package com.indianhistory.servlet;

import com.indianhistory.dao.StoryDAO;
import com.indianhistory.dao.TopicDAO;
import com.indianhistory.model.Topic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/topics/*")
public class TopicServlet extends HttpServlet {

    private final TopicDAO topicDAO = new TopicDAO();
    private final StoryDAO storyDAO = new StoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getPathInfo();   // e.g.  /ancient-india
        if (path == null || path.equals("/")) {
            res.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String slug = path.substring(1);   // strip leading /
        try {
            Topic topic = topicDAO.getTopicBySlug(slug);
            if (topic == null) {
                res.sendError(HttpServletResponse.SC_NOT_FOUND, "Topic not found.");
                return;
            }
            req.setAttribute("topic",   topic);
            req.setAttribute("stories", storyDAO.getStoriesByTopic(slug));
            req.getRequestDispatcher("/WEB-INF/views/topic.jsp").forward(req, res);

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/topic.jsp").forward(req, res);
        }
    }
}
