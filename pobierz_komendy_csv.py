import os
import json
import csv

def find_command_json_files(directory):
    command_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file == 'command.json':
                if "modules_waiting" in root:
                    print(f'omit file {root}{file}')
                    continue
                command_files.append(os.path.join(root, file))
    return command_files

def get_params(params):
    result = ""
    for param in params:
        result += f'- {param["name"]} <{param["description"]}>\n'
    return result

if __name__ == "__main__":
    search_directory = '/home/mrucznik/repos/my/Mrucznik-RP-private/gamemodes/modules'

    # Find all command.json files in the directory
    json_files = find_command_json_files(search_directory)

    all_keys = set()
    all_data = []
    for json_file in json_files:
        with open(json_file, 'r', encoding='utf-8') as file:
            try:
                data = json.load(file)
            except:
                with open(json_file, 'r', encoding='windows-1250') as file:
                    data = json.load(file)
            data['module'] = json_file.split('/')[8]
            print(data['module'])
            all_data.append(data)
            all_keys.update(data.keys())

    output_csv = "out.csv"
    headers = ['Nazwa','Aliasy','Parametry','Opis','Dodatkowe porady','Uprawnienia','Grupa','Moduł','Autor','Data stworzenia']
    with open(output_csv, mode='w', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=headers, delimiter=',')
        writer.writeheader()
        for data in all_data:
            writer.writerow({
                'Nazwa': "/" + data["name"],
                'Aliasy': ', '.join(["/" + c for c in data["aliases"]]),
                'Parametry': get_params(data["parameters"]),
                'Opis': data["description"],
                'Dodatkowe porady': ','.join(data.get("command_tips", [])),
                'Uprawnienia': ','.join(data.get("permissions", [])),
                'Grupa': '',
                'Moduł': data["module"],
                'Autor': data["author"],
                'Data stworzenia': data["date"],
            })
