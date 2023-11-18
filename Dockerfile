# Use an official Python runtime as a parent image
FROM python:3.10-buster

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# Set the working directory inside the container
WORKDIR /hexcent

#creating a directroy to store the static files
RUN mkdir -p /home/hexcent/staticfiles

# give permission for nginx to read static files
RUN chown -R "$USER":www-data /home/hexcent/staticfiles && chmod -R 0755 /home/hexcent/staticfiles

# Copy the requirements file into the container
COPY requirements.txt /hexcent/

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project code into the container
COPY . /hexcent/

# Expose the port the app runs on
EXPOSE 8000

# gunicorn
CMD ["gunicorn", "--config", "gunicorn-cfg.py", "onlinexam.wsgi"]


