FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV PYTHONPATH=/app
EXPOSE 8000
# 扁平化后，文件直接在根目录，路径最严谨
CMD ["python", "server.py", "--transport", "sse", "--host", "0.0.0.0", "--port", "8000"]