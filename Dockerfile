# 使用官方Ubuntu 20.04作为基础镜像
FROM ubuntu:20.04

# 设置元数据
LABEL maintainer="chao.wang@tinno.com"
LABEL version="1.0"
LABEL description="Custom Ubuntu 20.04 development image"

# 设置环境变量以避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 更新软件包列表并安装常用软件
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    curl \
    wget \
    vim \
    git \
    build-essential \
    openssh-server \
    python3 \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# （可选）设置Python pip国内源
RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# 设置工作目录
WORKDIR /home/android

# 声明容器运行时希望暴露的端口（例如SSH）
EXPOSE 22

# 设置默认的启动命令
CMD ["/bin/bash"]
