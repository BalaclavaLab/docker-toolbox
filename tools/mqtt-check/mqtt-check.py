#!/usr/bin/env python3
import os
import paho.mqtt.client as mqtt
from time import sleep

def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))
    client.publish("sub/user/"+mqtt_user, "mqtt status=0")

def on_publish(client, userdata, mid):
    print("Metric sent!")
    sleep(30)
    client.publish("sub/user/"+mqtt_user, "mqtt status=0")

mqtt_host = str(os.getenv('MQTT_INTERNAL_SERVICE_HOST'))
mqtt_port = int(os.getenv('MQTT_INTERNAL_SERVICE_PORT'))

mqtt_user = str(os.getenv('MQTT_USERNAME'))
mqtt_pass = str(os.getenv('MQTT_PASSWORD'))
mqtt_client_id = str(os.getenv('MQTT_CLIENT_ID')) + "_internal"

client = mqtt.Client(client_id=mqtt_client_id)
client.on_connect = on_connect
client.on_publish = on_publish

client.username_pw_set(username=mqtt_user, password=mqtt_pass)

client.connect(mqtt_host, mqtt_port, 60)
client.loop_forever()

