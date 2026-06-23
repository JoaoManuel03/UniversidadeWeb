<%@page import="java.util.List"%>
<%@page import="dao.DisciplinaDAO"%>
<%@page import="model.Disciplina"%>
<%
DisciplinaDAO disciplinaDAO = new DisciplinaDAO();
List<Disciplina> disciplinas = disciplinaDAO.listar();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Novo Professor</title>
<link rel="stylesheet" href="../css/style.css">
<style>
    .checkbox-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 10px;
        margin-top: 10px;
    }
    .checkbox-grid label {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: normal;
        cursor: pointer;
    }
    .checkbox-grid input[type="checkbox"] {
        width: 18px;
        height: 18px;
        cursor: pointer;
    }
</style>
</head>
<body>
<div class="sidebar">
    <div class="logo">Universidade Web</div>
    <ul class="menu">
        <li><a href="../index.jsp">Inicio</a></li>
        <li><a href="listar.jsp" class="active">Professores</a></li>
        <li><a href="../disciplina/listar.jsp">Disciplinas</a></li>
        <li><a href="../aptidao/listar.jsp">Aptidões</a></li>
        <li><a href="../turma/listar.jsp">Turmas</a></li>
        <li><a href="../consulta/professoresDisciplina.jsp">Consultas</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><h3>Novo Professor</h3></div>
    <div class="content">
        <div class="card">
            <form action="../ProfessorServlet" method="post">
                <div class="form-group">
                    <label>Matricula</label>
                    <input type="number" name="matricula" required>
                </div>
                <div class="form-group">
                    <label>Nome</label>
                    <input type="text" name="nome" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required>
                </div>
                <div class="form-group">
                    <label>Telefone</label>
                    <input type="text" name="telefone" required>
                </div>

                <!-- ============================================= -->
                <!-- SELECIONAR DISCIPLINAS QUE O PROFESSOR DOMINA -->
                <!-- ============================================= -->
                <div class="form-group">
                    <label>Disciplinas que o professor domina:</label>
                    <div class="checkbox-grid">
                        <% for(Disciplina d : disciplinas){ %>
                        <label>
                            <input type="checkbox" name="disciplinas" value="<%= d.getCodigoDisciplina() %>">
                            <%= d.getNomeDisciplina() %>
                        </label>
                        <% } %>
                    </div>
                </div>

                <button class="btn">Salvar</button>
                <a href="listar.jsp" class="btn" style="background:#ccc;color:#333;">Cancelar</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>