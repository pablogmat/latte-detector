# Python image to use to compile the code.
FROM python:3.9.2 AS build-image

# Set the working directory to /app
WORKDIR /app

RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential gcc

#initialize virtualenv
RUN python -m venv /opt/venv

# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"

# copy the requirements file used for dependencies
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

#Build image using only the required code
FROM python:3.9.2-slim AS deploy-image

# Copy the rest of the working directory contents into the container at /app
COPY --from=build-image /opt/venv /opt/venv

# Set the working directory to /app
WORKDIR /app

# Run app.py when the container launches
ENV PATH="/opt/venv/bin:$PATH"
ENTRYPOINT ["python", "app.py"]
