package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Turma;
import util.Conexao;

public class TurmaDAO {

    public void inserir(Turma t) {

        String sql =
        "INSERT INTO turma(codigo_turma,semestre,numero_alunos,horario,matricula_professor,codigo_disciplina) VALUES(?,?,?,?,?,?)";

        try {

            Connection conn =
                    Conexao.conectar();

            PreparedStatement stmt =
                    conn.prepareStatement(sql);

            stmt.setInt(1, t.getCodigoTurma());
            stmt.setString(2, t.getSemestre());
            stmt.setInt(3, t.getNumeroAlunos());
            stmt.setString(4, t.getHorario());
            stmt.setInt(5, t.getMatriculaProfessor());
            stmt.setInt(6, t.getCodigoDisciplina());

            stmt.executeUpdate();

            stmt.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public List<Turma> listar() {

        List<Turma> lista =
                new ArrayList<>();

        String sql =
                "SELECT * FROM turma";

        try {

            Connection conn =
                    Conexao.conectar();

            PreparedStatement stmt =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    stmt.executeQuery();

            while(rs.next()) {

                Turma t = new Turma();

                t.setCodigoTurma(
                        rs.getInt("codigo_turma"));

                t.setSemestre(
                        rs.getString("semestre"));

                t.setNumeroAlunos(
                        rs.getInt("numero_alunos"));

                t.setHorario(
                        rs.getString("horario"));

                t.setMatriculaProfessor(
                        rs.getInt("matricula_professor"));

                t.setCodigoDisciplina(
                        rs.getInt("codigo_disciplina"));

                lista.add(t);
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public ResultSet listarCompleto() {
        try {
            Connection conn = Conexao.conectar();
            String sql =
                "SELECT t.codigo_turma, " +
                "t.semestre, " +
                "t.numero_alunos, " +
                "t.horario, " +
                "p.nome AS professor, " +
                "d.nome_disciplina AS disciplina " +
                "FROM turma t " +
                "INNER JOIN professor p ON t.matricula_professor = p.matricula " +
                "INNER JOIN disciplina d ON t.codigo_disciplina = d.codigo_disciplina " +
                "ORDER BY t.codigo_turma ASC";  // ← ORDEM CRESCENTE
            PreparedStatement stmt = conn.prepareStatement(sql);
            return stmt.executeQuery();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Turma buscarPorCodigo(int codigo) {

        Turma t = null;

        String sql =
        "SELECT * FROM turma WHERE codigo_turma=?";

        try {

            Connection conn =
                    Conexao.conectar();

            PreparedStatement stmt =
                    conn.prepareStatement(sql);

            stmt.setInt(1, codigo);

            ResultSet rs =
                    stmt.executeQuery();

            if(rs.next()) {

                t = new Turma();

                t.setCodigoTurma(
                        rs.getInt("codigo_turma"));

                t.setSemestre(
                        rs.getString("semestre"));

                t.setNumeroAlunos(
                        rs.getInt("numero_alunos"));

                t.setHorario(
                        rs.getString("horario"));

                t.setMatriculaProfessor(
                        rs.getInt("matricula_professor"));

                t.setCodigoDisciplina(
                        rs.getInt("codigo_disciplina"));
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }

        return t;
    }

    public void atualizar(Turma t) {

        String sql =
        "UPDATE turma SET semestre=?, numero_alunos=?, horario=?, matricula_professor=?, codigo_disciplina=? WHERE codigo_turma=?";

        try {

            Connection conn =
                    Conexao.conectar();

            PreparedStatement stmt =
                    conn.prepareStatement(sql);

            stmt.setString(1, t.getSemestre());
            stmt.setInt(2, t.getNumeroAlunos());
            stmt.setString(3, t.getHorario());
            stmt.setInt(4, t.getMatriculaProfessor());
            stmt.setInt(5, t.getCodigoDisciplina());
            stmt.setInt(6, t.getCodigoTurma());

            stmt.executeUpdate();

            stmt.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void excluir(int codigo) {

        String sql =
        "DELETE FROM turma WHERE codigo_turma=?";

        try {

            Connection conn =
                    Conexao.conectar();

            PreparedStatement stmt =
                    conn.prepareStatement(sql);

            stmt.setInt(1, codigo);

            stmt.executeUpdate();

            stmt.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}