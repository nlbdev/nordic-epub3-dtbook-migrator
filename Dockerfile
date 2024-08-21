FROM python:3.11

# Install Java
RUN apt-get update \
    && apt-get install --no-install-recommends -y default-jre=2:1.17-74 \
    && rm -rf /var/lib/apt/lists/*

# Install Saxon
RUN mkdir -p /opt/saxon \
    && wget --progress=dot:giga "https://search.maven.org/remotecontent?filepath=net/sf/saxon/Saxon-HE/9.9.0-2/Saxon-HE-9.9.0-2.jar" -O /opt/saxon/saxon.jar

# Create app directory
WORKDIR /usr/src/app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install application
COPY src/ ./

# Run tests
RUN python run.py test

CMD python run.py
