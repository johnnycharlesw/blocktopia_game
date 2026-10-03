from pathlib import Path

INPUT = Path("chest.obj")
OUTPUT = Path("chest_fixed.obj")

Y_OFFSET = -0.5

with INPUT.open("r", encoding="utf-8") as f:
    lines = f.readlines()

output_lines = []

for line in lines:
    parts = line.split()

    if len(parts) == 4 and parts[0] == "v":
        x = float(parts[1])
        y = float(parts[2])
        z = float(parts[3])

        y += Y_OFFSET

        output_lines.append(f"v {x} {y} {z}\n")
    else:
        output_lines.append(line)

with OUTPUT.open("w", encoding="utf-8") as f:
    f.writelines(output_lines)

print(f"Created {OUTPUT}")
print(f"Moved vertices by Y = {Y_OFFSET}")
