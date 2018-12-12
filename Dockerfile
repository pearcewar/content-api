# base 단계 - 거의 변경되지 않을 환경 설정
FROM node:alpine AS base
RUN apk -U add curl
WORKDIR /usr/src/app
EXPOSE 3001

# build 단계 - 응용 프로그램을 생성하는데 필요한 모든 도구와 중간 파일 포함
FROM node:argon AS build
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
RUN npm install
COPY . /usr/src/app

# 마지막 단계 - base 이미지를 build 단계의 출력 내용과 결합
FROM base AS final
WORKDIR /usr/src/app
COPY --from=build /usr/src/app .
CMD [ "npm", "start" ]
