package com.indianhistory.model;

import java.sql.Timestamp;

public class User {
    private int       id;
    private String    username;
    private String    email;
    private String    passwordHash;
    private String    fullName;
    private String    role;          // "USER" or "ADMIN"
    private String    profilePic;
    private Timestamp createdAt;
    private Timestamp lastLogin;
    private boolean   isActive;

    public User() {}

    // ── Getters ──────────────────────────────────────────────
    public int       getId()           { return id; }
    public String    getUsername()     { return username; }
    public String    getEmail()        { return email; }
    public String    getPasswordHash() { return passwordHash; }
    public String    getFullName()     { return fullName; }
    public String    getRole()         { return role; }
    public String    getProfilePic()   { return profilePic; }
    public Timestamp getCreatedAt()    { return createdAt; }
    public Timestamp getLastLogin()    { return lastLogin; }
    public boolean   isActive()        { return isActive; }

    // ── Setters ──────────────────────────────────────────────
    public void setId(int id)                     { this.id = id; }
    public void setUsername(String username)       { this.username = username; }
    public void setEmail(String email)             { this.email = email; }
    public void setPasswordHash(String hash)       { this.passwordHash = hash; }
    public void setFullName(String fullName)       { this.fullName = fullName; }
    public void setRole(String role)               { this.role = role; }
    public void setProfilePic(String profilePic)   { this.profilePic = profilePic; }
    public void setCreatedAt(Timestamp createdAt)  { this.createdAt = createdAt; }
    public void setLastLogin(Timestamp lastLogin)  { this.lastLogin = lastLogin; }
    public void setActive(boolean active)          { this.isActive = active; }

    public boolean isAdmin() { return "ADMIN".equalsIgnoreCase(role); }
}
