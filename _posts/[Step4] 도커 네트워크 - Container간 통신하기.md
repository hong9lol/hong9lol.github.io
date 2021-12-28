---
layout: post
title: "Docker container network"
subtitle: "How each container communicates"
date: 2021-12-28 23:59:13 +0900
background: '/img/posts/01.jpg'
categories: [kube15]
---

# [Step4] 도커 네트워크 - Container간 통신하기

도커 네트워크에서 container간 통신을 하는 방법 대해 설명합니다.

Docker의 Network 구조를 간단히 도식화 하면 그림1과 같이 표현 할 수 있습니다. 

용어부터 설명을 해보자면 docker0는 container가 외부로 통신하기 위한 virtual ethernet bridge이고 veth는 각 container들의 virtual ethernet interface를 의미합니다. 

 

![**그림1**](/resource/[Step4] 도커 네트워크 - Container간 통신하기/1.png)

**그림1**

두 container가 통신을 하기위해선 docker0와 같은 virtual ethernet bridge를 통해야합니다.

아래 실습으로 container간 통신하는 방법을 간단히 진행해보겠습니다.

1. “my-network”이란 이름으로 도커 네트워크를 생성합니다.

```bash
$ docker network ls

NETWORK ID     NAME      DRIVER    SCOPE
760007d4eb74   bridge    bridge    local
834f2c807255   host      host      local
d755fa211f0e   none      null      local

$ **docker network create my-network**
$ docker network ls

NETWORK ID     NAME         DRIVER    SCOPE
760007d4eb74   bridge       bridge    local
834f2c807255   host         host      local
b682e7360d58   my-network   bridge    local
d755fa211f0e   none         null      local
```

1. 동작 확인을 위해 nginx 서버스를 webserver1 이름로 실행합니다.

```bash
$ docker run -d --name webserver1 --network mynetwork nginx:latest
```

1. 동일 네트워크를 갖는 ubuntu shell을 실행하고 nslookup과 curl로 테스트 합니다.  

```bash
$ docker run -it --rm --name net-tool --network my-network ubuntu bash
```

[테스트 결과]

![Untitled](/resource/[Step4] 도커 네트워크 - Container간 통신하기/2.png)

1. 다른 네트워크를 갖는 ubuntu shell을 실행하고 nslookup과 curl로 테스트 합니다.  

```bash
docker run -it --rm --name net-tool --network **bridge** ubuntu bash
```

[테스트 결과]

![Untitled](/resource/[Step4] 도커 네트워크 - Container간 통신하기/3.png)
