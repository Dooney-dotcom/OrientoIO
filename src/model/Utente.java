package model;

import java.io.Serializable;
import java.time.LocalDate;

public class Utente implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ListaPreferiti listaPreferiti;
	
	private String nome;
	private String cognome;
	private LocalDate dataDiNascita;
	private String username;

	public Utente() {
		this.listaPreferiti = new ListaPreferiti();
	}

	public ListaPreferiti getListaPreferiti() {
		return this.listaPreferiti;
	}

	public void setListaPreferiti(ListaPreferiti listaPreferiti) {
		this.listaPreferiti = listaPreferiti;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public LocalDate getDataDiNascita() {
		return dataDiNascita;
	}

	public void setDataDiNascita(LocalDate dataDiNascita) {
		this.dataDiNascita = dataDiNascita;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String toString() {
		return "Utente [nome=" + nome + ", cognome=" + cognome + ", dataDiNascita=" + dataDiNascita + ", username="
				+ username + "]";
	}

}