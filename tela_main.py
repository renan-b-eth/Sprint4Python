from tkinter import *
from tkinter import messagebox
import tkinter as tk
import webbrowser
import subprocess
import os
import time
import random
import conexao
import oracledb
import json
import pandas as pd # salvamos o arquivo em json convertendo um dataframe em json ao inves de um foreach de linhas e json dumps e with para leitura.
from tkinter.simpledialog import askstring
import datetime

#conexao 
user = "RM553228"
passw = "130201"
dsnStr = oracledb.makedsn("oracle.fiap.com.br", 1521, "ORCL")
# Efetua a conexão com o Usuário
connection = oracledb.connect(user=user, password=passw, dsn=dsnStr)

root = tk.Tk()

#criacao menu
menu= Menu(root)

#instanciando a conexao

root.config(menu=menu)
root.title("Menu InovaAcess - Quarta Sprint")
root.geometry("900x500")
titulo = tk.Label(root, text="CRUD BASICO EM MENU, INOVACESS", font=("Arial", 24, "bold"))
titulo.config(background="white", foreground="#1163F0", justify=tk.CENTER, padx=20, pady=20)

titulo.grid(row=0, column=0, columnspan=2)
#fundo = PhotoImage(file="logo8.png")
#fundo1 = Label(root, image=fundo).place(x=1, y=1, relheight=1, relwidth=1)
#valor_inicial = 0
texto2 = tk.Label(root, text="JSON DADOS:", font=("Arial", 15, "bold"))
texto2.config(background="white", foreground="#1163F0", justify=tk.CENTER, padx=50, pady=50)
texto2.grid(row=2, column=1, columnspan=3)

texto3 = tk.Label(root, text="VAZIO", font=("Arial", 10, "bold"))
texto3.config(background="white", foreground="#1163F0", justify=tk.CENTER, padx=50, pady=50)
texto3.grid(row=3, column=1, columnspan=3)

root.resizable(False, False)

def retornar_hora_atual():
    data = datetime.datetime.now()
    data_formato_oracle = data.strftime("%Y-%m-%d %H:%M:%S") # DEIXA NO FORMATO ORACLE DA DATA
    return data_formato_oracle


def input_usuario(titulo, texto):
    root = Tk()
    root.withdraw()  # Esconde a janela principal do Tkinter
    input = askstring(titulo, texto)
    return input

def criarBotao():
    btnMoverMouse = Button(root, text = 'Mover Camera',
                       command = lambda:acessarSiteProdutos("www.salesforce.com.br"))                  
    btnMoverMouse.place(x=450, y=300, anchor=CENTER)
    btnMoverMouse.configure(height=5, width=15, bg="#CADFEE")

def criarBotao2():
    btnMoverMouse = Button(root, text = 'REALIZAR LEITURA ARQUIVO CVS',
                       command = print("leitura feita"))                  
    btnMoverMouse.place(x=450, y=300, anchor=CENTER)
    btnMoverMouse.configure(height=5, width=35, bg="#CADFEE")
   
 
def acessarSiteProdutos(url):
    return webbrowser.open(url)
 
def mensagem(titulo,mgs):
    return messagebox.showinfo(titulo,mgs)
 
def quemSomos():
    messagebox.showinfo("Quem Somos?", "Lucas Alcântara Carvalho - 95111\nRenan Bezerra dos Santos - 553228")
 
def acessarDiretorio(diretorio):
   return os.startfile(diretorio)


def select():
    # Cria um cursor
    cursor = connection.cursor()
    try:
    # Executa uma instrução SELECT
        cursor.execute("SELECT * FROM T_LOGS")
        rows = cursor.fetchall()
        texto3.config(text=rows)
        print(rows)
        #print("SEM ERRO")
        for row in rows:
            dic = [] 
            dic.append(rows) # coloca todas as linhas num dicionario
        df = pd.DataFrame(dic)
            #print(row)
        mensagem("LOG", "Json das logs realizada com sucesso.")
        df.to_json('dadosLogs.json', orient='records', indent=1) # converter o dataframe em json
        #print(df)
        #print("FINAL")
    except oracledb.DatabaseError as e:
        error, = e.args
        print(f"ERRO: {error.code} - {error.message}")
    finally:
        cursor.close()

