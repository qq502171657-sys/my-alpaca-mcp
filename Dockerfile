FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV PYTHONPATH=/app/src
EXPOSE 8000
# 扁平化后，直接运行根目录下的 server.py
CMD ["python", "src/alpaca_mcp_server/server.py", "--transport", "sse", "--host", "0.0.0.0", "--port", "8000"]