#!/bin/sh
curl -d '{"mp":0,"gk":15,"fwd":15,"df":15,"mf":15}' -H 'Content-Type: application/json' -X POST http://localhost:3000/startGame
curl -d '{"name": "ATK Mohun Bagan", "money": 900}' -H 'Content-Type: application/json' -X POST http://localhost:3000/addTeam
curl -d '{"name": "Bengaluru FC", "money": 900}' -H 'Content-Type: application/json' -X POST http://localhost:3000/addTeam
curl -d '{"name": "Chennaiyin FC", "money": 900}' -H 'Content-Type: application/json' -X POST http://localhost:3000/addTeam
curl -d '{"name": "FC Goa", "money": 900}' -H 'Content-Type: application/json' -X POST http://localhost:3000/addTeam
curl -d '{"name": "Hyderabad FC", "money": 900}' -H 'Content-Type: application/json' -X POST http://localhost:3000/addTeam
curl -d '{"name": "Kerala Blasters", "money": 900}' -H 'Content-Type: application/json' -X POST http://localhost:3000/addTeam
curl -d '{"name": "Mumbai City FC", "money": 900}' -H 'Content-Type: application/json' -X POST http://localhost:3000/addTeam
curl -d '{"name": "North East United", "money": 900}' -H 'Content-Type: application/json' -X POST http://localhost:3000/addTeam
