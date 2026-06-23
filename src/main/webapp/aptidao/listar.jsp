<%@page import="java.util.List"%>
<%@page import="dao.AptidaoDAO"%>
<%@page import="model.Aptidao"%>
<%@page import="dao.ProfessorDAO"%>
<%@page import="model.Professor"%>
<%@page import="java.sql.*"%>
<%@page import="util.Conexao"%>
<%
AptidaoDAO aptidaoDAO = new AptidaoDAO();
List<Aptidao> lista = aptidaoDAO.listar();

ProfessorDAO professorDAO = new ProfessorDAO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Aptidoes</title>
<link rel="stylesheet" href="../css/style.css">
<style>
    .consulta-aptidao {
        background: #f0f4f8;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 30px;
        border-left: 4px solid #1F3A5F;
    }
    .consulta-aptidao h3 {
        margin-top: 0;
        color: #1F3A5F;
    }
    .consulta-aptidao form {
        display: flex;
        gap: 10px;
        align-items: flex-end;
        flex-wrap: wrap;
    }
    .consulta-aptidao .form-group {
        flex: 1;
        min-width: 200px;
    }
    .consulta-aptidao .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: 600;
        font-size: 14px;
    }
    .consulta-aptidao .form-group select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .consulta-aptidao .btn {
        padding: 10px 25px;
        background: #1F3A5F;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        height: 42px;
    }
    .consulta-aptidao .btn:hover {
        background: #2C5282;
    }
    .resultado-consulta {
        margin-top: 20px;
    }
    .resultado-consulta table {
        margin-top: 10px;
    }
    .sem-dados {
        color: #888;
        text-align: center;
        padding: 20px;
    }
    .divider {
        border: none;
        border-top: 2px solid #e0e0e0;
        margin: 30px 0;
    }
    .secao-titulo {
        color: #1F3A5F;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
    }
    .secao-titulo span {
        background: #1F3A5F;
        color: white;
        padding: 2px 12px;
        border-radius: 20px;
        font-size: 12px;
    }
    .info-box {
        background: #e8f0fe;
        padding: 12px 18px;
        border-radius: 6px;
        margin-bottom: 20px;
        color: #1F3A5F;
        font-size: 14px;
        border-left: 3px solid #1F3A5F;
    }
    .info-box strong {
        color: #1F3A5F;
    }
</style>
</head>
<body>
<div class="sidebar">
    <div class="logo">Universidade Web</div>
    <ul class="menu">
        <li><a href="../index.jsp">Inicio</a></li>
        <li><a href="../professor/listar.jsp">Professores</a></li>
        <li><a href="../disciplina/listar.jsp">Disciplinas</a></li>
        <li><a href="listar.jsp" class="active">Aptidoes</a></li>
        <li><a href="../turma/listar.jsp">Turmas</a></li>
        <li><a href="../consulta/professoresDisciplina.jsp">Consultas</a></li>
    </ul>
