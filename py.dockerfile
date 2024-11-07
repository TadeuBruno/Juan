FROM python:3.9-slim

WORKDIR /app

# Instala o Git, as bibliotecas de desenvolvimento do PostgreSQL e o GCC
RUN apt-get update && apt-get install -y \
    git \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*  # Limpeza para reduzir o tamanho da imagem

# Clona o repositório e muda para o branch ENTREGA-FINAL
RUN git clone https://github.com/lab-invest/back-end.git /app/back-end \
    && cd /app/back-end \
    && git checkout ENTREGA-FINAL \
    && git pull origin ENTREGA-FINAL

# Copia apenas o arquivo requirements.txt para aproveitar o cache de dependências
WORKDIR /app/back-end
COPY back-end/requirements.txt /app/back-end/requirements.txt

# Instala as dependências do Python
RUN pip install --no-cache-dir -r requirements.txt

# Expõe a porta e define o comando para iniciar o servidor
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
