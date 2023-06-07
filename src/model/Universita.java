package model;

import java.util.ArrayList;
import java.util.List;

public class Universita {
	
	private List<CorsoDiLaurea> corsiDiLaurea;
	private CittaUniversitaria citta;

	private String nome;
	private String linkBorsaDiStudio;
	private String linkUniversita;
	
	
	public Universita() {
		this.corsiDiLaurea = new ArrayList<CorsoDiLaurea>();
	}


	//getters and setters
	public List<CorsoDiLaurea> getCorsiDiLaurea() {
		return corsiDiLaurea;
	}
	public void setCorsiDiLaurea(List<CorsoDiLaurea> corsiDiLaurea) {
		this.corsiDiLaurea = corsiDiLaurea;
	}



	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public CittaUniversitaria getCitta() {
		return citta;
	}
	public void setCitta(CittaUniversitaria citta) {
		this.citta = citta;
	}
	public String getLinkBorsaDiStudio() {
		return linkBorsaDiStudio;
	}
	public void setLinkBorsaDiStudio(String linkBorsaDiStudio) {
		this.linkBorsaDiStudio = linkBorsaDiStudio;
	}
	public String getLinkUniversita() {
		return linkUniversita;
	}
	public void setLinkUniversita(String linkUniversita) {
		this.linkUniversita = linkUniversita;
	}


	//metodi
	public void aggiungiCorsoDiLaurea(CorsoDiLaurea corsoDiLaurea) {
		this.corsiDiLaurea.add(corsoDiLaurea);
	}



	
	
	
	
}
