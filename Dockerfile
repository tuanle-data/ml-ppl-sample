FROM jupyter/scipy-notebook

RUN pip install joblib

RUN mkdir model raw_data processed_data results

ENV RAW_DATA_DIR=./raw_data
ENV PROCESSED_DATA_DIR=./processed_data
ENV MODEL_DIR=./model
ENV RESULTS_DIR=./results
ENV RAW_DATA_FILE=adult.csv

COPY adult.csv ./raw_data/adult.csv
COPY preprocessing.py ./preprocessing.py
COPY train.py ./train.py
COPY test.py ./test.py