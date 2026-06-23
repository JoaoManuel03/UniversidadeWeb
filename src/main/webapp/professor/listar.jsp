<%@ page import="java.util.List" %>
<%@ page import="dao.ProfessorDAO" %>
<%@ page import="model.Professor" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Professores</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div class="sidebar">

<div class="logo">
        Universidade Web
    </div>

    <ul class="menu">
    <li><a href="../index.jsp">Inicio</a></li>
    <li><a href="listar.jsp" class="active">Professores</a></li>  
    <li><a href="../disciplina/listar.jsp">Disciplinas</a></li>
    <li><a href="../aptidao/listar.jsp">Aptidoes</a></li>
    <li><a href="../turma/listar.jsp">Turmas</a></li>
    <li><a href="../consulta/professoresDisciplina.jsp">Consultas</a></li>
</ul>
</div>

<div class="main">

    <div class="header">
        <h3>Professores</h3>
    </div>

    <div class="content">

        <div class="card">

            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
                <h2>Lista de Professores</h2>

                <a href="formulario.jsp" class="btn">
                    Novo Professor
                </a>
            </div>

            <table>

                <tr>
                    <th>Matricula</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Telefone</th>
                    <th>Acoes</th>
                </tr>

                <%
                ProfessorDAO dao = new ProfessorDAO();
                List<Professor> lista = dao.listar();

                for(Professor p : lista){
                %>

                <tr>
                    <td><%= p.getMatricula() %></td>
                    <td><%= p.getNome() %></td>
                    <td><%= p.getEmail() %></td>
                    <td><%= p.getTelefone() %></td>

                    <td class="actions">
                        <a href="editar.jsp?matricula=<%=p.getMatricula()%>">
    Editar
</a>
                        <a href="../ProfessorServlet?acao=excluir&matricula=<%=p.getMatricula()%>">
                            Excluir
                        </a>
                    </td>
                </tr>

                <%
                }
                %>

            </table>

        </div>

    </div>

</div>

</body>
</html>