create database dbProjetoIndividual;
use dbProjetoIndividual;

create table tb_usuario(
	id_usuario int primary key auto_increment,
    nome varchar(50) not null,
    dtNasc date not null,
    email varchar(80),
    senha varchar(50)
);

create table tb_discussao(
	id_discussao int,
    fkDiscussaoUsuario int,
    constraint primary key (id_discussao, fkDiscussaoUsuario),
    titulo varchar(100) not null,
    descricao varchar(300) not null,
    dtPostagem datetime default current_timestamp,
    constraint fkAutorDiscussao foreign key (fkDiscussaoUsuario)
		references tb_usuario (id_usuario)
);

create table tb_comentario(
	id_comentario int primary key auto_increment,
    comentario varchar(200) not null,
    dtPostagem datetime default current_timestamp,
    fkDiscussao int not null,
    fkAutorDiscussao int not null,
    fkAutorComentario int not null,
    fkRespostaComentario int,
    
    constraint fkDiscussaoComentario foreign key (fkDiscussao)
		references tb_discussao(id_discussao),
	constraint fkCriadorTopico foreign key (fkAutorDiscussao)
		references tb_usuario(id_usuario),
	constraint fkCriadorComentario foreign key (fkAutorComentario)
		references tb_usuario(id_usuario)
);

create table tb_curtida_discussao(
    fkDiscussao int,
    fkAutorDiscussao int,
    fkAutorCurtida int,
    constraint primary key(fkDiscussao, fkAutorDiscussao, fkAutorCurtida),
    constraint fkDiscussaoCurtida foreign key (fkDiscussao)
		references tb_discussao(id_discussao),
	constraint fkAutor foreign key (fkAutorDiscussao)
		references tb_usuario(id_usuario),
	constraint fkCurtidor foreign key (fkAutorCurtida)
		references tb_usuario(id_usuario)
);

create table tb_curtida_comentario(
    fkComentario int,
    fkAutorCurtida int,
    constraint primary key (fkComentario, fkAutorCurtida),
    constraint fkAutorComentario foreign key (fkComentario)
		references tb_comentario(id_comentario),
	constraint fkCurtidorComentario foreign key (fkAutorCurtida)
		references tb_usuario(id_usuario)
);

create table tb_quiz(
	id_quiz int primary key auto_increment,
    titulo varchar(100) not null,
    descricao varchar(100) not null,
    dtCriado datetime default current_timestamp
);

create table tb_pergunta(
	id_pergunta int,
    fkQuiz int,
    constraint primary key (id_pergunta, fkQuiz),
    pergunta varchar(150) not null,
    resposta varchar(50) not null
);

create table tb_resposta_usuario(
	id_resposta_usuario int,
    resposta varchar(40) not null,
    fkUsuario int,
    fkPergunta int,
    fkQuiz int,
    constraint primary key (id_resposta_usuario, fkUsuario, fkPergunta, fkQuiz),
    constraint fkResUsuario foreign key (fkUsuario)
		references tb_usuario(id_usuario),
	constraint fkPerguntaQuiz foreign key (fkPergunta)
		references tb_pergunta(id_pergunta),
	constraint fkFormularioQuiz foreign key (fkQuiz) 
		references tb_quiz(id_quiz)
);

create table tb_pontuacao_quiz(
	id_pontuacao_quiz int,
    qtdAcertos int,
    fkUsuario int,
    fkQuiz int,
    constraint primary key(id_pontuacao_quiz, fkUsuario, fkQuiz),
    constraint fkQuizUsuario foreign key (fkUsuario)
		references tb_usuario(id_usuario),
    constraint fkQuizFeito foreign key (fkQuiz)
		references tb_quiz(id_quiz)
);

create table tb_alternativas(
	id_alternativa int primary key auto_increment,
    alternativa varchar(50),
    fkQuiz int,
    constraint fkAlternativaQuiz foreign key (fkQuiz)
		references tb_quiz (id_quiz)
);

INSERT INTO tb_usuario (nome, dtNasc, email, senha) VALUES
	('JoãoSilva', '1990-03-15', 'joao.silva@example.com', 'senha123'),
	('MariaSantos', '1985-07-20', 'maria.santos@example.com', 'senha456'),
	('PedroOliveira', '1995-01-10', 'pedro.oliveira@example.com', 'senha789'),
	('AnaSouza', '1988-09-25', 'ana.souza@example.com', 'senhaabc'),
	('LucasPereira', '1992-05-30', 'lucas.pereira@example.com', 'senhaxyz'),
	('CarlaCosta', '1998-11-12', 'carla.costa@example.com', 'senhajkl'),
	('FernandoAlmeida', '1983-04-18', 'fernando.almeida@example.com', 'senhawxy'),
	('JulianaLima', '1991-08-05', 'juliana.lima@example.com', 'senharst'),
	('MarcosSantos', '1987-02-28', 'marcos.santos@example.com', 'senha456'),
	('MarianaOliveira', '1994-06-22', 'mariana.oliveira@example.com', 'senha789'),
	('MonicaGonçalvez', '1996-11-22', 'monica@hotmail.com', 'ahnescba'),
	('PedroMagalhaes', '1993-01-01', 'pedrinho@outlook.com', 'senhapqp'),
	('Lkzin77', '2001-12-21', 'lkzinBrabo@gmail.com', 'bolinhadeGolfe');
    
