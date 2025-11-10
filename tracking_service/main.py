from fastapi import FastAPI # type: ignore
import csv
import time
import hashlib
import random

app = FastAPI()

# Load CSV data on startup
def load_tracking_data():
    data = {
        'names': [],
        'addresses': [],
        'descriptions': [],
        'states': []
    }
    
    with open('tracking_database.csv', 'r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            data['names'].append(row['names'])
            data['addresses'].append(row['addresses'])
            data['descriptions'].append(row['packages_descriptions'])
            data['states'].append(row['states'])
    
    return data

TRACKING_DATA = load_tracking_data()

# Simulate CPU and RAM load function
def simulate_cpu_ram_load():    
    # Phase 1: Generate massive data (RAM)
    items = []
    for i in range(10_000):
        item = {
            'id': f'item{i:06d}',
            'data': ''.join(random.choices('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', k=100)),
            'timestamp': time.time()
        }
        items.append(item)
    
    # Phase 2: Hash each packet (CPU)
    hashed_items = []
    for item in items:
        hash_val = hashlib.sha256(str(item).encode()).hexdigest()
        hashed_items.append((item['id'], hash_val))
    
    # Phase 3: Sort by hash (CPU)
    hashed_items.sort(key=lambda x: x[1])

@app.get("/")
def root():
    return {"message": "Tracking service active"}

@app.get("/packages/{package_id}/track")
def package_track(package_id: str):
    simulate_cpu_ram_load()
    return {
        "package_id": package_id,
        "sender_name": random.choice(TRACKING_DATA['names']),
        "sender_address": random.choice(TRACKING_DATA['addresses']),
        "recipient_name": random.choice(TRACKING_DATA['names']),
        "recipient_address": random.choice(TRACKING_DATA['addresses']),
        "package_description": random.choice(TRACKING_DATA['descriptions']),
        "state": random.choice(TRACKING_DATA['states'])
    }