</div>
<div class="main">
    <div class="header"><h3>Aptidoes</h3></div>
    <div class="content">
        
        <!-- ============================================= -->
        <!-- SEÇÃO 1: CONSULTA PROFESSORES POR DISCIPLINA -->
        <!-- ============================================= -->
        <div class="card consulta-aptidao">
            <h3> Consultar Professores Aptos por Disciplina</h3>
            <p style="color:#666; font-size:14px; margin-bottom:15px;">
                Selecione uma disciplina para ver quais professores estao aptos a ministra-la.
            </p>
            <form method="get" action="listar.jsp">
                <div class="form-group">
                    <label>Escolha a Disciplina:</label>
                    <select name="disciplina_consulta" required>
                        <option value="">-- Selecione --</option>
                        <%
                        Connection conn = Conexao.conectar();
                        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM disciplina ORDER BY nome_disciplina");
                        ResultSet rs = stmt.executeQuery();
                        while(rs.next()){
                            String selected = "";
                            String param = request.getParameter("disciplina_consulta");
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
                <button type="submit" class="btn">Consultar</button>
            </form>

            <%
            String disciplinaConsulta = request.getParameter("disciplina_consulta");
            if(disciplinaConsulta != null && !disciplinaConsulta.isEmpty()){
                // Buscar nome da disciplina
                PreparedStatement psDisc = conn.prepareStatement("SELECT nome_disciplina FROM disciplina WHERE codigo_disciplina = ?");
                psDisc.setInt(1, Integer.parseInt(disciplinaConsulta));
                ResultSet rsDisc = psDisc.executeQuery();
                String nomeDisciplina = "";
                if(rsDisc.next()){
                    nomeDisciplina = rsDisc.getString("nome_disciplina");
                }
                rsDisc.close();
                psDisc.close();

                // Buscar professores aptos
                String sql = "SELECT DISTINCT p.matricula, p.nome, p.email, p.telefone " +
                             "FROM professor p " +
                             "INNER JOIN professor_disciplina pd ON p.matricula = pd.matricula_professor " +
                             "WHERE pd.codigo_disciplina = ? " +
                             "ORDER BY p.nome";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(disciplinaConsulta));
                ResultSet resultado = ps.executeQuery();
            %>
                <div class="resultado-consulta">
                    <h4> Professores aptos para: <strong><%= nomeDisciplina %></strong></h4>
                    <table>
                        <tr>
                            <th>Matrícula</th>
                            <th>Nome</th>
                            <th>Email</th>
                            <th>Telefone</th>
                        </tr>
                        <% if(!resultado.isBeforeFirst()){ %>
                            <tr><td colspan="4" style="text-align:center;">Nenhum professor apto para esta disciplina.</td></tr>
                        <% } else { %>
                            <% while(resultado.next()){ %>
                            <tr>
                                <td><%= resultado.getInt("matricula") %></td>
                                <td><%= resultado.getString("nome") %></td>
                                <td><%= resultado.getString("email") %></td>
                                <td><%= resultado.getString("telefone") %></td>
                            </tr>
                            <% } %>
                        <% } %>
                    </table>
                </div>
            <%
                resultado.close();
                ps.close();
            }
            conn.close();
            %>
        </div>

        <!-- ============================================= -->
        <!-- SEÇÃO 2: LISTA DE APTIDÕES CADASTRADAS       -->
        <!-- ============================================= -->
        <hr class="divider">

        <div class="card">
            <div class="secao-titulo">
                <h2> Lista de Aptidoes Cadastradas</h2>
                <span><%= (lista != null) ? lista.size() : 0 %> registros</span>
            </div>

            <!-- INFO: Explicação sobre como as aptidões são criadas -->
            <div class="info-box">
                <strong> Como as aptidoes sao criadas:</strong>
                <ul style="margin: 8px 0 0 20px; color: #333;">
                    <li> Quando uma diciplina e adicionada, ela ficarar disponivel, para ser adicionada a um professor</li>
                    <li> Ao criar um <strong>novo professor</strong>, voce pode selecionar as disciplinas que ele domina.</li>
                </ul>
            </div>
            
            <% if(lista == null || lista.isEmpty()){ %>
                <p class="sem-dados">Nenhuma aptidao cadastrada ainda.</p>
            <% } else { %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Professor</th>
                        <th>Disciplina que Domina</th>
                        <th>Acoes</th>
                    </tr>
                    <% for(Aptidao a : lista){ 
                        Professor p = professorDAO.buscarPorMatricula(a.getMatriculaProfessor());
                    %>
                    <tr>
                        <td><%= a.getId() %></td>
                        <td><%= (p != null) ? p.getNome() : "Professor não encontrado" %></td>
                        <td><%= a.getDescricao() %></td>
                        <td>
                            <a href="../AptidaoServlet?acao=excluir&id=<%= a.getId() %>" onclick="return confirm('Excluir esta aptidão?')">Excluir</a>
                        </td>
                    </tr>
                    <% } %>
                </table>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>