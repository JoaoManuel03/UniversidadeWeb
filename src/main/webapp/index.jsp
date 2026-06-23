<%@page import="java.sql.*"%>
<%@page import="util.Conexao"%>
<%@page import="dao.TurmaDAO"%>
<%@page import="dao.ProfessorDAO"%>
<%
// Buscar contadores
Connection conn = Conexao.conectar();

PreparedStatement stmtProf = conn.prepareStatement("SELECT COUNT(*) AS total FROM professor");
ResultSet rsProf = stmtProf.executeQuery();
rsProf.next();
int totalProfessores = rsProf.getInt("total");

PreparedStatement stmtDisc = conn.prepareStatement("SELECT COUNT(*) AS total FROM disciplina");
ResultSet rsDisc = stmtDisc.executeQuery();
rsDisc.next();
int totalDisciplinas = rsDisc.getInt("total");

PreparedStatement stmtTurma = conn.prepareStatement("SELECT COUNT(*) AS total FROM turma");
ResultSet rsTurma = stmtTurma.executeQuery();
rsTurma.next();
int totalTurmas = rsTurma.getInt("total");

PreparedStatement stmtApt = conn.prepareStatement("SELECT COUNT(*) AS total FROM aptidao");
ResultSet rsApt = stmtApt.executeQuery();
rsApt.next();
int totalAptidoes = rsApt.getInt("total");

// Buscar últimas turmas
PreparedStatement stmtUltimas = conn.prepareStatement(
    "SELECT t.codigo_turma, t.semestre, t.numero_alunos, t.horario, " +
    "p.nome AS professor, d.nome_disciplina AS disciplina " +
    "FROM turma t " +
    "INNER JOIN professor p ON t.matricula_professor = p.matricula " +
    "INNER JOIN disciplina d ON t.codigo_disciplina = d.codigo_disciplina " +
    "ORDER BY t.codigo_turma DESC LIMIT 5"
);
ResultSet rsUltimas = stmtUltimas.executeQuery();

// Buscar professores com mais turmas
PreparedStatement stmtDestaque = conn.prepareStatement(
    "SELECT p.nome, COUNT(t.codigo_turma) AS total_turmas " +
    "FROM professor p " +
    "LEFT JOIN turma t ON p.matricula = t.matricula_professor " +
    "GROUP BY p.matricula " +
    "ORDER BY total_turmas DESC LIMIT 3"
);
ResultSet rsDestaque = stmtDestaque.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sistema Academico</title>
<link rel="stylesheet" href="css/style.css">
<style>
    .cards {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
        margin-bottom: 30px;
    }
    .card-stat {
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        text-align: center;
    }
    .card-stat h3 {
        color: #1F3A5F;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 10px;
    }
    .card-stat .numero {
        font-size: 32px;
        font-weight: bold;
        color: #2C5282;
    }
    .mural-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }
    .mural-card {
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }
    .mural-card h3 {
        color: #1F3A5F;
        margin-bottom: 15px;
        border-bottom: 2px solid #E2E8F0;
        padding-bottom: 10px;
    }
    .mural-card table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
    }
    .mural-card table td {
        padding: 8px 0;
        border-bottom: 1px solid #f0f0f0;
    }
    .mural-card table tr:last-child td {
        border-bottom: none;
    }
    .badge {
        background: #1F3A5F;
        color: white;
        padding: 2px 10px;
        border-radius: 20px;
        font-size: 12px;
    }
    .destaque-nome {
        font-weight: 600;
        color: #1F3A5F;
    }
</style>
</head>
<body>
<div class="sidebar">
    <div class="logo">Universidade Web</div>
    <ul class="menu">
        <li><a href="index.jsp" class="active">Inicio</a></li>
        <li><a href="professor/listar.jsp">Professores</a></li>
        <li><a href="disciplina/listar.jsp">Disciplinas</a></li>
        <li><a href="aptidao/listar.jsp">Aptidoes</a></li>
        <li><a href="turma/listar.jsp">Turmas</a></li>
        <li><a href="consulta/professoresDisciplina.jsp">Consultas</a></li>
    </ul>
</div>
<div class="main">
    <div class="header">
        <h3>Inicio</h3>
    </div>
    <div class="content">
        <!-- Cards de resumo -->
        <div class="cards">
            <div class="card-stat">
                <h3>Professores</h3>
                <div class="numero"><%= totalProfessores %></div>
            </div>
            <div class="card-stat">
                <h3>Disciplinas</h3>
                <div class="numero"><%= totalDisciplinas %></div>
            </div>
            <div class="card-stat">
                <h3>Turmas</h3>
                <div class="numero"><%= totalTurmas %></div>
            </div>
            <div class="card-stat">
                <h3>Aptidoes</h3>
                <div class="numero"><%= totalAptidoes %></div>
            </div>
        </div>

        <!-- Mural -->
        <div class="mural-grid">
            <!-- Ultimas turmas -->
            <div class="mural-card">
                <h3>Ultimas Turmas Cadastradas</h3>
                <table>
                    <% while(rsUltimas.next()){ %>
                    <tr>
                        <td><strong><%= rsUltimas.getString("codigo_turma") %></strong></td>
                        <td><%= rsUltimas.getString("disciplina") %></td>
                        <td><span class="badge"><%= rsUltimas.getString("semestre") %></span></td>
                    </tr>
                    <% } %>
                </table>
            </div>

            <!-- Professores em destaque -->
            <div class="mural-card">
                <h3>Professores em Destaque</h3>
                <table>
                    <% while(rsDestaque.next()){ %>
                    <tr>
                        <td><span class="destaque-nome"><%= rsDestaque.getString("nome") %></span></td>
                        <td><span class="badge"><%= rsDestaque.getInt("total_turmas") %> turmas</span></td>
                    </tr>
                    <% } %>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<%
rsUltimas.close();
rsDestaque.close();
rsProf.close();
rsDisc.close();
rsTurma.close();
rsApt.close();
stmtUltimas.close();
stmtDestaque.close();
stmtProf.close();
stmtDisc.close();
stmtTurma.close();
stmtApt.close();
conn.close();
%>