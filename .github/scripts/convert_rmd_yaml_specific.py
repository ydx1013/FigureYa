import sys
import yaml
from collections import OrderedDict

class QuotedString(str): pass

def quoted_presenter(dumper, data):
    return dumper.represent_scalar('tag:yaml.org,2002:str', data, style='"')

yaml.add_representer(QuotedString, quoted_presenter)

def split_yaml_and_body(text):
    if not text.startswith('---'):
        return None, text
    lines = text.splitlines()
    yaml_lines = []
    end_idx = None
    for i, line in enumerate(lines[1:], 1):
        if line.strip() == '---':
            end_idx = i
            break
        yaml_lines.append(line)
    if end_idx is None:
        return None, text
    body = '\n'.join(lines[end_idx+1:])
    return '\n'.join(yaml_lines), body

def process_file(rmd_path):
    with open(rmd_path, encoding='utf-8') as f:
        content = f.read()
    yaml_text, body = split_yaml_and_body(content)
    if yaml_text is None:
        data = {}
    else:
        data = yaml.safe_load(yaml_text) or {}

    # 提取
    title = data.pop('title', '')
    output = data.pop('output', 'html_document')
    author = data.pop('author', '')
    reviewer = data.pop('reviewer', '')
    reviewers = data.pop('reviewers', '')
    date = data.pop('date', '')

    # params 顺序
    params = OrderedDict()
    if author: params['author'] = QuotedString(author)
    if reviewer: params['reviewer'] = QuotedString(reviewer)
    if reviewers: params['reviewers'] = QuotedString(reviewers)
    if date: params['date'] = QuotedString(date)

    # YAML顺序
    new_yaml = OrderedDict()
    new_yaml['title'] = QuotedString(title)
    if params:
        new_yaml['params'] = params
    new_yaml['output'] = output
    # 其它字段也按原顺序补进去
    for k, v in data.items():
        new_yaml[k] = v

    with open(rmd_path, 'w', encoding='utf-8') as f:
        f.write('---\n')
        yaml.dump(new_yaml, f, allow_unicode=True, sort_keys=False, default_flow_style=False)
        f.write('---\n\n')
        if 'author' in params:
            f.write('**Author(s)**: `r params$author`  \n')
        if 'reviewer' in params:
            f.write('**Reviewer(s)**: `r params$reviewer`  \n')
        if 'reviewers' in params:
            f.write('**Reviewer(s)**: `r params$reviewers`  \n')
        if 'date' in params:
            f.write('**Date**: `r params$date`  \n')
        if params:
            f.write('\n')
        f.write(body)

if __name__ == '__main__':
    with open('filelist.txt') as f:
        files = [line.strip() for line in f if line.strip()]
    for rmd_file in files:
        print(f'Processing {rmd_file}')
        process_file(rmd_file)