INSERT INTO tb_discussao (id_discussao, fkDiscussaoUsuario, titulo, descricao, dtPostagem) VALUES
	(1, 2, 'Teorias sobre Invencível: Próximos Episódios', 'Quais são as suas teorias para os próximos episódios de Invencível? Compartilhe suas especulações e expectativas.', '2023-06-19 18:20:22'),
	(2, 2, 'Cenas Épicas em Invencível', 'Quais foram as cenas mais épicas que você viu em Invencível até agora? Discuta momentos de ação e emocionantes.', '2024-01-04 14:29:58'),
	(1, 1, 'Conversa sobre Invencível: Quadrinhos vs. Série', 'Comparação entre os quadrinhos e a série Invencível. O que você acha das adaptações e das diferenças entre os dois formatos?', '2024-02-13 20:13:47');

INSERT INTO tb_comentario VALUES
    (null, 'A série Invencível capturou a essência dos quadrinhos de uma forma incrível! Estou impressionado com a fidelidade à história original', '2024-02-13 21:01:22', 1, 1, 6, null),
    (null, 'Embora a série Invencível tenha algumas diferenças em relação aos quadrinhos, acho que as mudanças ajudam a adaptar a história para um novo público.', '2024-02-14 11:01:22', 1, 1, 2, null),
    (null, 'Os quadrinhos de Invencível são ótimos, mas a série expande ainda mais o universo e os personagens de uma maneira que os fãs antigos e novos podem apreciar.', '2024-02-13 20:31:22', 1, 1, 8, null),
    (null, 'Embora a serie esteja otima, ainda prefiro os quadrinhos', '2024-02-14 09:31:22', 1, 1, 7, 3),
    (null, 'As cenas épicas em Invencível são de tirar o fôlego! Cada momento de ação é meticulosamente animado e emocionante de assistir.', '2024-01-04 14:34:01', 2, 2, 9, null),
    (null, 'Nao tem oq o reclamar, os animadores se esforçaram ao máximo!', '2024-01-04 14:57:01', 2, 2, 5, 5),
    (null, 'Realmente, na luta contra os viltrumitas os caras arrasaram dms!!!', '2024-01-04 15:09:41', 2, 2, 2, 5),
    (null, 'Estou tão empolgado para os próximos episódios de Invencível! Minha teoria é que veremos mais sobre o passado misterioso de alguns personagens-chave.', '2023-06-20 10:33:43', 1, 2, 9, null),
    (null, 'Estou especulando que nos próximos episódios de Invencível, veremos o protagonista enfrentando consequências cada vez mais graves de suas escolhas e ações.', '2023-06-22 16:29:53', 1, 2, 6, null);

INSERT INTO tb_curtida_discussao VALUES
    (1, 2, 6),
    (2, 2, 4),
    (1, 1, 2),
    (2, 2, 8),
    (1, 1, 5),
    (2, 2, 6),
    (1, 1, 3);
    
INSERT INTO tb_curtida_comentario VALUES
	(3, 4),
	(2, 4),
	(1, 8),
	(3, 8),
	(2, 5),
	(3, 2),
	(3, 1),
	(6, 1);

INSERT INTO tb_quiz VALUES
	(null, 'Personagens da Série!', 'Desafio Invecível: Teste seu Conhecimento sobre o elenco da obra, você realmente conhece todos?', default),
	(null, 'Poderes dos Personagens de Invencível!', 'Descubra o quanto você sabe sobre as habilidades únicas dos personagens da série.', default);
    
