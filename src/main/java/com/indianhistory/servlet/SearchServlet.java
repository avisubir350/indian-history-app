package com.indianhistory.servlet;

import com.indianhistory.dao.StoryDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private final StoryDAO storyDAO = new StoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String keyword = req.getParameter("q");
        if (keyword != null && !keyword.isBlank()) {
            try {
                req.setAttribute("results", storyDAO.searchStories(keyword.trim()));
                req.setAttribute("keyword", keyword.trim());
            } catch (Exception e) {
                req.setAttribute("error", e.getMessage());
            }
        }
        req.getRequestDispatcher("/WEB-INF/views/search.jsp").forward(req, res);
    }
}
