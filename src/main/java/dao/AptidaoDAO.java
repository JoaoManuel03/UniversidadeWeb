package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Aptidao;
import util.Conexao;

public class AptidaoDAO {

    public void inserir(Aptidao a) {
        String sql = "INSERT INTO aptidao (matricula_professor, descricao) VALUES (?, ?)";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, a.getMatriculaProfessor());
            stmt.setString(2, a.getDescricao());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =============================================
    // MÉTODO PARA INSERIR DIRETO (usado pelo ProfessorServlet)
    // =============================================
    public void inserir(int matriculaProfessor, String descricao) {
        String sql = "INSERT INTO aptidao (matricula_professor, descricao) VALUES (?, ?)";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, matriculaProfessor);
            stmt.setString(2, descricao);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Aptidao> listar() {
        List<Aptidao> lista = new ArrayList<>();
        String sql = "SELECT * FROM aptidao";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Aptidao a = new Aptidao();
                a.setId(rs.getInt("id"));
                a.setMatriculaProfessor(rs.getInt("matricula_professor"));
                a.setDescricao(rs.getString("descricao"));
                lista.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<String> buscarDescricoesPorProfessor(int matriculaProfessor) {
        List<String> descricoes = new ArrayList<>();
        String sql = "SELECT descricao FROM aptidao WHERE matricula_professor = ?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, matriculaProfessor);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                descricoes.add(rs.getString("descricao"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return descricoes;
    }

    public void removerPorProfessor(int matriculaProfessor) {
        String sql = "DELETE FROM aptidao WHERE matricula_professor = ?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, matriculaProfessor);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean existeAptidao(int matriculaProfessor, String descricao) {
        String sql = "SELECT COUNT(*) FROM aptidao WHERE matricula_professor = ? AND descricao = ?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, matriculaProfessor);
            stmt.setString(2, descricao);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void excluir(int id) {
        String sql = "DELETE FROM aptidao WHERE id = ?";
        try (Connection conn = Conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}