# QUEM FEZ O SISTEMA?

1. Renan Bezerra dos Santos - 553228
2. Lucas Alcântara Carvalho - 95111

# O QUE É O CODIGO?

O código é feito em python, ele será um leitor de um arquivo .cvs que é gerado na disciplina e na sprint de web da salesforce onde pega a posição x e y dos clicks do usuario no site de forma automatica.
OBS: como o site não está hospedado via deploy o arquivo .cvs ( na pasta dados da SRPINT3PYTHON) já está gerado o arquivo para rodar corretamente o arquivo (1) para dar o erro intencional para realizar o try exception finally.

# COMO RODAR?

Clone o projeto, execute o main.py, escolhe o arquivo .cvs sem espaço para o codigo rodar corretamente e retornar a quantidade de clicks que o usuario fez em cada parte da pagina ( header main e footer) e também retorna a % onde o usuario mais clicou e qual componente o usuario teve mais interatividade.
OBS: para você realizar o erro e entrar no tramamento de try exception intencionalmente ti tem duas opcoes: ou quando for selecionar o arquivo sair sem selecionar o arquivo dara um erro, e também o erro de você selecionar o .cvs (1) que contem espaço, o erro acontece pois o read_cvs do pandas não aceita leitura de arquivos com espaço.

# COMO GERAR UM ARQUIVO .CSV DA SUA PREFERENCIA?

https://github.com/renan-b-eth/InovaAcessReact4 

acesse nosso repositório, executa ele com o react next js, instale o node e puxa os nodulos para a pasta, com npm i e npm install node --latest-npm e rode o arquivo com npn run dev. Apos ter acesso ao htts://localhost:3000 você vai navegar na pagina entre as paginas e entre os componentes clicando, e ir no final da pagina e clicar no botão criar .cvs, após isso irá gerar o arquivo que irá por padrão do navegador ( isso se você não alterou as configurações ) para a pasta download, pegue o arquivo e jogue para a pasta dados da sprint3python e divirta-se testando o código.
