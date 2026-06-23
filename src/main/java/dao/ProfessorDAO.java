package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Professor;
import util.Conexao;

public class ProfessorDAO {

    public void inserir(Professor professor) {
        String sql = "INSERT INTO professor(matricula, nome, email, telefone) VALUES(?,?,?,?)";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, professor.getMatricula());
            stmt.setString(2, professor.getNome());
            stmt.setString(3, professor.getEmail());
            stmt.setString(4, professor.getTelefone());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Professor> listar() {
        List<Professor> lista = new ArrayList<>();
        String sql = "SELECT * FROM professor ORDER BY nome";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Professor p = new Professor();
                p.setMatricula(rs.getInt("matricula"));
                p.setNome(rs.getString("nome"));
                p.setEmail(rs.getString("email"));
                p.setTelefone(rs.getString("telefone"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Professor buscarPorMatricula(int matricula) {
        Professor p = null;
        String sql = "SELECT * FROM professor WHERE matricula = ?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, matricula);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                p = new Professor();
                p.setMatricula(rs.getInt("matricula"));
                p.setNome(rs.getString("nome"));
                p.setEmail(rs.getString("email"));
                p.setTelefone(rs.getString("telefone"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    public void atualizar(Professor professor) {
        String sql = "UPDATE professor SET nome=?, email=?, telefone=? WHERE matricula=?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, professor.getNome());
            stmt.setString(2, professor.getEmail());
            stmt.setString(3, professor.getTelefone());
            stmt.setInt(4, professor.getMatricula());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluir(int matricula) {
        // 1. Excluir aptidões
        String sqlAptidao = "DELETE FROM aptidao WHERE matricula_professor = ?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sqlAptidao)) {
            stmt.setInt(1, matricula);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 2. Excluir turmas do professor
        String sqlTurma = "DELETE FROM turma WHERE matricula_professor = ?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sqlTurma)) {
            stmt.setInt(1, matricula);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 3. Excluir relacionamentos (professor_disciplina)
        String sqlRelacionamento = "DELETE FROM professor_disciplina WHERE matricula_professor = ?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sqlRelacionamento)) {
            stmt.setInt(1, matricula);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 4. Finalmente, excluir o professor
        String sqlProfessor = "DELETE FROM professor WHERE matricula = ?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sqlProfessor)) {
            stmt.setInt(1, matricula);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}