package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Disciplina;
import util.Conexao;

public class DisciplinaDAO {

    public void inserir(Disciplina d) {

        String sql =
        "INSERT INTO disciplina(codigo_disciplina,nome_disciplina,carga_horaria) VALUES(?,?,?)";

        try {

            Connection conn = Conexao.conectar();

            PreparedStatement stmt =
                    conn.prepareStatement(sql);

            stmt.setInt(1, d.getCodigoDisciplina());
            stmt.setString(2, d.getNomeDisciplina());
            stmt.setInt(3, d.getCargaHoraria());

            stmt.executeUpdate();

            stmt.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public List<Disciplina> listar() {

        List<Disciplina> lista = new ArrayList<>();

        String sql = "SELECT * FROM disciplina";

        try {

            Connection conn = Conexao.conectar();

            PreparedStatement stmt =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    stmt.executeQuery();

            while(rs.next()) {

                Disciplina d = new Disciplina();

                d.setCodigoDisciplina(
                        rs.getInt("codigo_disciplina"));

                d.setNomeDisciplina(
                        rs.getString("nome_disciplina"));

                d.setCargaHoraria(
                        rs.getInt("carga_horaria"));

                lista.add(d);
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    public Disciplina buscarPorCodigo(int codigo) {

        Disciplina d = null;

        String sql =
                "SELECT * FROM disciplina WHERE codigo_disciplina=?";

        try {

            Connection conn = Conexao.conectar();

            PreparedStatement stmt =
                    conn.prepareStatement(sql);

            stmt.setInt(1, codigo);

            ResultSet rs =
                    stmt.executeQuery();

            if(rs.next()) {

                d = new Disciplina();

                d.setCodigoDisciplina(
                        rs.getInt("codigo_disciplina"));

                d.setNomeDisciplina(
                        rs.getString("nome_disciplina"));

                d.setCargaHoraria(
                        rs.getInt("carga_horaria"));
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }

        return d;
    }

    public void atualizar(Disciplina d) {

        String sql =
        "UPDATE disciplina SET nome_disciplina=?, carga_horaria=? WHERE codigo_disciplina=?";

        try {

            Connection conn = Conexao.conectar();

            PreparedStatement stmt =
                    conn.prepareStatement(sql);

            stmt.setString(1, d.getNomeDisciplina());
            stmt.setInt(2, d.getCargaHoraria());
            stmt.setInt(3, d.getCodigoDisciplina());

            stmt.executeUpdate();

            stmt.close();
            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void excluir(int codigo) {

        String sql =
                "DELETE FROM disciplina WHERE codigo_disciplina=?";

        try {

            Connection conn = Conexao.conectar();

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