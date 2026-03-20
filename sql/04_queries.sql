-- SELECTS BÁSICOS
SELECT * FROM Paciente;
SELECT * FROM Consulta;

-- UPDATES
UPDATE Paciente 
SET cidade = 'Ilhota' 
WHERE nome = 'Paulo';

UPDATE Consulta 
SET data_cons = '2024-07-04', hora = '12:00'
WHERE codm = 1 AND codp = 4;

UPDATE Paciente 
SET idade = idade + 1, doenca = 'Cancer' 
WHERE nome = 'Ana';

UPDATE Consulta 
SET hora = '14:30:00' 
WHERE codm = 3 AND codp = 4;

-- DELETE
DELETE FROM Funcionario 
WHERE nome = 'Carlos';

DELETE FROM Consulta 
WHERE hora > '19:00:00';

DELETE FROM Consulta 
WHERE codp IN (
    SELECT codp FROM Paciente 
    WHERE doenca = 'Cancer' OR idade < 10
);

DELETE FROM Paciente 
WHERE doenca = 'Cancer' OR idade < 10;

DELETE FROM Medico 
WHERE cidade IN ('Biguaçu', 'Palhoça');

-- CONSULTAS
SELECT * FROM Paciente WHERE idade > 25;

SELECT cpf, nome FROM Paciente WHERE idade < 25;

SELECT DISTINCT especialidade FROM Medico;

SELECT nroa, CONCAT(ROUND(capacidade / 5), ' Grupos') 
AS grupo_de_5_leitos 
FROM Ambulatorio;

SELECT nome, salario, salario * 0.9 AS salario_com_desconto 
FROM Funcionario;

SELECT COUNT(*) AS total_med_ortop 
FROM Medico 
WHERE especialidade = 'ortopedia';

SELECT CONCAT('O CPF DO DR(A) ', nome, ' É ', cpf) 
AS frase 
FROM Medico;

SELECT nome, idade * 12 AS idade_em_meses 
FROM Paciente;

-- JOIN
SELECT P.nome, P.doenca, C.hora 
FROM Paciente P 
JOIN Consulta C ON P.codp = C.codp 
WHERE C.hora > '14:00:00';

SELECT M.nome, M.especialidade 
FROM Medico M 
JOIN Ambulatorio A ON M.nroa = A.nroa 
WHERE A.andar = 2;

SELECT M.nome, M.especialidade 
FROM Medico M 
LEFT JOIN Consulta C ON M.codm = C.codm 
WHERE C.codm IS NULL;

SELECT M.nome, C.data_cons 
FROM Medico M 
JOIN Consulta C ON M.codm = C.codm;

SELECT M.nome, C.data_cons 
FROM Medico M 
LEFT JOIN Consulta C ON M.codm = C.codm;

SELECT M.nome, C.data_cons, C.hora 
FROM Medico M 
RIGHT JOIN Consulta C ON M.codm = C.codm;

SELECT P.codp, P.nome, P.idade 
FROM Paciente P 
JOIN Consulta C ON P.codp = C.codp
JOIN Medico M ON C.codm = M.codm 
WHERE M.especialidade = 'ortopedia';

-- Quantas consultas por médico
SELECT codm, COUNT(*) FROM Consulta GROUP BY codm;

-- Pacientes mais frequentes
SELECT codp, COUNT(*) FROM Consulta GROUP BY codp ORDER BY COUNT(*) DESC;
