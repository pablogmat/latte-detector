# Python image to use to compile the code.
FROM python:3.9.2-slim AS build-image

# Set the working directory to /app
WORKDIR /app

RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential gcc


# copy the requirements file used for dependencies
COPY requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Copy the rest of the working directory contents into the container at /app
COPY . ./

ENTRYPOINT ["python", "app.py"]
