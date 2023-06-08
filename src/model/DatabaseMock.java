package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DatabaseMock {
	private Map<String, String> accounts;
	private Map<String, Utente> utenti;
	private Map<String, StudenteUniversitario> studenti;
	private Map<String, CittaUniversitaria> citta;
	private Map<String, Universita> universita;
	private List<CorsoDiLaurea> corsi;
	
	public DatabaseMock() {
		this.accounts = new HashMap<>();
		this.utenti = new HashMap<>();
		this.studenti = new HashMap<>();
		this.citta = new HashMap<>();
		this.universita = new HashMap<>();
		this.corsi = new ArrayList<>();
		
		CittaUniversitaria c = new CittaUniversitaria();
		c.setNomeCitta("Bologna");
		citta.put(c.getNomeCitta(), c);
		
		CittaUniversitaria c2 = new CittaUniversitaria();
		c2.setNomeCitta("Milano");
		citta.put(c2.getNomeCitta(), c2);
		
		Universita u = new Universita();
		u.setCitta(c);
		u.setNome("Università degli studi di Bologna");
		universita.put(u.getNome(), u);
		
		Universita u2 = new Universita();
		u2.setCitta(c);
		u2.setNome("Politecnico di Milano");
		universita.put(u2.getNome(), u2);
		
		CorsoDiLaurea cdl = new CorsoDiLaurea();
		cdl.setNome("Ingegneria Informatica T");
		cdl.setTipo(TipoCorso.TRIENNALE);
		cdl.setAccesso("TOLC-I");
		cdl.setClasseDiCorso("ING-INF");
		cdl.setCoordinatore("Enrico Denti");
		cdl.setDipartimento("DISI");
		cdl.setLinkCorso("");
		cdl.setLingua("Italiano");
		cdl.setUniversita(u);
		
		corsi.add(cdl);
		u.getCorsiDiLaurea().add(cdl);
		
		CorsoDiLaurea cdl2 = new CorsoDiLaurea();
		cdl2.setNome("Giurisprudenza");
		cdl2.setTipo(TipoCorso.MAGISTRALE_A_CICLO_UNICO);
		cdl2.setAccesso("TOLC-I");
		cdl2.setClasseDiCorso("ING-INF");
		cdl2.setCoordinatore("Enrico Denti");
		cdl2.setDipartimento("DISI");
		cdl2.setLinkCorso("");
		cdl2.setLingua("Italiano");
		cdl2.setUniversita(u);
		
		corsi.add(cdl2);
		u.getCorsiDiLaurea().add(cdl2);
		
		PianoFormativo pianoFormativo = new PianoFormativo();
		pianoFormativo.setCorso(cdl);
		pianoFormativo.setAnnoImmatricolazione("2020/2021");
		cdl.getPianiFormativi().add(pianoFormativo);
		
		Esame esame = new Esame();
		esame.setNome("Analisi 1 T");
		esame.setAnno(1);
		esame.setCFU(9);
		esame.setLinkEsame("");
		esame.setPeriodo(1);
		esame.setSSO("");
		
		Esame e2 = new Esame();
		e2.setNome("Fondamenti di Informatica T-1");
		e2.setCFU(12);
		
		Esame e3 = new Esame();
		e3.setNome("Ingegneria del Software T");
		e3.setCFU(9);
		
		Esame e4 = new Esame();
		e4.setNome("Reti Logiche");
		e4.setCFU(6);
		
		pianoFormativo.getEsami().add(esame);
		pianoFormativo.getEsami().add(e2);
		pianoFormativo.getEsami().add(e3);
		pianoFormativo.getEsami().add(e4);
		
		Libretto l = new Libretto();
		l.setCFU(0);
		l.setBaseDiLaurea(0.0);
		l.setMedia(0.0);
		
		StudenteUniversitario studente = new StudenteUniversitario();
		studente.setUsername("mandarino87");
		studente.setNome("Mario");
		studente.setCognome("Rossi");
		studente.setPianoFormativo(pianoFormativo);
		studente.setCitta(c);
		studente.setLibretto(l);
		
		studente.getListaPreferiti().getCorsiDiLaurea().add(cdl);
		
		studenti.put(studente.getUsername(), studente);
		accounts.put(studente.getUsername(), "password");

	}

	public Map<String, String> getAccounts() {
		return accounts;
	}

	public void setAccounts(Map<String, String> accounts) {
		this.accounts = accounts;
	}

	public Map<String, Utente> getUtenti() {
		return utenti;
	}

	public void setUtenti(Map<String, Utente> utenti) {
		this.utenti = utenti;
	}

	public Map<String, StudenteUniversitario> getStudenti() {
		return studenti;
	}

	public void setStudenti(Map<String, StudenteUniversitario> studenti) {
		this.studenti = studenti;
	}

	public Map<String, CittaUniversitaria> getCitta() {
		return citta;
	}

	public void setCitta(Map<String, CittaUniversitaria> citta) {
		this.citta = citta;
	}

	public Map<String, Universita> getUniversita() {
		return universita;
	}

	public void setUniversita(Map<String, Universita> universita) {
		this.universita = universita;
	}

	public List<CorsoDiLaurea> getCorsi() {
		return corsi;
	}

	public void setCorsi(List<CorsoDiLaurea> corsi) {
		this.corsi = corsi;
	}
	
	
}
