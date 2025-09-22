import re

with open('filelist.txt') as f:
    files = [line.strip() for line in f if line.strip()]

title_pattern = re.compile(r'^(title:\s*)(["\']?)(.*?)(["\']?)\s*$', re.IGNORECASE)

for file in files:
    with open(file, encoding='utf-8') as f:
        lines = f.readlines()
    new_lines = []
    in_yaml = False
    yaml_count = 0
    for line in lines:
        if line.strip() == "---":
            yaml_count += 1
            if yaml_count <= 2:
                in_yaml = yaml_count == 1
            else:
                in_yaml = False
            new_lines.append(line)
            continue
        if in_yaml:
            m = title_pattern.match(line.strip())
            if m:
                title_text = m.group(3).strip().strip('"').strip("'")
                line = f'{m.group(1)}"{title_text}"\n'
        new_lines.append(line)
    with open(file, "w", encoding="utf-8") as f:
        f.writelines(new_lines)
