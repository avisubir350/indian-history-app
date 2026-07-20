# ============================================================
#  Bharata Katha — Indian History Storytelling App
#  Multi-stage Dockerfile
#  Stage 1: Build the WAR with Maven
#  Stage 2: Run on Tomcat 9 (slim, non-root)
# ============================================================

# ── Stage 1: Build ──────────────────────────────────────────
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy pom first — Docker cache layer for dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source and build
COPY src ./src
RUN mvn clean package -DskipTests -B

# ── Stage 2: Runtime ─────────────────────────────────────────
FROM tomcat:9.0-jdk21-openjdk-slim

LABEL maintainer="bharata-katha"
LABEL description="Indian History Storytelling Web App"
LABEL version="1.0.0"

# ── Security: remove default Tomcat webapps ──────────────────
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/manager \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/docs

# ── Security: run as non-root user ───────────────────────────
RUN groupadd --system appgroup \
 && useradd  --system --gid appgroup --no-create-home appuser \
 && chown -R appuser:appgroup /usr/local/tomcat

# ── Copy WAR from build stage ─────────────────────────────────
COPY --from=builder --chown=appuser:appgroup \
     /app/target/indian-history-app.war \
     /usr/local/tomcat/webapps/ROOT.war

USER appuser

EXPOSE 8080

# ── Health check ─────────────────────────────────────────────
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

CMD ["catalina.sh", "run"]
