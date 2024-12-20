-- SELECT

SELECT * FROM disciplina;
SELECT * FROM curso;
SELECT * FROM professor;
SELECT * FROM turma;
SELECT * FROM aluno;
SELECT * FROM matricula;

-- INSERT

INSERT INTO disciplina (codigo_disciplina, nome_disciplina, carga_horaria, descricao) VALUES
('DISC001', 'Matemática Básica', 60, 'Introdução aos conceitos matemáticos.'),
('DISC002', 'Programação I', 80, 'Fundamentos de programação.'),
('DISC003', 'Física I', 70, 'Princípios de mecânica clássica.');

INSERT INTO curso (sigla_curso, codigo_disciplina, nome, carga_horaria, descricao) VALUES
('CURSO001', 'DISC001', 'Engenharia', 3000, 'Curso de Engenharia Geral.'),
('CURSO002', 'DISC002', 'Ciência da Computação', 3200, 'Curso de Computação e Programação.'),
('CURSO003', 'DISC003', 'Física Aplicada', 2800, 'Curso de Física com aplicações práticas.');

INSERT INTO professor (nro_registro_professor, nome, codigo_disciplina) VALUES
('PROF001', 'Dr. João Silva', 'DISC001'),
('PROF002', 'Dra. Ana Costa', 'DISC002'),
('PROF003', 'Dr. Carlos Santos', 'DISC003');

INSERT INTO turma (codigo_turma, nro_alunos, sigla_curso, nro_registro_professor, periodo) VALUES
('TURMA001', 30, 'CURSO001', 'PROF001', 'Matutino'),
('TURMA002', 25, 'CURSO002', 'PROF002', 'Noturno'),
('TURMA003', 20, 'CURSO003', 'PROF003', 'Vespertino');

INSERT INTO matricula (nro_matricula, nome_aluno, sigla_curso, data_matricula, semestre) VALUES
(101, 'Maria Oliveira', 'CURSO001', '2024-01-15', 1),
(102, 'José Almeida', 'CURSO002', '2024-01-20', 1),
(103, 'Clara Fernandes', 'CURSO003', '2024-01-25', 1);

-- Exercício 1.

DELIMITER $$
CREATE PROCEDURE ExibirAlunosPorTurma (
    IN p_codigo_turma VARCHAR(15)
)
BEGIN
    SELECT a.nro_matricula, a.nome_aluno
    FROM aluno a
    WHERE a.codigo_turma = p_codigo_turma;
END $$
DELIMITER ;

-- Exemplo de chamada para a turma com código 'TURMA004'
CALL ExibirAlunosPorTurma('TURMA004');

-- Exercício 2.

DELIMITER $$
CREATE PROCEDURE AtualizarStatusAluno (
    IN p_nro_matricula INT,
    IN p_novo_status VARCHAR(20)
)
BEGIN
    -- Supondo que o campo 'status' foi adicionado à tabela 'aluno'
    UPDATE aluno
    SET status = p_novo_status
    WHERE nro_matricula = p_nro_matricula;
END $$
DELIMITER ;

-- Exemplo de chamada para atualizar o status do aluno com matrícula 101 para 'Ativo'
CALL AtualizarStatusAluno(101, 'Ativo');

-- Exercício 3.

DELIMITER $$
CREATE PROCEDURE ExibirProfessoresPorDisciplina (
    IN p_codigo_disciplina VARCHAR(15)
)
BEGIN
    SELECT p.nro_registro_professor, p.nome
    FROM professor p
    WHERE p.codigo_disciplina = p_codigo_disciplina;
END $$
DELIMITER ;

-- Exemplo de chamada para a disciplina com código 'DISC002'
CALL ExibirProfessoresPorDisciplina('DISC002');

-- Exercício 4.

DELIMITER $$
CREATE PROCEDURE InserirNovaTurma (
    IN p_qtd_alunos INT,
    IN p_periodo VARCHAR(20),
    IN p_semestre INT,
    IN p_status VARCHAR(20)
)
BEGIN
    -- Gerando um código único para a nova turma
    SET @novo_codigo_turma = CONCAT('TUR-', UUID());
    
    INSERT INTO turma (codigo_turma, nro_alunos, sigla_curso, nro_registro_professor, periodo)
    VALUES (@novo_codigo_turma, p_nro_alunos, NULL, NULL, p_periodo);

    -- Exibindo a confirmação de inserção
    SELECT @novo_codigo_turma AS codigo_turma, p_nro_alunos, p_periodo, p_semestre, p_status AS status;
END $$
DELIMITER ;

-- Exemplo de chamada para inserir uma nova turma com 30 alunos, no período 'Noturno', no semestre 2, com status 'Ativa'
CALL InserirNovaTurma(30, 'Noturno', 2, 'Ativa');

-- Exercício 5.

DELIMITER $$
CREATE PROCEDURE AtualizarEspecialidadeProfessor (
    IN p_nro_registro_professor VARCHAR(15),
    IN p_nova_especialidade VARCHAR(50)
)
BEGIN
    -- Supondo que o campo 'especialidade' foi adicionado à tabela 'professor'
    UPDATE professor
    SET especialidade = p_nova_especialidade
    WHERE nro_registro_professor = p_nro_registro_professor;
END $$
DELIMITER ;

-- Exemplo de chamada para atualizar a especialidade do professor com registro 'PROF456' para 'Matemática Avançada'
CALL AtualizarEspecialidadeProfessor('PROF003', 'Matemática Avançada');