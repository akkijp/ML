#!/bin/bash

echo Launch...
docker compose down
docker compose up --build -d
