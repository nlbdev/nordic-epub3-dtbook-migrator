FROM python:3.11

# Install Java
RUN apt-get update \
    && apt-get install --no-install-recommends -y default-jre=2:1.17-74 \
    && rm -rf /var/lib/apt/lists/*

# Install Epubcheck
ADD https://github.com/w3c/epubcheck/releases/download/v5.1.0/epubcheck-5.1.0.zip /opt/epubcheck.zip
RUN unzip /opt/epubcheck.zip -d /opt && \
    rm /opt/epubcheck.zip && \
    mv /opt/epubcheck-* /opt/epubcheck
ENV EPUBCHECK_HOME=/opt/epubcheck

# Create app directory
WORKDIR /usr/src/app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install application
COPY src/ ./

# Run tests
RUN python run.py test

ENTRYPOINT [ "python", "run.py" ]
