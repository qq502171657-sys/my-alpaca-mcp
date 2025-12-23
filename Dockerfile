FROM python:3.11-slim
WORKDIR /app

# 确保所有依赖项已安装
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# 设置 PYTHONPATH 为当前目录
ENV PYTHONPATH=/app

EXPOSE 8000

# 变更启动逻辑：直接运行 server.py 文件
CMD ["python", "server.py", "--transport", "sse", "--host", "0.0.0.0", "--port", "8000"]