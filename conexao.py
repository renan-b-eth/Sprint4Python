
#import cx_Oracle
import oracledb

class conexao:
    #conexao ao banco de dados oracle
    user = "RM553228"
    passw = "130201"
    dsnStr = oracledb.makedsn("oracle.fiap.com.br", 1521, "ORCL")
    # Efetua a conexão com o Usuário
    connection = oracledb.connect(user=user, password=passw, dsn=dsnStr)

    # Cria um cursor
    cursor = connection.cursor()

    # Executa uma instrução SELECT
    cursor.execute('SELECT * FROM T_LOGS')

    rows = cursor.fetchall()
    for row in rows:
        #print(row)
        #print("OPA")
    
     pass