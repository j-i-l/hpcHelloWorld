people = [
  {"name": "Jon Doe", "courses": ["math1", "pSciComp", "physics1"]},
  {"name": "Leonardo Da Vinci", "courses": ["math99", "cosmology7"]},
  {"name": "Mona Lisa", "courses": ["linalg3", "pSciComp"]},
]
course = 'pSciComp'
greetings = []
for person in people:
    if course in person['courses']:
        greetings.append(f"Hello {person['name']}\n")
with open('data/final/greeting.txt', 'w') as f:
    f.writelines(greetings)
