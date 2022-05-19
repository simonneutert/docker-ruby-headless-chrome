FROM ruby:2.7.6

RUN \
  apt-get update && \
  apt-get install -y build-essential unzip curl wget nodejs xvfb npm && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN \
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list && \
  apt-get update && \
  apt-get -y install google-chrome-stable && \
  npm install -g npm yarn

# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 80.0.3987.106
ENV CHROMEDRIVER_DIR /chromedriver
RUN mkdir $CHROMEDRIVER_DIR

# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH
