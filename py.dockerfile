FROM python:3.9-slim

WORKDIR /app

# Instala o Git
RUN apt-get update && apt-get install -y git

# Clona o repositório e muda para o branch ENTREGA-FINAL
RUN git clone https://github.com/lab-invest/back-end.git \
    && cd back-end \
    && git checkout ENTREGA-FINAL

# Instala as dependências do Python
WORKDIR /app/back-end
RUN pip install --no-cache-dir -r requirements.txt

# Expõe a porta e define o comando para iniciar o servidor
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
