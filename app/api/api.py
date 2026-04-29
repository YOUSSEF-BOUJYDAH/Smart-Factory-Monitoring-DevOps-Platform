import os
import logging
from flask import Flask, request, jsonify
from prometheus_client import Counter, Gauge, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

SENSOR_MESSAGES_TOTAL = Counter(
    "sensor_messages_total",
    "Total number of sensor messages received"
)

TEMPERATURE_GAUGE = Gauge(
    "factory_temperature_celsius",
    "Latest temperature value received from industrial sensors"
)

PRESSURE_GAUGE = Gauge(
    "factory_pressure_bar",
    "Latest pressure value received from industrial sensors"
)

VIBRATION_GAUGE = Gauge(
    "factory_vibration_level",
    "Latest vibration value received from industrial sensors"
)


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "UP"}), 200


@app.route("/data", methods=["POST"])
def receive_data():
    data = request.get_json()

    if not data:
        return jsonify({"error": "No JSON payload received"}), 400

    temperature = data.get("temperature")
    pressure = data.get("pressure")
    vibration = data.get("vibration")

    if temperature is None or pressure is None or vibration is None:
        return jsonify({"error": "Missing required sensor fields"}), 400

    SENSOR_MESSAGES_TOTAL.inc()
    TEMPERATURE_GAUGE.set(float(temperature))
    PRESSURE_GAUGE.set(float(pressure))
    VIBRATION_GAUGE.set(float(vibration))

    logging.info("Sensor data received: %s", data)

    return jsonify({"status": "received", "data": data}), 200


@app.route("/metrics", methods=["GET"])
def metrics():
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}


if __name__ == "__main__":
    host = os.getenv("APP_HOST", "0.0.0.0")
    port = int(os.getenv("APP_PORT", "5000"))

    app.run(host=host, port=port)