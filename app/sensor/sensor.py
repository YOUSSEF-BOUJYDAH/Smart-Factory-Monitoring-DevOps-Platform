import os
import time
import random
import logging
import requests

API_URL = os.getenv("API_URL", "http://localhost:5000/data")
SENSOR_INTERVAL = int(os.getenv("SENSOR_INTERVAL", "3"))

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)


def generate_sensor_data():
    return {
        "temperature": round(random.uniform(20, 95), 2),
        "pressure": round(random.uniform(1, 8), 2),
        "vibration": round(random.uniform(0, 5), 2)
    }


def send_data(payload):
    try:
        response = requests.post(API_URL, json=payload, timeout=5)
        response.raise_for_status()
        logging.info("Data sent successfully: %s", payload)
    except requests.exceptions.RequestException as error:
        logging.error("Failed to send data: %s", error)


if __name__ == "__main__":
    logging.info("Starting industrial sensor simulator")
    logging.info("Sending data to %s every %s seconds", API_URL, SENSOR_INTERVAL)

    while True:
        sensor_data = generate_sensor_data()
        send_data(sensor_data)
        time.sleep(SENSOR_INTERVAL)