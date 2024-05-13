import json
import conexao

class ConverterJson:
   
    res = conexao.conexao.rows # puxa o resultado da consulta

    # Converter os resultados para JSON
    dados_json = []
    for linha in res:
        dados_json.append(dict(linha))

    # Converter o objeto JSON para string
    json_string = json.dumps(dados_json, indent=4)

    # Salvar o JSON em um arquivo
    with open('dados.json', 'w') as arquivo:
        arquivo.write(json_string)
    pass