package util;

import java.util.ArrayList;
import java.util.List;

public class UniversitaResult {
    private String nome;
    private List<CorsoResult> corsi;

    public UniversitaResult() {
        this.corsi = new ArrayList<>();
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public List<CorsoResult> getCorsi() {
        return corsi;
    }

    public void setCorsi(List<CorsoResult> corsi) {
        this.corsi = corsi;
    }

    
}