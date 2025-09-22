import re

with open('filelist.txt') as f:
    files = [line.strip() for line in f if line.strip()]

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
        if in_yaml and re.match(r'^\s*date\s*:\s*["\']?\d{4}-\d{2}-\d{2}["\']?\s*$', line):
            # 替换为 R 代码格式
            indent = re.match(r'^(\s*)', line).group(1)
            line = f'{indent}date: "`r Sys.Date()`"\n'
        new_lines.append(line)
    with open(file, "w", encoding="utf-8") as f:
        f.writelines(new_lines)
