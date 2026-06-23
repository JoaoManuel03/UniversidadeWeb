<%@page import="java.sql.ResultSet"%>
<%@page import="dao.TurmaDAO"%>

<%
TurmaDAO dao = new TurmaDAO();
ResultSet rs = dao.listarCompleto();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Turmas</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div class="sidebar">

    <div class="logo">
        Universidade Web
    </div>

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

    <div class="header">
        <h3>Turmas</h3>
    </div>

    <div class="content">

        <div class="card">

            <div style="display:flex;justify-content:space-between;">

                <h2>Lista de Turmas</h2>

                <a href="formulario.jsp" class="btn">
                    Nova Turma
                </a>

            </div>

            <table>

                <tr>
                    <th>Codigo</th>
                    <th>Semestre</th>
                    <th>Alunos</th>
                    <th>Horario</th>
                    <th>Professor</th>
                    <th>Disciplina</th>
                </tr>

                <% while(rs != null && rs.next()){ %>

                <tr>

                    <td>
                        <%= rs.getInt("codigo_turma") %>
                    </td>

                    <td>
                        <%= rs.getString("semestre") %>
                    </td>

                    <td>
                        <%= rs.getInt("numero_alunos") %>
                    </td>

                    <td>
                        <%= rs.getString("horario") %>
                    </td>

                    <td>
                        <%= rs.getString("professor") %>
                    </td>

                    <td>
                        <%= rs.getString("disciplina") %>
                    </td>

                </tr>

                <% } %>

            </table>

        </div>

    </div>

</div>

</body>
</html>