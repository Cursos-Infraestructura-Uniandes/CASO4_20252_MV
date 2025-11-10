FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install dependencies directly
RUN pip install --no-cache-dir fastapi uvicorn[standard]

# Copy application files
COPY main.py .
COPY tracking_database.csv .

# Expose port 8000
EXPOSE 8000

# Command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]