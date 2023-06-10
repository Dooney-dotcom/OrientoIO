package model;

import java.time.Duration;

public class RecensioneEsame {

	private StudenteUniversitario studente;
	private Esame esame;
	
	private String testoRecensione;
	private Integer voto;
	private Boolean lode;
	private Duration tempoDiStudio;
	private Integer valutazioneProfessore;
	
	
	public RecensioneEsame() {
		
	}
	
	
	//getters and setters
	public StudenteUniversitario getStudente() {
		return studente;
	}
	public void setStudente(StudenteUniversitario studente) {
		this.studente = studente;
	}
	public Esame getEsame() {
		return esame;
	}
	public void setEsame(Esame esame) {
		this.esame = esame;
	}
	
	
	
	public String getTestoRecensione() {
		return testoRecensione;
	}
	public void setTestoRecensione(String testoRecensione) {
		this.testoRecensione = testoRecensione;
	}
	public Integer getVoto() {
		return voto;
	}
	public void setVoto(Integer voto) {
		this.voto = voto;
	}
	public Boolean getLode() {
		return lode;
	}
	public void setLode(Boolean lode) {
		this.lode = lode;
	}
	public Duration getTempoDiStudio() {
		return tempoDiStudio;
	}
	public void setTempoDiStudio(Duration tempoDiStudio) {
		this.tempoDiStudio = tempoDiStudio;
	}
	public Integer getValutazioneProfessore() {
		return this.valutazioneProfessore;
	}
	public void setValutazioneProfessore(Integer valutazioneProfessore) {
		this.valutazioneProfessore = valutazioneProfessore;
	}


	@Override
	public String toString() {
		return "RecensioneEsame [studente=" + studente.getUsername() + ", esame=" + esame.getNome() + "]";
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((studente == null) ? 0 : studente.hashCode());
		result = prime * result + ((esame == null) ? 0 : esame.hashCode());
		return result;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RecensioneEsame other = (RecensioneEsame) obj;
		if (studente == null) {
			if (other.studente != null)
				return false;
		} else if (!studente.equals(other.studente))
			return false;
		if (esame == null) {
			if (other.esame != null)
				return false;
		} else if (!esame.equals(other.esame))
			return false;
		return true;
	}
	
	
}
