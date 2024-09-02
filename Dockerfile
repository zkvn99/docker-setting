# Gradle과 JDK가 포함된 이미지 사용
FROM gradle:7.6-jdk17 AS builder

# 작업 디렉토리 설정
WORKDIR /app

# Gradle 빌드에 필요한 파일들을 복사
COPY build.gradle settings.gradle /app/
COPY src /app/src/

# Gradle 빌드
RUN gradle build --no-daemon

# 최종 이미지를 위한 단계
FROM openjdk:17-jdk

# 작업 디렉토리 설정
WORKDIR /app

# JAR 파일을 빌드 이미지로부터 복사
COPY --from=builder /app/build/libs/myapp.jar /app/myapp.jar

# 애플리케이션 실행
CMD ["java", "-jar", "myapp.jar"]
