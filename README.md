# 🏛 Bharata Katha — Indian History Storytelling App

A full-featured Java Web Application for exploring and sharing Indian History stories.

---

## Tech Stack

| Layer        | Technology                         |
|--------------|-------------------------------------|
| Backend      | Java 21 + Servlets + JSP            |
| Frontend     | HTML5, CSS3, Vanilla JS, JSTL       |
| Database     | MySQL 8                             |
| Build Tool   | Apache Maven                        |
| Server       | Apache Tomcat 9/10                  |
| Fonts/Icons  | Google Fonts (Cinzel, Lora) + FontAwesome 6 |

---

## Features

### User Features
- ✅ Register / Login with BCrypt password hashing
- ✅ Browse history by Era/Topic
- ✅ Read full story articles with rich HTML content
- ✅ Search stories by keyword
- ✅ Responsive design (mobile-friendly)

### Admin Features
- ✅ Secure admin dashboard
- ✅ Add / Edit / Delete stories (with HTML content editor)
- ✅ Manage topics / eras
- ✅ View and ban/activate users
- ✅ Story publish/draft toggle

---

## Setup Instructions

### 1. Prerequisites
- Java 11+ JDK → https://adoptium.net
- Apache Maven → https://maven.apache.org
- MySQL 8 → https://dev.mysql.com/downloads/
- Apache Tomcat 9 → https://tomcat.apache.org

### 2. Database Setup
```sql
-- Run the schema file
mysql -u root -p < database/schema.sql
```

### 3. Configure DB connection
Edit `src/main/java/com/indianhistory/util/DBConnection.java`:
```java
private static final String DB_URL      = "jdbc:mysql://localhost:3306/indian_history_db?...";
private static final String DB_USER     = "root";
private static final String DB_PASSWORD = "your_password";
```

### 4. Build the WAR
```bash
mvn clean package
```

### 5. Deploy to Tomcat
Copy `target/indian-history-app.war` → `tomcat/webapps/`

Start Tomcat → Open: http://localhost:8080/indian-history-app/

---

## Default Credentials

| Role  | Username | Password   |
|-------|----------|------------|
| Admin | `admin`  | `Admin@123`|

---

## Project Structure

```
src/
├── main/
│   ├── java/com/indianhistory/
│   │   ├── dao/          ← Database Access Objects
│   │   ├── model/        ← POJO Models (User, Story, Topic)
│   │   ├── servlet/      ← HTTP Servlets (controllers)
│   │   └── util/         ← DBConnection utility
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── web.xml
│       │   └── views/    ← JSP pages (including admin/)
│       ├── css/          ← Stylesheets
│       └── js/           ← JavaScript
database/
└── schema.sql            ← Full MySQL schema + seed data
```
try this 
cd C:\Users\User\Desktop\Final
mvn clean package
copy /Y target\indian-history-app.war C:\xampp\tomcat\webapps\


 Restart Tomcat:
cmd
set CATALINA_HOME=C:\xampp\tomcat
C:\xampp\tomcat\bin\catalina.bat run

