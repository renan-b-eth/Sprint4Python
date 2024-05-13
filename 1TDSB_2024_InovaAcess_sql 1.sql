-- Exclusão de possíveis tabelas já existentes
DROP TABLE IF EXISTS T_LOGS;
DROP TABLE IF EXISTS T_TIPOS_ACESSIBILIDADE;
DROP TABLE IF EXISTS T_CADASTRO_ADMIN;
DROP TABLE IF EXISTS T_ADMIN;
DROP TABLE IF EXISTS T_CADASTRO_USUARIO;
DROP TABLE IF EXISTS T_USUARIO;
DROP TABLE IF EXISTS T_ENDERECO;

-- Criação da tabela T_LOGS
CREATE TABLE T_LOGS (
    id_logs NUMBER(10) PRIMARY KEY,
    titulo_logs VARCHAR2(20) NOT NULL,
    tipo_logs VARCHAR2(20) NOT NULL,
    descricao_logs VARCHAR2(50) NOT NULL,
    dt_logs DATE NOT NULL
);

-- Inserção de dados na tabela T_LOGS
INSERT INTO T_LOGS (id_logs, titulo_logs, tipo_logs, descricao_logs, dt_logs)
VALUES (1, 'Log 1', 'Tipo 1', 'Descrição do log 1', SYSDATE);

INSERT INTO T_LOGS (id_logs, titulo_logs, tipo_logs, descricao_logs, dt_logs)
VALUES (2, 'Log 2', 'Tipo 2', 'Descrição do log 2', SYSDATE);

INSERT INTO T_LOGS (id_logs, titulo_logs, tipo_logs, descricao_logs, dt_logs)
VALUES (3, 'Log 3', 'Tipo 3', 'Descrição do log 3', SYSDATE);

-- Remoção de dados T_LOGS
DELETE FROM T_LOGS
WHERE id_logs = 3;

-- Função de grupo
SELECT tipo_logs, COUNT(*) AS total_logs
FROM T_LOGS
GROUP BY tipo_logs;

-- Criação da tabela T_TIPOS_ACESSIBILIDADE
CREATE TABLE T_TIPOS_ACESSIBILIDADE (
    id_tipos_acessibilidade NUMBER(10) PRIMARY KEY,
    motora_tipos_acessibilidade VARCHAR2(20),
    auditiva_tipos_acessibilidade VARCHAR2(20),
    visual_tipos_acessibilidade VARCHAR2(20)
);

-- Inserção de dados na tabela T_TIPOS_ACESSIBILIDADE
INSERT INTO T_TIPOS_ACESSIBILIDADE (id_tipos_acessibilidade, motora_tipos_acessibilidade, auditiva_tipos_acessibilidade, visual_tipos_acessibilidade)
VALUES (1, 'Motora', 'Auditiva', 'Visual');

INSERT INTO T_TIPOS_ACESSIBILIDADE (id_tipos_acessibilidade, motora_tipos_acessibilidade, auditiva_tipos_acessibilidade, visual_tipos_acessibilidade)
VALUES (2, 'Motora', 'Auditiva', 'Visual');

-- Remoção de dados T_TIPOS_ACESSIBILIDADE
DELETE FROM T_TIPOS_ACESSIBILIDADE
WHERE id_tipos_acessibilidade = 2;

-- Consulta com ordenação pela categoria "visual" T_TIPOS_ACESSIBILIDADE
SELECT * FROM T_TIPOS_ACESSIBILIDADE
ORDER BY visual_tipos_acessibilidade;

-- Criação da tabela T_CADASTRO_ADMIN
CREATE TABLE T_CADASTRO_ADMIN (
    id_cadastro_admin NUMBER(10) PRIMARY KEY,
    nome_cadastro_admin VARCHAR(50) NOT NULL,
    dt_nasc_cadastro_admin DATE NOT NULL,
    sexo_cadastro_admin CHAR (3) NOT NULL CHECK (sexo_cadastro_admin IN('M', 'F', 'I')), -- M = MASCULINO, F = FEMININO, I = INDEFINIDO
    tel_cadastro_admin VARCHAR2(20) NOT NULL,
    email_cadastro_admin VARCHAR2(50) NOT NULL,
    senha_cadastro_admin VARCHAR2(50) NOT NULL,
    id_endereco NUMBER(10) NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES T_ENDERECO(id_endereco) -- Referenciando Chave Estrangeira
);

-- Inserção de dados na tabela T_CADASTRO_ADMIN
INSERT INTO T_CADASTRO_ADMIN (id_cadastro_admin, nome_cadastro_admin, dt_nasc_cadastro_admin, sexo_cadastro_admin, tel_cadastro_admin, email_cadastro_admin, senha_cadastro_admin, id_endereco)
VALUES (1, 'Admin 1', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'M', '123456789', 'admin1@example.com', 'senha1', 1);

-- Atualização de dados na tabela T_CADASTRO_ADMIN
UPDATE T_CADASTRO_ADMIN
SET nome_cadastro_admin = 'Novo nome'
WHERE id_cadastro_admin = 1;

UPDATE T_CADASTRO_ADMIN
SET sexo_cadastro_admin = 'F'
WHERE id_cadastro_admin = 1;

