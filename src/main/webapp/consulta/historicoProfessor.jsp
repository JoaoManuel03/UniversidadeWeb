<%@page import="java.sql.*"%>
<%@page import="util.Conexao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Histórico do Professor</title>
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
        <li><a href="../turma/listar.jsp">Turmas</a></li>
        <li><a href="historicoProfessor.jsp" class="active">Consultas</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><h3>Consultas - Histórico do Professor</h3></div>
    <div class="content">
        <div class="card">
            <h2>Histórico de Disciplinas Ministradas</h2>
            <form method="get">
                <div class="form-group">
                    <label>Escolha o Professor:</label>
                    <select name="professor" required>
                        <option value="">-- Selecione --</option>
                        <%
                        Connection conn = Conexao.conectar();
                        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM professor ORDER BY nome");
                        ResultSet rs = stmt.executeQuery();
                        while(rs.next()){
                            String selected = "";
                            String param = request.getParameter("professor");
                            if(param != null && param.equals(String.valueOf(rs.getInt("matricula")))){
                                selected = "selected";
                            }
                        %>
                        <option value="<%= rs.getInt("matricula") %>" <%= selected %>>
                            <%= rs.getString("nome") %>
                        </option>
                        <% } 
                        rs.close();
                        stmt.close();
                        %>
                    </select>
                </div>
                <button class="btn">Consultar</button>
            </form>

            <br><hr><br>

            <%
            String professor = request.getParameter("professor");
            if(professor != null && !professor.isEmpty()){
                // Buscar nome do professor
                PreparedStatement psProf = conn.prepareStatement("SELECT nome FROM professor WHERE matricula = ?");
                psProf.setInt(1, Integer.parseInt(professor));
                ResultSet rsProf = psProf.executeQuery();
                String nomeProfessor = "";
                if(rsProf.next()){
                    nomeProfessor = rsProf.getString("nome");
                }
                rsProf.close();
                psProf.close();

                // CONSULTA F - Histórico do Professor
                String sql = "SELECT " +
                             "d.nome_disciplina, " +
                             "SUM(d.carga_horaria) AS carga_total, " +
                             "SUM(t.numero_alunos) AS total_alunos, " +
                             "COUNT(t.codigo_turma) AS total_turmas " +
                             "FROM turma t " +
                             "INNER JOIN disciplina d ON t.codigo_disciplina = d.codigo_disciplina " +
                             "WHERE t.matricula_professor = ? " +
                             "GROUP BY d.codigo_disciplina, d.nome_disciplina " +
                             "ORDER BY d.nome_disciplina";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(professor));
                ResultSet resultado = ps.executeQuery();
            %>
                <h3>Histórico de: <strong><%= nomeProfessor %></strong></h3>
                
                <% if(!resultado.isBeforeFirst()){ %>
                    <p style="color:#888; text-align:center; padding:20px;">
                         Este professor não ministrou nenhuma disciplina ainda.
                    </p>
                <% } else { %>
                    <table>
                        <tr>
                            <th>Disciplina</th>
                            <th>Turmas</th>
                            <th>Carga Horaria Total</th>
                            <th>Total de Alunos</th>
                        </tr>
                        <% while(resultado.next()){ %>
                        <tr>
                            <td><strong><%= resultado.getString("nome_disciplina") %></strong></td>
                            <td><%= resultado.getInt("total_turmas") %></td>
                            <td><%= resultado.getInt("carga_total") %> horas</td>
                            <td><%= resultado.getInt("total_alunos") %></td>
                        </tr>
                        <% } %>
                    </table>
                    <br>
                    <p style="text-align:right; color:#666; font-size:13px;">
                        * Carga horaria total = soma de todas as turmas ministradas nesta disciplina
                    </p>
                <% } 
                resultado.close();
                ps.close();
            }
            conn.close();
            %>
        </div>
    </div>
</div>
</body>
</html>