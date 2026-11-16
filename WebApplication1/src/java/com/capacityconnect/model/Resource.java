/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.capacityconnect.model;

import java.sql.Timestamp;

public class Resource {

    private int id;
    private String title;
    private String description;
    private String category;
    private String resourceType;
    private String fileUrl;
    private String thumbnailUrl;
    private Timestamp createdAt;

    public Resource() {
    }

    public Resource(int id, String title, String description,
                    String category, String resourceType,
                    String fileUrl, String thumbnailUrl,
                    Timestamp createdAt) {

        this.id = id;
        this.title = title;
        this.description = description;
        this.category = category;
        this.resourceType = resourceType;
        this.fileUrl = fileUrl;
        this.thumbnailUrl = thumbnailUrl;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getResourceType() {
        return resourceType;
    }

    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}