package model;

import java.util.ArrayList;
import java.util.List;

public class ListaPreferiti {

	private Utente utente;
	private List<CorsoDiLaurea> corsiPreferiti;

	
	public ListaPreferiti() {
		this.corsiPreferiti = new ArrayList<CorsoDiLaurea>();
	}
	
	
	//getters and setters
	public Utente getUtente(){
		return this.utente;
	}
	public void setUtente(Utente utente){
		this.utente = utente;
	}
	public List<CorsoDiLaurea> getCorsiDiLaurea() {
		return corsiPreferiti;
	}
	public void setCorsiDiLaurea(List<CorsoDiLaurea> corsiPreferiti) {
		this.corsiPreferiti = corsiPreferiti;
	}
	
	//metodi
    public void aggiungiCorso(CorsoDiLaurea corso){
		this.corsiPreferiti.add(corso);
	}
	public void rimuoviCorso(CorsoDiLaurea corso){
		this.corsiPreferiti.remove(corso);
	}

	
	
	
}
