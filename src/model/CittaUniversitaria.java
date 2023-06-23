package model;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class CittaUniversitaria{

    private String nomeCitta;
    private File fotoCitta;
    private List<StudenteUniversitario> studenti;
    

    //Costruttore
    public CittaUniversitaria(){
        this.studenti=new ArrayList<StudenteUniversitario>();
    }

    //Getters and Setters
    public void setNomeCitta(String nomeCitta){
        this.nomeCitta=nomeCitta;
    }

    public String getNomeCitta(){
        return this.nomeCitta;
    }

    public void setFotoCitta(File foto){
        this.fotoCitta=foto;
    }

    public File getFotoCitta(){
        return this.fotoCitta;
    }

    public void setStudenti(List<StudenteUniversitario> studenti){
        this.studenti=studenti;
    }

    public List<StudenteUniversitario> getStudenti(){
        return this.studenti;
    }

    public boolean addStudente(StudenteUniversitario studente){
        return this.studenti.add(studente);
    }

	@Override
	public String toString() {
		return "CittaUniversitaria [nomeCitta=" + nomeCitta + ", fotoCitta=" + fotoCitta + ", studenti=" + studenti
				+ "]";
	}
    
    
}