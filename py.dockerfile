FROM python:3.9-slim

WORKDIR /app

RUN apt get install git
RUN git clone https://github.com/lab-invest/back-end.git
RUN cd back-end
RUN git checkout ENTREGA-FINAL
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--reload"]
