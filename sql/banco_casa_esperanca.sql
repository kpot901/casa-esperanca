-- ============================================================
-- CASA DE ACOLHIMENTO ESPERANÇA — Banco de Dados
-- Projeto Integrador Web Standards — Sprint 2/3
-- N2WEBS20261F | Prof. Lucio Luzetti Criado | 2025
-- MySQL / MariaDB
-- ============================================================

-- Remover banco se já existir (ambiente de dev)
DROP DATABASE IF EXISTS casa_esperanca;
CREATE DATABASE casa_esperanca
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE casa_esperanca;

-- ──────────────────────────────────────────────────────────────
-- TABELA 1: CONTATOS
-- Armazena todos os envios do formulário de contato.
-- ──────────────────────────────────────────────────────────────
CREATE TABLE CONTATOS (
  id_contato   INT            NOT NULL AUTO_INCREMENT,
  nome         VARCHAR(100)   NOT NULL COMMENT 'Nome completo do remetente',
  email        VARCHAR(150)   NOT NULL COMMENT 'E-mail; validado pelo JS antes do envio',
  telefone     VARCHAR(20)    DEFAULT NULL COMMENT 'Telefone/WhatsApp (opcional)',
  tipo_interesse ENUM(
    'voluntariado',
    'doacao',
    'parceria',
    'outro'
  ) NOT NULL COMMENT 'Origem do contato',
  mensagem     TEXT           NOT NULL COMMENT 'Texto livre; mínimo 10 caracteres (validado no front)',
  data_envio   DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp automático no INSERT',
  lido         TINYINT(1)     NOT NULL DEFAULT 0 COMMENT '0=não lido, 1=lido pelo admin',
  CONSTRAINT pk_contatos PRIMARY KEY (id_contato)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Índices úteis para administração
CREATE INDEX idx_contatos_tipo  ON CONTATOS(tipo_interesse);
CREATE INDEX idx_contatos_email ON CONTATOS(email);
CREATE INDEX idx_contatos_lido  ON CONTATOS(lido);

-- ──────────────────────────────────────────────────────────────
-- TABELA 2: VOLUNTARIOS
-- Extensão de CONTATOS para tipo_interesse = 'voluntariado'.
-- Relacionamento 1:1 com CONTATOS.
-- ──────────────────────────────────────────────────────────────
CREATE TABLE VOLUNTARIOS (
  id_voluntario  INT            NOT NULL AUTO_INCREMENT,
  id_contato     INT            NOT NULL COMMENT 'Referência a CONTATOS.id_contato (1:1)',
  habilidades    TEXT           DEFAULT NULL COMMENT 'Habilidades declaradas pelo voluntário',
  disponibilidade VARCHAR(100)  DEFAULT NULL COMMENT 'Dias/horários disponíveis',
  status         ENUM(
    'ativo',
    'inativo',
    'pendente'
  ) NOT NULL DEFAULT 'pendente' COMMENT 'Status do cadastro',
  data_cadastro  DATE           DEFAULT NULL COMMENT 'Data de aprovação do cadastro',
  observacoes    TEXT           DEFAULT NULL COMMENT 'Notas internas da equipe',
  ativo          TINYINT(1)     NOT NULL DEFAULT 1 COMMENT '0=inativo, 1=ativo',
  CONSTRAINT pk_voluntarios PRIMARY KEY (id_voluntario),
  CONSTRAINT fk_voluntarios_contato
    FOREIGN KEY (id_contato) REFERENCES CONTATOS(id_contato)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT uq_voluntarios_contato UNIQUE (id_contato)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_voluntarios_status ON VOLUNTARIOS(status);
CREATE INDEX idx_voluntarios_ativo  ON VOLUNTARIOS(ativo);

-- ──────────────────────────────────────────────────────────────
-- TABELA 3: PROJETOS
-- Cadastro de projetos da ONG exibidos na página Projetos.
-- ──────────────────────────────────────────────────────────────
CREATE TABLE PROJETOS (
  id_projeto   INT            NOT NULL AUTO_INCREMENT,
  titulo       VARCHAR(150)   NOT NULL COMMENT 'Título exibido no card',
  descricao    TEXT           DEFAULT NULL COMMENT 'Descrição completa do projeto',
  status       ENUM(
    'em_andamento',
    'concluido',
    'suspenso',
    'urgente'
  ) NOT NULL DEFAULT 'em_andamento' COMMENT 'Status exibido no badge',
  data_inicio  DATE           NOT NULL COMMENT 'Data de início do projeto',
  data_fim     DATE           DEFAULT NULL COMMENT 'Data de encerramento (nullable para projetos contínuos)',
  imagem_url   VARCHAR(255)   DEFAULT NULL COMMENT 'Caminho relativo ou URL da imagem de capa',
  CONSTRAINT pk_projetos PRIMARY KEY (id_projeto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_projetos_status ON PROJETOS(status);

-- ──────────────────────────────────────────────────────────────
-- TABELA 4: DOACOES
-- Registro de doações financeiras e de itens.
-- Relacionamento 1:N com CONTATOS.
-- ──────────────────────────────────────────────────────────────
CREATE TABLE DOACOES (
  id_doacao       INT              NOT NULL AUTO_INCREMENT,
  id_contato      INT              NOT NULL COMMENT 'Referência a CONTATOS.id_contato',
  tipo            ENUM(
    'financeira',
    'item'
  ) NOT NULL COMMENT 'Tipo da doação',
  valor           DECIMAL(10,2)    DEFAULT NULL COMMENT 'Valor em R$ (null se doação de item)',
  descricao_item  VARCHAR(200)     DEFAULT NULL COMMENT 'Descrição do item doado (nullable para financeiras)',
  data_doacao     DATE             NOT NULL COMMENT 'Data do recebimento/confirmação',
  comprovante     VARCHAR(255)     DEFAULT NULL COMMENT 'URL do comprovante de transferência (nullable)',
  CONSTRAINT pk_doacoes PRIMARY KEY (id_doacao),
  CONSTRAINT fk_doacoes_contato
    FOREIGN KEY (id_contato) REFERENCES CONTATOS(id_contato)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_doacoes_tipo      ON DOACOES(tipo);
CREATE INDEX idx_doacoes_contato   ON DOACOES(id_contato);
CREATE INDEX idx_doacoes_data      ON DOACOES(data_doacao);

-- ──────────────────────────────────────────────────────────────
-- TABELA 5: VOLUNTARIOS_PROJETOS
-- Tabela associativa N:M entre VOLUNTARIOS e PROJETOS.
-- ──────────────────────────────────────────────────────────────
CREATE TABLE VOLUNTARIOS_PROJETOS (
  id              INT           NOT NULL AUTO_INCREMENT,
  id_voluntario   INT           NOT NULL COMMENT 'Referência a VOLUNTARIOS.id_voluntario',
  id_projeto      INT           NOT NULL COMMENT 'Referência a PROJETOS.id_projeto',
  funcao          VARCHAR(100)  DEFAULT NULL COMMENT 'Papel do voluntário no projeto',
  data_inicio     DATE          NOT NULL COMMENT 'Início da participação',
  data_fim        DATE          DEFAULT NULL COMMENT 'Fim da participação (nullable = ainda ativo)',
  CONSTRAINT pk_vp PRIMARY KEY (id),
  CONSTRAINT fk_vp_voluntario
    FOREIGN KEY (id_voluntario) REFERENCES VOLUNTARIOS(id_voluntario)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_vp_projeto
    FOREIGN KEY (id_projeto) REFERENCES PROJETOS(id_projeto)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT uq_vp UNIQUE (id_voluntario, id_projeto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_vp_voluntario ON VOLUNTARIOS_PROJETOS(id_voluntario);
CREATE INDEX idx_vp_projeto    ON VOLUNTARIOS_PROJETOS(id_projeto);

-- ──────────────────────────────────────────────────────────────
-- TABELA 6: NECESSIDADES
-- Itens urgentes vinculados a um projeto (seção "Como Ajudar").
-- Relacionamento 1:N com PROJETOS.
-- ──────────────────────────────────────────────────────────────
CREATE TABLE NECESSIDADES (
  id_necessidade INT           NOT NULL AUTO_INCREMENT,
  id_projeto     INT           NOT NULL COMMENT 'Referência a PROJETOS.id_projeto',
  descricao      VARCHAR(200)  NOT NULL COMMENT 'Ex.: Fraldas Geriátricas G',
  urgente        TINYINT(1)    NOT NULL DEFAULT 0 COMMENT '1 = badge vermelho URGENTE no site',
  quantidade     INT           DEFAULT NULL COMMENT 'Quantidade necessária (nullable = sem limite definido)',
  unidade        VARCHAR(30)   DEFAULT NULL COMMENT 'Ex.: pacotes, unidades, kits',
  atendida       TINYINT(1)    NOT NULL DEFAULT 0 COMMENT '1 = necessidade já suprida',
  CONSTRAINT pk_necessidades PRIMARY KEY (id_necessidade),
  CONSTRAINT fk_necessidades_projeto
    FOREIGN KEY (id_projeto) REFERENCES PROJETOS(id_projeto)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_necessidades_urgente  ON NECESSIDADES(urgente);
CREATE INDEX idx_necessidades_atendida ON NECESSIDADES(atendida);
CREATE INDEX idx_necessidades_projeto  ON NECESSIDADES(id_projeto);

-- ============================================================
-- DADOS DE EXEMPLO (SEED)
-- ============================================================

-- Projetos
INSERT INTO PROJETOS (titulo, descricao, status, data_inicio, data_fim, imagem_url) VALUES
  ('Escola de Reforço',  'Aulas de apoio em Português e Matemática para os acolhidos, reduzindo defasagem escolar.',  'em_andamento', '2016-03-01', NULL,         'img/reforco.jpg'),
  ('Arte e Expressão',   'Atividades de pintura, teatro e música com abordagem terapêutica.',                          'em_andamento', '2019-05-01', NULL,         'img/arte.jpg'),
  ('Esporte pela Paz',   'Futebol, vôlei e capoeira promovendo disciplina, saúde e trabalho em equipe.',              'urgente',      '2019-08-01', NULL,         'img/esporte.jpg'),
  ('Cine-Clube',         'Sessões de cinema temáticas com rodas de conversa sobre os filmes assistidos.',             'concluido',    '2021-04-01', '2023-12-15', 'img/cine.jpg');

-- Necessidades dos projetos
INSERT INTO NECESSIDADES (id_projeto, descricao, urgente, quantidade, unidade, atendida) VALUES
  (1, 'Cadernos escolares (80 folhas)', 0, 50, 'unidades', 0),
  (1, 'Canetas esferográficas azuis',   0, 100, 'unidades', 0),
  (2, 'Tintas para tela (acrílica)',     0, 20, 'potes', 0),
  (2, 'Pincéis para pintura variados',  0, 30, 'unidades', 0),
  (3, 'Bolas de futebol society',        1, 5,  'unidades', 0),
  (3, 'Bolas de vôlei',                  1, 3,  'unidades', 0),
  (3, 'Coletes esportivos coloridos',    1, 20, 'unidades', 0);

-- Contato exemplo (voluntária)
INSERT INTO CONTATOS (nome, email, telefone, tipo_interesse, mensagem) VALUES
  ('Ana Souza', 'ana.souza@email.com', '(11) 9 9999-0001', 'voluntariado', 'Olá, sou pedagoga e tenho disponibilidade nas tardes de quarta e sexta para ajudar no projeto de reforço escolar.');

-- Voluntária cadastrada
INSERT INTO VOLUNTARIOS (id_contato, habilidades, disponibilidade, status, data_cadastro, ativo) VALUES
  (1, 'Pedagogia, reforço escolar, leitura', 'Quartas e sextas, 13h–17h', 'ativo', CURDATE(), 1);

-- Vinculação voluntária ao projeto
INSERT INTO VOLUNTARIOS_PROJETOS (id_voluntario, id_projeto, funcao, data_inicio) VALUES
  (1, 1, 'Professora de reforço escolar', '2025-03-05');

-- Doação financeira de exemplo
INSERT INTO CONTATOS (nome, email, telefone, tipo_interesse, mensagem) VALUES
  ('Carlos Lima', 'carlos@empresa.com.br', '(11) 3333-0000', 'doacao', 'Gostaríamos de realizar uma doação mensal de R$ 500,00 para a manutenção da casa.');

INSERT INTO DOACOES (id_contato, tipo, valor, data_doacao, comprovante) VALUES
  (2, 'financeira', 500.00, CURDATE(), NULL);

-- ============================================================
-- VIEWS ÚTEIS (demonstração para a apresentação)
-- ============================================================

-- View: projetos com contagem de voluntários
CREATE VIEW vw_projetos_resumo AS
SELECT
  p.id_projeto,
  p.titulo,
  p.status,
  p.data_inicio,
  p.data_fim,
  COUNT(DISTINCT vp.id_voluntario) AS total_voluntarios,
  COUNT(DISTINCT n.id_necessidade)  AS total_necessidades,
  SUM(CASE WHEN n.urgente = 1 AND n.atendida = 0 THEN 1 ELSE 0 END) AS necessidades_urgentes
FROM PROJETOS p
LEFT JOIN VOLUNTARIOS_PROJETOS vp ON vp.id_projeto = p.id_projeto
LEFT JOIN NECESSIDADES n ON n.id_projeto = p.id_projeto
GROUP BY p.id_projeto, p.titulo, p.status, p.data_inicio, p.data_fim;

-- View: necessidades urgentes pendentes
CREATE VIEW vw_necessidades_urgentes AS
SELECT
  n.id_necessidade,
  p.titulo AS projeto,
  n.descricao,
  n.quantidade,
  n.unidade
FROM NECESSIDADES n
JOIN PROJETOS p ON p.id_projeto = n.id_projeto
WHERE n.urgente = 1 AND n.atendida = 0
ORDER BY p.titulo;

-- View: contatos não lidos
CREATE VIEW vw_contatos_nao_lidos AS
SELECT id_contato, nome, email, tipo_interesse, data_envio
FROM CONTATOS
WHERE lido = 0
ORDER BY data_envio DESC;

-- ============================================================
-- CONSULTAS DE EXEMPLO (para a apresentação do projeto)
-- ============================================================

-- Q1: Listar todos os projetos em andamento
-- SELECT * FROM PROJETOS WHERE status = 'em_andamento';

-- Q2: Ver necessidades urgentes do site
-- SELECT * FROM vw_necessidades_urgentes;

-- Q3: Voluntários ativos e seus projetos
-- SELECT v.id_voluntario, c.nome, c.email, p.titulo AS projeto, vp.funcao
-- FROM VOLUNTARIOS v
-- JOIN CONTATOS c ON c.id_contato = v.id_contato
-- JOIN VOLUNTARIOS_PROJETOS vp ON vp.id_voluntario = v.id_voluntario
-- JOIN PROJETOS p ON p.id_projeto = vp.id_projeto
-- WHERE v.ativo = 1;

-- Q4: Total de doações financeiras recebidas
-- SELECT SUM(valor) AS total_arrecadado, COUNT(*) AS qtd_doacoes
-- FROM DOACOES WHERE tipo = 'financeira';
