<%@page import="java.util.List"%>
<%@page import="dao.ProfessorDAO"%>
<%@page import="dao.DisciplinaDAO"%>
<%@page import="model.Professor"%>
<%@page import="model.Disciplina"%>
<%
ProfessorDAO professorDAO = new ProfessorDAO();
DisciplinaDAO disciplinaDAO = new DisciplinaDAO();
List<Professor> professores = professorDAO.listar();
List<Disciplina> disciplinas = disciplinaDAO.listar();
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
    <div class="logo">Universidade Web</div>
    <ul class="menu">
        <li><a href="../index.jsp">Inicio</a></li>
        <li><a href="../professor/listar.jsp">Professores</a></li>
        <li><a href="../disciplina/listar.jsp">Disciplinas</a></li>
        <li><a href="../aptidao/listar.jsp">Aptidoes</a></li>
        <li><a href="listar.jsp" class="active">Turmas</a></li>
        <li><a href="../consulta/professoresDisciplina.jsp">Consultas</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><h3>Nova Turma</h3></div>
    <div class="content">
        <div class="card">
            <h2>Nova Turma</h2>
            <form action="../TurmaServlet" method="post">
                <div class="form-group">
                    <label>Codigo da Turma</label>
                    <input type="number" name="codigo" required>
                </div>
                <div class="form-group">
                    <label>Professor</label>
                    <select name="professor" required>
                        <option value="">-- Selecione --</option>
                        <% for(Professor p : professores){ %>
                        <option value="<%= p.getMatricula() %>">
                            <%= p.getNome() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label>Disciplina</label>
                    <select name="disciplina" required>
                        <option value="">-- Selecione --</option>
                        <% for(Disciplina d : disciplinas){ %>
                        <option value="<%= d.getCodigoDisciplina() %>">
                            <%= d.getNomeDisciplina() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label>Semestre</label>
                    <input type="text" name="semestre" required>
                </div>
                <div class="form-group">
                    <label>Numero de Alunos</label>
                    <input type="number" name="alunos" required>
                </div>
                <div class="form-group">
                    <label>Horario</label>
                    <select name="horario" required>
                        <option value="MANHA">MANHÃ</option>
                        <option value="TARDE">TARDE</option>
                        <option value="NOITE">NOITE</option>
                    </select>
                </div>
                <button class="btn">Salvar</button>
                <a href="listar.jsp" class="btn" style="background:#ccc;color:#333;">Cancelar</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>