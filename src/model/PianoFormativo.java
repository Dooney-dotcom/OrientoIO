package model;

import java.util.ArrayList;
import java.util.List;

public class PianoFormativo {

	private List<Esame> esami; 
	private CorsoDiLaurea corso;
	
	private String annoImmatricolazione;

	
	public PianoFormativo() {
		this.esami = new ArrayList<Esame>();
	}
	
	
	//getters and setters
	public List<Esame> getEsami() {
		return esami;
	}
	public void setEsami(List<Esame> esami) {
		this.esami = esami;
	}
	public CorsoDiLaurea getCorso(){
		return this.corso;
	}
	public void setCorso(CorsoDiLaurea corso){
		this.corso=corso;
	}
	
	
	public String getAnnoImmatricolazione() {
		return annoImmatricolazione;
	}
	public void setAnnoImmatricolazione(String annoImmatricolazione) {
		this.annoImmatricolazione = annoImmatricolazione;
	}
	
	
	
	//metodi
	public void aggiungiEsame(Esame esame) {
		this.esami.add(esame);
	}


	@Override
	public String toString() {
		return "PianoFormativo [esami=" + esami + ", corso=" + corso.getNome() + ", annoImmatricolazione=" + annoImmatricolazione
				+ "]";
	}

	
	
	
}