def insert():
    id = random.randint(10,10000)
    titulo = input_usuario("Titulo Logs", "Insira o titulo da log:")
    tipo = input_usuario("Tipo Logs", "Insira o tipo da log:")
    descricao =  input_usuario("Descricao", "Insira a decrição log:")
    data = retornar_hora_atual()
    cursor = connection.cursor()
    cursor.execute(
        f"INSERT INTO T_LOGS (id_logs, titulo_logs, tipo_logs, descricao_logs, dt_logs) VALUES (:id, :titulo, :tipo, :descricao, :data)",
        { 
            ":id": id,
            ":titulo": titulo,
            ":tipo": tipo,
            ":descricao": descricao,
            ":data": data, 
        },
    )
    mensagem("LOG OK","LOG INSERIDA NO BANCO SUCESSO!")
    connection.commit()

def delete():
    cursor = connection.cursor()
    id = input_usuario("Titulo Logs", "Insira o ID a ser deletado:")
    consulta = "DELETE FROM T_LOGS WHERE id_logs = " + str(id)
    mensagem("LOG OK","LOG DELETADA COM SUCESSO")
    cursor.execute(consulta)
    connection.commit()

def update():
    cursor = connection.cursor()
    id = input_usuario("Titulo", "Insira o ID:")  # ID do admin a ser atualizado
    novo_titulo = input_usuario("Titulo", "Insira a nova descricao:")  # Novo titulo
    nova_descricao = input_usuario("Titulo", "A Nova descricao")  # Nova descricao

    consulta = f"""
    UPDATE T_LOGS
    SET TITULO_lOGS = :novo_titulo, DESCRICAO_LOGS = :nova_descricao
    WHERE ID_lOGS = :id
    """
    cursor.execute(consulta, id=id, novo_titulo=novo_titulo, nova_descricao=nova_descricao)
    connection.commit()

    return mensagem("LOG ATUALIZADA COM SUCESSO")

 
opcao1 = Menu(menu, tearoff=0)
opcao1.add_command(label= "ACESSAR LEITURA DE CVS", command= lambda: criarBotao2())

crud = Menu(menu, tearoff=0)
crud.add_command(label= "SELECT", command= lambda: select())
crud.add_command(label= "INSERT", command= lambda: insert())
crud.add_command(label= "UPDATE", command= lambda: update())
crud.add_command(label= "DELETE", command= lambda: delete())

opcao2 = Menu(menu, tearoff=0)
opcao2.add_command(label= "Acessar Camera Mouse", command= lambda: criarBotao())

opcao3 = Menu(menu, tearoff=0)
opcao3.add_command(label= "Acessar Teclado Virtual", command=lambda: acessarDiretorio('C:\\Windows\\System32\\osk.exe'))
 
sobrenos = Menu(menu, tearoff=0)
sobrenos.add_command(label= "Quem somos", command=quemSomos)
 
sair = Menu(menu, tearoff=0)
sair.add_command(label="Sair", command=exit)
 
 
menu.add_cascade(label = "ACESSAR LEITURA DE CVS      ", menu= opcao1)
menu.add_cascade(label = "CRUD      ", menu= crud)
menu.add_cascade(label = "Acessibilidade - Camera Mouse      ", menu= opcao2)
menu.add_cascade(label = "Acessibilidade - Teclado Virtual      ", menu= opcao3)
menu.add_cascade(label = "Quem somos      ", menu= sobrenos)
menu.add_cascade(label = "Sair", menu= sair)
 
 
root.mainloop()