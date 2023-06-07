package model;

public class RecensioneCorso {
	
	private StudenteUniversitario studente;

	
	private String testoRecensione;
	private Integer qualitaInsegnamento;
	private String sbocchiLavorativi;
	private String opportunitaOfferte;
	
	
	public RecensioneCorso() {
		
	}


	//getters and setters
	public StudenteUniversitario getStudente() {
		return studente;
	}
	public void setStudente(StudenteUniversitario studente) {
		this.studente = studente;
	}
	
	
	
	public String getTestoRecensione() {
		return testoRecensione;
	}
	public void setTestoRecensione(String testoRecensione) {
		this.testoRecensione = testoRecensione;
	}
	public Integer getQualitaInsegnamento() {
		return qualitaInsegnamento;
	}
	public void setQualitaInsegnamento(Integer qualitaInsegnamento) {
		this.qualitaInsegnamento = qualitaInsegnamento;
	}
	public String getSbocchiLavorativi() {
		return sbocchiLavorativi;
	}
	public void setSbocchiLavorativi(String sbocchiLavorativi) {
		this.sbocchiLavorativi = sbocchiLavorativi;
	}
	public String getOpportunitaOfferte() {
		return opportunitaOfferte;
	}
	public void setOpportunitaOfferte(String opportunitaOfferte) {
		this.opportunitaOfferte = opportunitaOfferte;
	}
	
}
