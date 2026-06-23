<%@page import="java.util.List"%>
<%@page import="dao.DisciplinaDAO"%>
<%@page import="model.Disciplina"%>
<%
DisciplinaDAO dao = new DisciplinaDAO();
List<Disciplina> lista = dao.listar();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Disciplinas</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="sidebar">
    <div class="logo">Universidade Web</div>
    <ul class="menu">
    <li><a href="../index.jsp">Inicio</a></li>
    <li><a href="../professor/listar.jsp">Professores</a></li>
    <li><a href="listar.jsp" class="active">Disciplinas</a></li> 
    <li><a href="../aptidao/listar.jsp">Aptidoes</a></li>
    <li><a href="../turma/listar.jsp">Turmas</a></li>
    <li><a href="../consulta/professoresDisciplina.jsp">Consultas</a></li>
</ul>
</div>
<div class="main">
    <div class="header"><h3>Disciplinas</h3></div>
    <div class="content">
        <div class="card">
            <div style="display:flex;justify-content:space-between;margin-bottom:20px;">
                <h2>Lista de Disciplinas</h2>
                <a href="formulario.jsp" class="btn">Nova Disciplina</a>
            </div>
            <table>
                <tr>
                    <th>Codigo</th>
                    <th>Nome</th>
                    <th>Carga Horaria</th>
                    <th>Acoes</th>
                </tr>
                <% for(Disciplina d : lista){ %>
                <tr>
                    <td><%= d.getCodigoDisciplina() %></td>
                    <td><%= d.getNomeDisciplina() %></td>
                    <td><%= d.getCargaHoraria() %></td>
                    <td>
                        <a href="editar.jsp?codigo=<%= d.getCodigoDisciplina() %>">Editar</a> |
                        <a href="../DisciplinaServlet?acao=excluir&codigo=<%= d.getCodigoDisciplina() %>" onclick="return confirm('Excluir esta disciplina?')">Excluir</a>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
    </div>
</div>
</body>
</html>