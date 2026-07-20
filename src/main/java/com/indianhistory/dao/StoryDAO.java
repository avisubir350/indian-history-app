package com.indianhistory.dao;

import com.indianhistory.model.Story;
import com.indianhistory.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StoryDAO {

    private static final String BASE_SELECT =
            "SELECT s.*, t.name AS topic_name, t.slug AS topic_slug," +
            " u.full_name AS author_name" +
            " FROM stories s" +
            " JOIN topics t ON t.id = s.topic_id" +
            " JOIN users  u ON u.id = s.author_id ";

    /** All published stories for a given topic slug. */
    public List<Story> getStoriesByTopic(String topicSlug) throws SQLException {
        List<Story> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE t.slug = ? AND s.is_published = TRUE ORDER BY s.created_at DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, topicSlug);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    /** Single story by slug, incrementing view count. */
    public Story getStoryBySlug(String slug) throws SQLException {
        String sql = BASE_SELECT + "WHERE s.slug = ? AND s.is_published = TRUE";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, slug);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Story story = mapRow(rs);
                    incrementViewCount(story.getId());
                    return story;
                }
            }
        }
        return null;
    }

    /** All stories (published + drafts) — admin view. */
    public List<Story> getAllStoriesAdmin() throws SQLException {
        List<Story> list = new ArrayList<>();
        String sql = BASE_SELECT + "ORDER BY s.created_at DESC";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public Story getStoryByIdAdmin(int id) throws SQLException {
        String sql = BASE_SELECT + "WHERE s.id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    /** Latest N published stories across all topics. */
    public List<Story> getLatestStories(int limit) throws SQLException {
        List<Story> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE s.is_published = TRUE ORDER BY s.created_at DESC LIMIT ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    /** Search stories by keyword. */
    public List<Story> searchStories(String keyword) throws SQLException {
        List<Story> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE s.is_published = TRUE AND (s.title LIKE ? OR s.summary LIKE ? OR s.content LIKE ?) ORDER BY s.view_count DESC";
        String kw  = "%" + keyword + "%";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    /** Admin: add new story. */
    public boolean addStory(Story story) throws SQLException {
        String sql =
                "INSERT INTO stories (topic_id, title, slug, summary, content, image_url, era, author_id, is_published)" +
                " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, story.getTopicId());
            ps.setString(2, story.getTitle());
            ps.setString(3, generateSlug(story.getTitle()));
            ps.setString(4, story.getSummary());
            ps.setString(5, story.getContent());
            ps.setString(6, story.getImageUrl());
            ps.setString(7, story.getEra());
            ps.setInt(8, story.getAuthorId());
            ps.setBoolean(9, story.isPublished());
            return ps.executeUpdate() > 0;
        }
    }

    /** Admin: update existing story. */
    public boolean updateStory(Story story) throws SQLException {
        String sql =
                "UPDATE stories" +
                " SET topic_id=?, title=?, summary=?, content=?, image_url=?, era=?, is_published=?" +
                " WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, story.getTopicId());
            ps.setString(2, story.getTitle());
            ps.setString(3, story.getSummary());
            ps.setString(4, story.getContent());
            ps.setString(5, story.getImageUrl());
            ps.setString(6, story.getEra());
            ps.setBoolean(7, story.isPublished());
            ps.setInt(8, story.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteStory(int id) throws SQLException {
        String sql = "DELETE FROM stories WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ── private helpers ──────────────────────────────────────
    private void incrementViewCount(int storyId) {
        String sql = "UPDATE stories SET view_count = view_count + 1 WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, storyId);
            ps.executeUpdate();
        } catch (SQLException ignored) {}
    }

    private String generateSlug(String title) {
        return title.toLowerCase()
                    .replaceAll("[^a-z0-9\\s-]", "")
                    .replaceAll("\\s+", "-")
                    .replaceAll("-+", "-")
                    .substring(0, Math.min(80, title.length()));
    }

    private Story mapRow(ResultSet rs) throws SQLException {
        Story s = new Story();
        s.setId(rs.getInt("id"));
        s.setTopicId(rs.getInt("topic_id"));
        s.setTopicName(rs.getString("topic_name"));
        s.setTopicSlug(rs.getString("topic_slug"));
        s.setTitle(rs.getString("title"));
        s.setSlug(rs.getString("slug"));
        s.setSummary(rs.getString("summary"));
        s.setContent(rs.getString("content"));
        s.setImageUrl(rs.getString("image_url"));
        s.setEra(rs.getString("era"));
        s.setAuthorId(rs.getInt("author_id"));
        s.setAuthorName(rs.getString("author_name"));
        s.setViewCount(rs.getInt("view_count"));
        s.setPublished(rs.getBoolean("is_published"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        s.setUpdatedAt(rs.getTimestamp("updated_at"));
        return s;
    }
}