UPDATE T_CADASTRO_ADMIN
SET tel_cadastro_admin = '987654321'
WHERE id_cadastro_admin = 1;

-- Remoção de dados T_CADASTRO_ADMIN
DELETE FROM T_CADASTRO_ADMIN
WHERE id_cadastro_admin = 1;

-- Função tipo númerica na tabela T_CADASTRO_ADMIN
SELECT COUNT(*) AS total_registros FROM T_CADASTRO_ADMIN;

-- Criação da tabela T_ADMIN
CREATE TABLE T_ADMIN (
    id_admin NUMBER(10) PRIMARY KEY,
    id_cadastro_admin NUMBER(10) NOT NULL,
    FOREIGN KEY (id_cadastro_admin) REFERENCES T_CADASTRO_ADMIN(id_cadastro_admin), -- Referenciando Chave Estrangeira
    id_portal_salesforce NUMBER(10) NOT NULL,
    FOREIGN KEY (id_portal_salesforce) REFERENCES T_PORTAL_SALESFORCE(id_portal_salesforce) -- Referenciando Chave Estrangeira
);

-- Inserção de dados na tabela T_ADMIN
INSERT INTO T_ADMIN (id_admin, id_cadastro_admin, id_portal_salesforce)
VALUES (1, 1, 1);

-- Criação da tabela T_CADASTRO_USUARIO
CREATE TABLE T_CADASTRO_USUARIO (
    id_cadastro_usuario NUMBER(10) PRIMARY KEY,
    nome_cadastro_usuario VARCHAR2 (50) NOT NULL,
    dt_nasc_cadastro_usuario DATE NOT NULL,
    sexo_cadastro_usuario CHAR (3) NOT NULL CHECK (sexo_cadastro_usuario IN('M', 'F', 'I')), -- M = MASCULINO, F = FEMININO, I = INDEFINIDO
    tel_cadastro_usuario VARCHAR2(20) NOT NULL,
    email_cadastro_usuario VARCHAR2(50) NOT NULL,
    senha_cadastro_usuario VARCHAR2(50) NOT NULL,
    id_endereco NUMBER(10) NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES T_ENDERECO(id_endereco) -- Referenciando Chave Estrangeira
);

-- Inserção de dados na tabela T_CADASTRO_USUARIO
INSERT INTO T_CADASTRO_USUARIO (id_cadastro_usuario, nome_cadastro_usuario, dt_nasc_cadastro_usuario, sexo_cadastro_usuario, tel_cadastro_usuario, email_cadastro_usuario, senha_cadastro_usuario, id_endereco)
VALUES (1, 'Usuario 1', TO_DATE('1995-01-01', 'YYYY-MM-DD'), 'F', '987654321', 'usuario1@example.com', 'senha1', 2);

-- Criação da tabela T_USUARIO
CREATE TABLE T_USUARIO (
    id_usuario NUMBER(10) PRIMARY KEY,
    tipo_usuario VARCHAR2(10) NOT NULL CHECK (tipo_usuario IN('A', 'U')), /* A = ADMIN // U = USUARIO*/
    id_cadastro_usuario NUMBER(10) NOT NULL,
    FOREIGN KEY (id_cadastro_usuario) REFERENCES T_CADASTRO_USUARIO(id_cadastro_usuario), -- Referenciando Chave Estrangeira
    id_portal_salesforce NUMBER(10) NOT NULL,
    FOREIGN KEY (id_portal_salesforce) REFERENCES T_PORTAL_SALESFORCE(id_portal_salesforce) -- Referenciando Chave Estrangeira
);

-- Inserção de dados na tabela T_USUARIO
INSERT INTO T_USUARIO (id_usuario, tipo_usuario, id_cadastro_usuario, id_portal_salesforce)
VALUES (1, 'U', 1, 1);

-- Criação da tabela T_ENDERECO
CREATE TABLE T_ENDERECO (
    id_endereco NUMBER(10) PRIMARY KEY,
    logradouro VARCHAR2(50) NOT NULL,
    numero VARCHAR2(10) NOT NULL,
    cep VARCHAR2(10) NOT NULL
);

-- Inserção de dados na tabela T_ENDERECO
INSERT INTO T_ENDERECO (id_endereco, logradouro, numero, cep)
VALUES (1, 'Rua A', '123', '12345-678');

INSERT INTO T_ENDERECO (id_endereco, logradouro, numero, cep)
VALUES (2, 'Rua B', '456', '98765-432');

-- Utilizando subconsulta
SELECT id_cadastro_admin, nome_cadastro_admin
FROM T_CADASTRO_ADMIN
WHERE id_endereco IN (
    SELECT id_endereco
    FROM T_ENDERECO
    WHERE logradouro = 'Rua A'
);

-- Utilizando junção de tabelas
SELECT u.id_usuario, u.tipo_usuario, c.nome_cadastro_usuario, c.dt_nasc_cadastro_usuario, e.logradouro, e.numero, e.cep
FROM T_USUARIO u
JOIN T_CADASTRO_USUARIO c ON u.id_cadastro_usuario = c.id_cadastro_usuario
JOIN T_ENDERECO e ON c.id_endereco = e.id_endereco;