from pathlib import Path

INPUT = Path("player.obj")
OUTPUT = Path("statue.obj")

SCALE = 10.0

with INPUT.open("r", encoding="utf-8") as f:
    lines = f.readlines()

output_lines = []

for line in lines:
    parts = line.split()

    if len(parts) >= 4 and parts[0] == "v":
        x = float(parts[1]) * SCALE
        y = float(parts[2]) * SCALE
        z = float(parts[3]) * SCALE

        output_lines.append(
            f"v {x} {y} {z}" + (" " + " ".join(parts[4:]) if len(parts) > 4 else "") + "\n"
        )
    else:
        output_lines.append(line)

with OUTPUT.open("w", encoding="utf-8") as f:
    f.writelines(output_lines)

print(f"Created {OUTPUT}")
print(f"Multiplied vertex coordinates by {SCALE:g}")
