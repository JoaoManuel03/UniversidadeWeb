<%@page import="java.sql.*"%>
<%@page import="util.Conexao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Professores por Disciplina</title>
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
        <li><a href="professoresDisciplina.jsp" class="active">Consultas</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><h3>Consultas - Professores por Disciplina</h3></div>
    <div class="content">
        <div class="card">
            <h2>Professores que Ministraram uma Disciplina</h2>
            <form method="get">
                <div class="form-group">
                    <label>Escolha a Disciplina:</label>
                    <select name="disciplina" required>
                        <option value="">-- Selecione --</option>
                        <%
                        Connection conn = Conexao.conectar();
                        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM disciplina ORDER BY nome_disciplina");
                        ResultSet rs = stmt.executeQuery();
                        while(rs.next()){
                            String selected = "";
                            String param = request.getParameter("disciplina");
                            if(param != null && param.equals(String.valueOf(rs.getInt("codigo_disciplina")))){
                                selected = "selected";
                            }
                        %>
                        <option value="<%= rs.getInt("codigo_disciplina") %>" <%= selected %>>
                            <%= rs.getString("nome_disciplina") %>
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
            String disciplina = request.getParameter("disciplina");
            if(disciplina != null && !disciplina.isEmpty()){
                // Buscar nome da disciplina
                PreparedStatement psDisc = conn.prepareStatement("SELECT nome_disciplina FROM disciplina WHERE codigo_disciplina = ?");
                psDisc.setInt(1, Integer.parseInt(disciplina));
                ResultSet rsDisc = psDisc.executeQuery();
                String nomeDisciplina = "";
                if(rsDisc.next()){
                    nomeDisciplina = rsDisc.getString("nome_disciplina");
                }
                rsDisc.close();
                psDisc.close();

                // CONSULTA: Professores que ministraram esta disciplina, com resumo
                String sql = "SELECT " +
                             "p.matricula, " +
                             "p.nome AS professor, " +
                             "p.email, " +
                             "p.telefone, " +
                             "COUNT(t.codigo_turma) AS total_turmas, " +
                             "SUM(d.carga_horaria) AS carga_total, " +
                             "SUM(t.numero_alunos) AS total_alunos " +
                             "FROM turma t " +
                             "INNER JOIN professor p ON t.matricula_professor = p.matricula " +
                             "INNER JOIN disciplina d ON t.codigo_disciplina = d.codigo_disciplina " +
                             "WHERE t.codigo_disciplina = ? " +
                             "GROUP BY p.matricula, p.nome, p.email, p.telefone " +
                             "ORDER BY p.nome";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(disciplina));
                ResultSet resultado = ps.executeQuery();
            %>
                <h3>Disciplina: <strong><%= nomeDisciplina %></strong></h3>
                
                <% if(!resultado.isBeforeFirst()){ %>
                    <p style="color:#888; text-align:center; padding:20px;">
                         Nenhum professor ministrou esta disciplina ainda.
                    </p>
                <% } else { %>
                    <table>
                        <tr>
                            <th>Professor</th>
                            <th>Email</th>
                            <th>Telefone</th>
                            <th>Turmas</th>
                            <th>Carga Horaria Total</th>
                            <th>Total de Alunos</th>
                        </tr>
                        <% while(resultado.next()){ %>
                        <tr>
                            <td><strong><%= resultado.getString("professor") %></strong></td>
                            <td><%= resultado.getString("email") %></td>
                            <td><%= resultado.getString("telefone") %></td>
                            <td><%= resultado.getInt("total_turmas") %></td>
                            <td><%= resultado.getInt("carga_total") %> horas</td>
                            <td><%= resultado.getInt("total_alunos") %></td>
                        </tr>
                        <% } %>
                    </table>
                    <br>
                    <p style="text-align:right; color:#666; font-size:13px;">
                        * Carga horaria total = soma de todas as turmas que o professor ministrou nesta disciplina
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