# --- Base image ---
FROM python:3.11-slim

# --- Set environment variables ---
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    VENV_PATH=/opt/venv

# --- Create virtual environment ---
RUN python -m venv $VENV_PATH
ENV PATH="$VENV_PATH/bin:$PATH"

# --- Set working directory ---
WORKDIR /app

# --- Copy and install dependencies ---
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# --- Copy application code ---
COPY . .

# --- Expose FastAPI port ---
EXPOSE 8000

# --- Command to run the API ---
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

