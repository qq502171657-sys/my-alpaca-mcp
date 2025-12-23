# 使用官方 Python 运行时作为父镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 安装 uv (如果你的项目使用 uv 管理依赖)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# 复制依赖文件并安装
COPY pyproject.toml uv.lock ./
RUN uv pip install --system -r pyproject.toml

# 复制整个项目
COPY . .

# 关键修正：设置 PYTHONPATH 包含 src
ENV PYTHONPATH=/app/src

EXPOSE 8000

# 关键修正：使用完整的文件路径
CMD ["python", "src/alpaca_mcp_server/server.py", "--transport", "sse", "--host", "0.0.0.0", "--port", "8000"]
