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
import converterJson
 

#conexao 
user = "RM553228"
passw = "130201"
dsnStr = oracledb.makedsn("oracle.fiap.com.br", 1521, "ORCL")
# Efetua a conexão com o Usuário
connection = oracledb.connect(user=user, password=passw, dsn=dsnStr)

root = Tk()

#criacao menu
menu= Menu(root)

#instanciando a conexao

root.config(menu=menu)
root.title("Menu InovaAcess - Terceira Sprint")
root.geometry("900x500")
titulo = tk.Label(root, text="CRUD BASICO EM MENU, INOVACESS", font=("Arial", 24, "bold"))
titulo.config(background="white", foreground="red", justify=tk.CENTER, padx=20, pady=20)

titulo.grid(row=0, column=0, columnspan=2)
#fundo = PhotoImage(file="logo8.png")
#fundo1 = Label(root, image=fundo).place(x=1, y=1, relheight=1, relwidth=1)
#valor_inicial = 0
texto2 = tk.Label(root, text="JSON DADOS:", font=("Arial", 15, "bold"))
texto2.config(background="black", foreground="red", justify=tk.CENTER, padx=50, pady=50)
texto2.grid(row=2, column=1, columnspan=3)

texto3 = tk.Label(root, text="VAZIO", font=("Arial", 10, "bold"))
texto3.config(background="black", foreground="red", justify=tk.CENTER, padx=50, pady=50)
texto3.grid(row=3, column=1, columnspan=3)

root.resizable(False, False)


 
 
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

def salvarJson(res):
    # Converter os resultados para JSON
    dados_json = []
    for linha in res:
        dados_json.append(dict(linha))

    # Converter o objeto JSON para string
    json_string = json.dumps(dados_json, indent=4)

    # Salvar o JSON em um arquivo
    with open('dados.json', 'w') as arquivo:
        arquivo.write(json_string)


def select():
    # Cria um cursor
    cursor = connection.cursor()
    try:
    # Executa uma instrução SELECT
        cursor.execute("SELECT * FROM T_TIPOS_ACESSIBILIDADE")
        rows = cursor.fetchall()
        mensagem("TESTE", "ENTROU")
        opa = ["opa", "opa"]
        texto3.config(text=opa)
        salvarJson(opa)
        print(rows)
        for row in rows:
            print(row)
    except oracledb.DatabaseError as e:
        error, = e.args
        print(f"ERRO: {error.code} - {error.message}")
    finally:
        cursor.close()

def insert():
    return "opa"

def delete():
    return "opa"

def update():
    return "opa"

 
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