FROM openjdk:8

#Install Android Sdk Tools
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip

RUN mkdir -p /opt/android-sdk && \
		curl $ANDROID_SDK_URL -o sdk.zip && \
		unzip sdk.zip -d /opt/android-sdk && \
		rm sdk.zip

ENV ANDROID_HOME /opt/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/tools/bin

RUN yes | sdkmanager --licenses && \
		sdkmanager "platform-tools" "extras;android;m2repository" "platforms;android-23" "build-tools;23.0.1"
ENV PATH $PATH:$ANDROID_HOME/platform-tools

RUN apt-get update && apt-get install -y lib32stdc++6 lib32z1 jq

# Install Gradle
ENV GRADLE_VERSION 2.14.1
RUN cd /usr/local \
 && curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-bin.zip \
 && unzip "gradle-bin.zip" \
 && ln -s "/usr/local/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle-bin.zip"

ENV GRADLE_HOME /usr/local/gradle
ENV PATH $PATH:$GRADLE_HOME/bin