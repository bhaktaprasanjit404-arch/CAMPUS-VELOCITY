/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.capacityconnect.dao;

import com.capacityconnect.db.DBConnection;
import com.capacityconnect.model.Resource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class ResourceDAO {

    private Resource mapResource(ResultSet rs) throws SQLException {

        Resource resource = new Resource();

        resource.setId(rs.getInt("id"));
        resource.setTitle(rs.getString("title"));
        resource.setDescription(rs.getString("description"));
        resource.setCategory(rs.getString("category"));
        resource.setResourceType(rs.getString("resource_type"));
        resource.setFileUrl(rs.getString("file_url"));
        resource.setThumbnailUrl(rs.getString("thumbnail_url"));
        resource.setCreatedAt(rs.getTimestamp("created_at"));

        return resource;
    }

    public List<Resource> getResources(
            String search,
            String category,
            String type) throws SQLException {

        List<Resource> resources = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT id, title, description, category, resource_type, "
          + "file_url, thumbnail_url, created_at "
          + "FROM resources WHERE 1=1 "
        );

        List<Object> parameters = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(
                "AND (title LIKE ? OR description LIKE ? "
              + "OR category LIKE ?) "
            );

            String keyword = "%" + search.trim() + "%";

            parameters.add(keyword);
            parameters.add(keyword);
            parameters.add(keyword);
        }

        if (category != null
                && !category.trim().isEmpty()
                && !"All".equalsIgnoreCase(category.trim())) {

            sql.append("AND category = ? ");
            parameters.add(category.trim());
        }

        if (type != null
                && !type.trim().isEmpty()
                && !"All".equalsIgnoreCase(type.trim())) {

            sql.append("AND resource_type = ? ");
            parameters.add(type.trim());
        }

        sql.append("ORDER BY created_at DESC, id DESC");

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                statement.setObject(i + 1, parameters.get(i));
            }

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    resources.add(mapResource(rs));
                }
            }
        }

        return resources;
    }

    public Resource getResourceById(int id) throws SQLException {

        String sql =
            "SELECT id, title, description, category, resource_type, "
          + "file_url, thumbnail_url, created_at "
          + "FROM resources WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {
                    return mapResource(rs);
                }
            }
        }

        return null;
    }

    public List<String> getCategories() throws SQLException {

        List<String> categories = new ArrayList<>();

        String sql =
            "SELECT DISTINCT category FROM resources "
          + "WHERE category IS NOT NULL AND category <> '' "
          + "ORDER BY category";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        }

        return categories;
    }

    public int getResourceCount() throws SQLException {

        String sql = "SELECT COUNT(*) FROM resources";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }
}