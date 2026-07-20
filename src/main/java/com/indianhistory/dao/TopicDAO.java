package com.indianhistory.dao;

import com.indianhistory.model.Topic;
import com.indianhistory.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TopicDAO {

    public List<Topic> getAllTopics() throws SQLException {
        List<Topic> list = new ArrayList<>();
        String sql = "SELECT t.*, COUNT(s.id) AS story_count" +
                     " FROM topics t" +
                     " LEFT JOIN stories s ON s.topic_id = t.id AND s.is_published = TRUE" +
                     " GROUP BY t.id" +
                     " ORDER BY t.sort_order";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public Topic getTopicBySlug(String slug) throws SQLException {
        String sql = "SELECT * FROM topics WHERE slug = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, slug);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public Topic getTopicById(int id) throws SQLException {
        String sql = "SELECT * FROM topics WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean addTopic(Topic topic) throws SQLException {
        String sql = "INSERT INTO topics (name, slug, description, icon, color, sort_order) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, topic.getName());
            ps.setString(2, topic.getSlug());
            ps.setString(3, topic.getDescription());
            ps.setString(4, topic.getIcon());
            ps.setString(5, topic.getColor());
            ps.setInt(6, topic.getSortOrder());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateTopic(Topic topic) throws SQLException {
        String sql = "UPDATE topics SET name=?, description=?, icon=?, color=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, topic.getName());
            ps.setString(2, topic.getDescription());
            ps.setString(3, topic.getIcon());
            ps.setString(4, topic.getColor());
            ps.setInt(5, topic.getId());
            return ps.executeUpdate() > 0;
        }
    }

    private Topic mapRow(ResultSet rs) throws SQLException {
        Topic t = new Topic();
        t.setId(rs.getInt("id"));
        t.setName(rs.getString("name"));
        t.setSlug(rs.getString("slug"));
        t.setDescription(rs.getString("description"));
        t.setIcon(rs.getString("icon"));
        t.setColor(rs.getString("color"));
        t.setSortOrder(rs.getInt("sort_order"));
        t.setCreatedAt(rs.getTimestamp("created_at"));
        try { t.setStoryCount(rs.getInt("story_count")); } catch (SQLException ignored) {}
        return t;
    }
}
