
import cx_Oracle


class conexao:
    #conexao ao banco de dados oracle

    connection = cx_Oracle.connect(
    user="RM553228",
    password="130201",
    host="oracle.fiap.com.br",
    port=1521,
    service_name="ORCL"
    ) 

        # Executar uma consulta
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM T_CADASTRO_ADMIN")
    resultado = cursor.fetchall()
    
    # Imprimir o resultado da consulta
    for linha in resultado:
        print(linha)

    # Fechar a conexão
    connection.close()

    pass