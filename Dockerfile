# Use a lightweight Python image
FROM python:3.11-slim


# Set working directory
WORKDIR /app

# Copy backend
COPY backend/ ./backend/

# Install dependencies
RUN pip install --no-cache-dir -r backend/requirements.txt

# Copy frontend (HTML, CSS, JS)
COPY frontend/ ./frontend/

# Expose backend port
EXPOSE 8000

# Run FastAPI backend
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]