INSERT INTO tb_pergunta VALUES
	(1, 1, 'Quem é o protagonista da série "Invencível"?', 'Mark Grayson'),
	(2, 1, 'Qual é o nome do pai de Mark e um dos super-heróis mais poderosos da Terra?', 'Nolan Grayson'),
	(3, 1, 'Quem trabalha diretamente sob as ordens de Cecil Stedman na Agência de Defesa Global?', 'Donald Ferguson'),
	(4, 1, 'Quem é o melhor amigo de Mark e um dos poucos que sabe sobre sua identidade como Invencível?', 'William Clockwell'),
	(5, 1, 'Qual é o nome da interesse amoroso de Mark na série "Invencível"?', 'Amber Bennett'),
	(6, 1, 'Quem Cecil Stedman recruta para reformar os Guardiões do Globo após a morte dos membros originais?', 'Rudy Connors'),
	(7, 1, 'Quem é inicialmente desconfiado das motivações de Robot após descobrir seu verdadeiro nome e história?', 'Mark Grayson'),
	(8, 1, 'Quem é o principal aliado de Debbie Grayson após a revelação da missão de Nolan Grayson?', 'Cecil Stedman'),
	(9, 2, 'Qual é o principal poder de Mark Grayson?', 'Super força e voo'),
	(10, 2, 'Qual destas NÃO é uma das habilidadades de Omni-Man?', 'Manipulação do tempo'),
	(11, 2, 'Qual é a principal habilidade de Eve Atômica?', 'Manipulação de matéria'),
	(12, 2, 'Qual é o poder principal de Dupli-Kate?', 'Criação de clones'),
	(13, 2, 'Rex Splode possui um poder que o diferencia dos outros heróis. Qual é esse poder?', 'Objetos explosivos'),
	(14, 2, 'O que caracteriza principalmente os poderes de Monster Girl?', 'Transformação em monstro'),
	(15, 2, 'Quais são as habilidades principais de Black Samson após a sua recuperação?', 'Manipulação elétrica'),
	(16, 2, 'Qual é o poder principal de Shrinking Rae?', 'Encolhimento'),
	(17, 2, 'Qual habilidade distingue principalmente o personagem The Immortal?', 'Imortalidade'),
	(18, 2, 'Qual é a principal habilidade de Cecil Stedman que o torna importante para a GDA)?', 'Inteligência tática');
    
INSERT INTO tb_alternativas VALUES
	(null, 'Mark Grayson', 1),
	(null, 'Nolan Grayson', 1),
	(null, 'Amber Bennett', 1),
	(null, 'Cecil Stedman', 1),
	(null, 'Debbie Grayson', 1),
	(null, 'Manipulação de matéria', 2),
	(null, 'Encolhimento', 2),
	(null, 'Super força e voo', 2),
	(null, 'Inteligência tática', 2),
	(null, 'Criação de clones', 2);
    
select * from tb_usuario;
select * from tb_discussao;
select * from tb_comentario;
select * from tb_quiz;
select * from tb_pergunta;
select * from tb_curtida_discussao;
select * from tb_curtida_comentario;
select * from tb_alternativas;
select * from tb_resposta_usuario;

-- SELECT para ver as discussões que cada usuário criou 
select tb_usuario.*, tb_discussao.*
	from tb_usuario join tb_discussao
    on tb_discussao.fkDiscussaoUsuario = tb_usuario.id_usuario;

-- SELECT para ver os comentarios de cada usuário
select tb_usuario.*, tb_comentario.*
	from tb_usuario join tb_comentario
    on tb_usuario.id_usuario = tb_comentario.fkAutorComentario;

-- SELECT para ver os comentarios com respostas
select tb_comentario.*, respostaComentario.*
	from tb_comentario join tb_comentario as respostaComentario
    on tb_comentario.fkRespostaComentario = respostaComentario.id_comentario;
    
-- SELECT para ver os comentários de cada discussão
select tb_discussao.*, tb_comentario.*
	from tb_discussao join tb_comentario
    on tb_discussao.fkDiscussaoUsuario = tb_comentario.fkAutorDiscussao
    and tb_discussao.id_discussao = tb_comentario.fkDiscussao;
    
SELECT tb_resposta_usuario.id_resposta_usuario AS 'Tentativa',
	tb_resposta_usuario.fkQuiz AS 'Quiz',
    tb_pergunta.pergunta AS 'Pergunta',
	tb_resposta_usuario.resposta AS 'Resposta_usuario',
	tb_pergunta.resposta AS 'Resposta_pergunta'
    from tb_resposta_usuario
    JOIN tb_pergunta
    ON tb_pergunta.id_pergunta = tb_resposta_usuario.fkPergunta;
    
SELECT tb_quiz.*, 
    COUNT(tb_pontuacao_quiz.id_pontuacao_quiz) AS tentativas 
	FROM tb_quiz
	JOIN tb_pontuacao_quiz 
    ON tb_quiz.id_quiz = tb_pontuacao_quiz.fkQuiz 
    AND tb_pontuacao_quiz.fkUsuario = 1
	GROUP BY tb_quiz.id_quiz;