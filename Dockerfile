FROM python:3.11-slim
WORKDIR /app

# 设置 Python 路径为当前工作目录，因为 alpaca_mcp_server 文件夹就在根目录
ENV PYTHONPATH=/app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

EXPOSE 8000

# 启动命令：确保指向根目录下的 alpaca_mcp_server 包
CMD ["python", "-m", "alpaca_mcp_server.server", "--transport", "sse", "--host", "0.0.0.0", "--port", "8000"]