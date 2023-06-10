package util;


public class RecensioneCorsoResult {

	private String message;
	
	private String testoRecensione;
	private Integer qualitaInsegnamento;
	private String sbocchiLavorativi;
	private String opportunitaOfferte;
	
	
	
	public String getMessage() {
		return message;
	}



	public void setMessage(String message) {
		this.message = message;
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


	public RecensioneCorsoResult() {
		this.message=" ";
		this.opportunitaOfferte = " ";
		this.qualitaInsegnamento= 0;
		this.sbocchiLavorativi = " ";
		this.testoRecensione = " ";
	}
}
