# Use the official Tomcat 9 image
FROM tomcat:9.0

# Remove existing webapps directory
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your war file into the webapps directory of Tomcat
COPY bankapp.war /usr/local/tomcat/webapps/

# Expose port 8082
EXPOSE 8082

# CMD to start Tomcat
CMD ["catalina.sh", "run"]
