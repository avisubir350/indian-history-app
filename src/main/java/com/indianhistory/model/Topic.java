package com.indianhistory.model;

import java.sql.Timestamp;

public class Topic {
    private int       id;
    private String    name;
    private String    slug;
    private String    description;
    private String    icon;
    private String    color;
    private int       sortOrder;
    private Timestamp createdAt;
    private int       storyCount;   // populated via JOIN, not a DB column

    public Topic() {}

    public int       getId()          { return id; }
    public String    getName()        { return name; }
    public String    getSlug()        { return slug; }
    public String    getDescription() { return description; }
    public String    getIcon()        { return icon; }
    public String    getColor()       { return color; }
    public int       getSortOrder()   { return sortOrder; }
    public Timestamp getCreatedAt()   { return createdAt; }
    public int       getStoryCount()  { return storyCount; }

    public void setId(int id)                     { this.id = id; }
    public void setName(String name)              { this.name = name; }
    public void setSlug(String slug)              { this.slug = slug; }
    public void setDescription(String desc)       { this.description = desc; }
    public void setIcon(String icon)              { this.icon = icon; }
    public void setColor(String color)            { this.color = color; }
    public void setSortOrder(int sortOrder)       { this.sortOrder = sortOrder; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public void setStoryCount(int storyCount)     { this.storyCount = storyCount; }
}
