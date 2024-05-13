-- Exclusão de possíveis tabelas já existentes
DROP TABLE T_PORTAL_SALESFORCE
DROP TABLE T_LOGS
DROP TABLE T_TIPOS_ACESSIBILIDADE
DROP TABLE T_ENDERECO_ADMIN
DROP TABLE T_CADASTRO_ADMIN
DROP TABLE T_ADMIN
DROP TABLE T_ADMIN_LOGS
DROP TABLE T_ENDERECO_USUARIO
DROP TABLE T_CADASTRO_USUARIO
DROP TABLE T_USUARIO

-- Criação da tabela T_PORTAL_SALESFORCE
CREATE TABLE T_PORTAL_SALESFORCE (
    id_portal_salesforce NUMBER(10) PRIMARY KEY,
    configuracoes_portal_salesforce VARCHAR2(100) NOT NULL
);

-- Criação da tabela T_LOGS
CREATE TABLE T_LOGS (
    id_logs NUMBER(10) PRIMARY KEY,
    titulo_logs VARCHAR2(20) NOT NULL,
    tipo_logs VARCHAR2(20) NOT NULL,
    descricao_logs VARCHAR2(50) NOT NULL,
    dt_logs DATE NOT NULL
);

-- Criação da tabela T_TIPOS_ACESSIBILIDADE
CREATE TABLE T_TIPOS_ACESSIBILIDADE (
    id_tipos_acessibilidade NUMBER(10) PRIMARY KEY,
    motora_tipos_acessibilidade VARCHAR2(20),
    auditiva_tipos_acessibilidade VARCHAR2(20),
    visual_tipos_acessibilidade VARCHAR2(20)
);

-- Criação da tabela T_ENDERECO_ADMIN
CREATE TABLE T_ENDERECO_ADMIN (
    id_endereco_admin NUMBER(10) PRIMARY KEY,
    logradouro_endereco_admin VARCHAR2(50) NOT NULL,
    nro_endereco_admin VARCHAR2(10) NOT NULL,
    cep_endereco_admin VARCHAR(10) NOT NULL
);

-- Criação da tabela T_CADASTRO_ADMIN
CREATE TABLE T_CADASTRO_ADMIN (
    id_cadastro_admin NUMBER(10) PRIMARY KEY,
    nome_cadastro_admin VARCHAR(50) NOT NULL,
    dt_nasc_cadastro_admin DATE NOT NULL,
    sexo_cadastro_admin CHAR (3) NOT NULL CHECK (sexo_cadastro_admin IN('M', 'F', 'I')), -- M = MASCULINO, F = FEMININO, I = INDEFINIDO
    tel_cadastro_admin VARCHAR2(20) NOT NULL,
    email_cadastro_admin VARCHAR2(50) NOT NULL,
    senha_cadastro_admin VARCHAR2(50) NOT NULL,
    tipo_cadastro_admin VARCHAR2(10) NOT NULL CHECK (tipo_cadastro_admin IN('A', 'U')), -- A = ADMIN // U = USUARIO
    id_endereco_admin NUMBER(10) NOT NULL,
    FOREIGN KEY (id_endereco_admin) REFERENCES T_ENDERECO_ADMIN(id_endereco_admin) -- Referenciando Chave Estrangeira
);

-- Criação da tabela T_ADMIN
CREATE TABLE T_ADMIN (
    id_admin NUMBER(10) PRIMARY KEY,
    id_cadastro_admin NUMBER(10) NOT NULL,
    FOREIGN KEY (id_cadastro_admin) REFERENCES T_CADASTRO_ADMIN(id_cadastro_admin), -- Referenciando Chave Estrangeira
    id_portal_salesforce NUMBER(10) NOT NULL,
    FOREIGN KEY (id_portal_salesforce) REFERENCES T_PORTAL_SALESFORCE(id_portal_salesforce) -- Referenciando Chave Estrangeira
);

-- Criação da tabela T_ADMIN_LOGS
CREATE TABLE T_ADMIN_LOGS (
    id_admin NUMBER(10) NOT NULL,
    FOREIGN KEY (id_admin) REFERENCES T_ADMIN(id_admin), -- Referenciando Chave Estrangeira
    id_logs NUMBER(10) NOT NULL,
    FOREIGN KEY (id_logs) REFERENCES T_LOGS(id_logs) -- Referenciando Chave Estrangeira
);

-- Criação da tabela T_ENDERECO_USUARIO
CREATE TABLE T_ENDERECO_USUARIO (
    id_endereco_usuario NUMBER(10) PRIMARY KEY,
    logradouro_endereco_usuario VARCHAR2(50) NOT NULL,
    nro_endereco_usuario VARCHAR2(10) NOT NULL,
    cep_endereco_usuario VARCHAR2(10) NOT NULL
);

-- Criação da tabela T_CADASTRO_USUARIO
CREATE TABLE T_CADASTRO_USUARIO (
    id_cadastro_usuario NUMBER(10) PRIMARY KEY,
    nome_cadastro_usuario VARCHAR2 (50) NOT NULL,
    dt_nasc_cadastro_usuario DATE NOT NULL,
    sexo_cadastro_usuario CHAR (3) NOT NULL CHECK (sexo_cadastro_usuario IN('M', 'F', 'I')), -- M = MASCULINO, F = FEMININO, I = INDEFINIDO
    tel_cadastro_usuario VARCHAR2(20) NOT NULL,
    email_cadastro_usuario VARCHAR2(50) NOT NULL,
    senha_cadastro_usuario VARCHAR2(50) NOT NULL,
    id_endereco_usuario NUMBER(10) NOT NULL,
    FOREIGN KEY (id_endereco_usuario) REFERENCES T_ENDERECO_USUARIO(id_endereco_usuario) -- Referenciando Chave Estrangeira
);

-- Criação da tabela T_USUARIO
CREATE TABLE T_USUARIO (
    id_usuario NUMBER(10) PRIMARY KEY,
    tipo_usuario VARCHAR2(10) NOT NULL CHECK (tipo_usuario IN('A', 'U')), /* A = ADMIN // U = USUARIO*/
    id_cadastro_usuario NUMBER(10) NOT NULL,
    FOREIGN KEY (id_cadastro_usuario) REFERENCES T_CADASTRO_USUARIO(id_cadastro_usuario), -- Referenciando Chave Estrangeira
    id_portal_salesforce NUMBER(10) NOT NULL,
    FOREIGN KEY (id_portal_salesforce) REFERENCES T_PORTAL_SALESFORCE(id_portal_salesforce) -- Referenciando Chave Estrangeira
);


