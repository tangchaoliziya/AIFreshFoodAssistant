FROM python:3.12-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# 先复制依赖文件，利用 Docker 缓存
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目文件
COPY backend/ ./backend/
COPY frontend/ ./frontend/
COPY data/ ./data/
COPY run.py ./
COPY view_memory.py ./

# 创建运行时需要的目录
RUN mkdir -p recipes memory

# 暴露端口（Railway 会通过 PORT 环境变量指定实际端口）
EXPOSE 8000

# 启动命令
CMD ["python", "run.py"]
