<%@page import="java.util.List"%>
<%@page import="dao.ProfessorDAO"%>
<%@page import="dao.DisciplinaDAO"%>
<%@page import="model.Professor"%>
<%@page import="model.Disciplina"%>

<%
ProfessorDAO professorDAO = new ProfessorDAO();
DisciplinaDAO disciplinaDAO = new DisciplinaDAO();

List<Professor> professores =
        professorDAO.listar();

List<Disciplina> disciplinas =
        disciplinaDAO.listar();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nova Turma</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div class="sidebar">

    <div class="logo">
        Universidade
    </div>

    <ul class="menu">
        <li><a href="../index.jsp">Dashboard</a></li>
        <li><a href="../professor/listar.jsp">Professores</a></li>
        <li><a href="../disciplina/listar.jsp">Disciplinas</a></li>
        <li><a href="listar.jsp">Turmas</a></li>
    </ul>

</div>

<div class="main">

    <div class="card">

        <h2>Cadastro de Turma</h2>

        <form action="../TurmaServlet" method="post">

            <div class="form-group">
                <label>Código da Turma</label>
                <input type="number" name="codigo">
            </div>

            <div class="form-group">
                <label>Semestre</label>
                <input type="text" name="semestre">
            </div>

            <div class="form-group">
                <label>Número de Alunos</label>
                <input type="number" name="alunos">
            </div>

            <div class="form-group">
                <label>Horário</label>

                <select name="horario">
                    <option value="MANHA">MANHÃ</option>
                    <option value="TARDE">TARDE</option>
                    <option value="NOITE">NOITE</option>
                </select>

            </div>

            <div class="form-group">

                <label>Professor</label>

                <select name="professor">

                    <% for(Professor p : professores){ %>

                    <option value="<%= p.getMatricula() %>">

                        <%= p.getNome() %>

                    </option>

                    <% } %>

                </select>

            </div>

            <div class="form-group">

                <label>Disciplina</label>

                <select name="disciplina">

                    <% for(Disciplina d : disciplinas){ %>

                    <option value="<%= d.getCodigoDisciplina() %>">

                        <%= d.getNomeDisciplina() %>

                    </option>

                    <% } %>

                </select>

            </div>

            <button class="btn">
                Salvar
            </button>

        </form>

    </div>

</div>

</body>
</html>