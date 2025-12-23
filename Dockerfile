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

# 1. 确保 PYTHONPATH 包含 src 目录，这样才能找到 alpaca_mcp_server 包
ENV PYTHONPATH=/app/src

EXPOSE 8000

# 2. 关键：使用 -m 模块化启动，不要直接运行文件路径
CMD ["python", "-m", "alpaca_mcp_server.server", "--transport", "sse", "--host", "0.0.0.0", "--port", "8000"]
