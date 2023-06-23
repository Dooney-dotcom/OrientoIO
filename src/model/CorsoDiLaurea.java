package model;

import java.util.ArrayList;
import java.util.List;

public class CorsoDiLaurea {

	private List<PianoFormativo> pianiFormativi;
	private Universita universita;
	private TipoCorso tipo;
	private List<RecensioneCorso> recensioni;
	
	private String nome;
	private String coordinatore;
	private String dipartimento;
	private String lingua;
	private String accesso;
	private String linkCorso;
	private String classeDiCorso;
	
	

	public CorsoDiLaurea() {
		this.pianiFormativi = new ArrayList<>();
		this.recensioni = new ArrayList<>();
	}


	
	//getters e setters
	public List<PianoFormativo> getPianiFormativi() {
		return pianiFormativi;
	}
	public void setPianiFormativi(List<PianoFormativo> pianiFormativi) {
		this.pianiFormativi = pianiFormativi;
	}
	public Universita getUniversita(){
		return this.universita;
	}
	public void setUniversita(Universita universita){
		this.universita=universita;
	}
	public TipoCorso getTipo() {
		return this.tipo;
	}
	public void setTipo(TipoCorso tipo) {
		this.tipo=tipo;
	}
	
	

	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCoordinatore() {
		return coordinatore;
	}
	public void setCoordinatore(String coordinatore) {
		this.coordinatore = coordinatore;
	}
	public String getDipartimento() {
		return dipartimento;
	}
	public void setDipartimento(String dipartimento) {
		this.dipartimento = dipartimento;
	}
	public String getLingua() {
		return lingua;
	}
	public void setLingua(String lingua) {
		this.lingua = lingua;
	}
	public String getAccesso() {
		return accesso;
	}
	public void setAccesso(String accesso) {
		this.accesso = accesso;
	}
	public String getLinkCorso() {
		return linkCorso;
	}
	public void setLinkCorso(String linkCorso) {
		this.linkCorso = linkCorso;
	}
	public String getClasseDiCorso() {
		return this.classeDiCorso;
	}
	public void setClasseDiCorso(String classeDiCorso) {
		this.classeDiCorso=classeDiCorso;
	}
	
	
	//metodi
	public void aggiungiPianoFormativo(PianoFormativo pianoFormativo) {
		this.pianiFormativi.add(pianoFormativo);
	}



	public List<RecensioneCorso> getRecensioni() {
		return recensioni;
	}



	public void setRecensioni(List<RecensioneCorso> recensioni) {
		this.recensioni = recensioni;
	}



	@Override
	public String toString() {
		return "CorsoDiLaurea [pianiFormativi=" + pianiFormativi + ", universita=" + universita.getNome() + ", tipo=" + tipo
				+ ", recensioni=" + recensioni + ", nome=" + nome + ", coordinatore=" + coordinatore + ", dipartimento="
				+ dipartimento + ", lingua=" + lingua + ", accesso=" + accesso + ", linkCorso=" + linkCorso
				+ ", classeDiCorso=" + classeDiCorso + "]";
	}
	
	
}
