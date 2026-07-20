package com.indianhistory.model;

import java.sql.Timestamp;

public class Story {
    private int       id;
    private int       topicId;
    private String    topicName;    // from JOIN
    private String    topicSlug;    // from JOIN
    private String    title;
    private String    slug;
    private String    summary;
    private String    content;
    private String    imageUrl;
    private String    era;
    private int       authorId;
    private String    authorName;   // from JOIN
    private int       viewCount;
    private boolean   isPublished;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Story() {}

    public int       getId()          { return id; }
    public int       getTopicId()     { return topicId; }
    public String    getTopicName()   { return topicName; }
    public String    getTopicSlug()   { return topicSlug; }
    public String    getTitle()       { return title; }
    public String    getSlug()        { return slug; }
    public String    getSummary()     { return summary; }
    public String    getContent()     { return content; }
    public String    getImageUrl()    { return imageUrl; }
    public String    getEra()         { return era; }
    public int       getAuthorId()    { return authorId; }
    public String    getAuthorName()  { return authorName; }
    public int       getViewCount()   { return viewCount; }
    public boolean   isPublished()    { return isPublished; }
    public Timestamp getCreatedAt()   { return createdAt; }
    public Timestamp getUpdatedAt()   { return updatedAt; }

    public void setId(int id)                      { this.id = id; }
    public void setTopicId(int topicId)            { this.topicId = topicId; }
    public void setTopicName(String topicName)     { this.topicName = topicName; }
    public void setTopicSlug(String topicSlug)     { this.topicSlug = topicSlug; }
    public void setTitle(String title)             { this.title = title; }
    public void setSlug(String slug)               { this.slug = slug; }
    public void setSummary(String summary)         { this.summary = summary; }
    public void setContent(String content)         { this.content = content; }
    public void setImageUrl(String imageUrl)       { this.imageUrl = imageUrl; }
    public void setEra(String era)                 { this.era = era; }
    public void setAuthorId(int authorId)          { this.authorId = authorId; }
    public void setAuthorName(String authorName)   { this.authorName = authorName; }
    public void setViewCount(int viewCount)        { this.viewCount = viewCount; }
    public void setPublished(boolean published)    { this.isPublished = published; }
    public void setCreatedAt(Timestamp createdAt)  { this.createdAt = createdAt; }
    public void setUpdatedAt(Timestamp updatedAt)  { this.updatedAt = updatedAt; }
}
