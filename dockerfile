# Use the official PHP with Apache image as base
FROM php:apache

# Set the working directory in the container
WORKDIR /var/www/html

# Copy PHP files to the working directory in the container
COPY web.php login.php ./

# Copy CSS file and create a directory for it
COPY login.css ./css/

# Expose port 80 to the outside world
EXPOSE 80

# Start Apache server when the container launches
CMD ["apache2-foreground"]
