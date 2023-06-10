package model;


import java.io.File;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.chrono.ChronoPeriod;
import java.time.chrono.Chronology;
import java.time.temporal.Temporal;
import java.time.temporal.TemporalField;
import java.time.temporal.TemporalUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DatabaseMock {
	private Map<String, Account> accounts; //tutti gli account del sito (amministratori, utenti, studenti)
	private Map<String, Utente> utenti; //tutti gli account degli utenti (utenti, studenti)
	private Map<String, StudenteUniversitario> studenti; //tutti gli account degli studenti
	private Map<String, CittaUniversitaria> citta;
	private Map<String, Universita> universita;
	
	//Federico
	private List<CorsoDiLaurea> corsi;
	private List<RecensioneCorso> recensioniCorso;
	private List<SegnalazioneRecensioneCorso> segnalazioniCorso;
	private List<RecensioneEsame> recensioniEsami;
	private List<SegnalazioneRecensioneEsame> segnalazioniEsami;
	//
	
	public DatabaseMock() {
		this.accounts = new HashMap<>();
		this.utenti = new HashMap<>();
		this.studenti = new HashMap<>();
		this.citta = new HashMap<>();
		this.universita = new HashMap<>();
		
		//Federico
		this.corsi = new ArrayList<>();
		this.recensioniCorso = new ArrayList<>();
		this.segnalazioniCorso = new ArrayList<>();
		this.recensioniEsami = new ArrayList<>();
		this.segnalazioniEsami = new ArrayList<>();
		//
		
		
		//creazione citta
		CittaUniversitaria c = new CittaUniversitaria();
		c.setNomeCitta("Bologna");
		c.setFotoCitta(new File("../web/resources/bologna.jpg"));
		
		CittaUniversitaria c2 = new CittaUniversitaria();
		c2.setNomeCitta("Milano");
		c.setFotoCitta(new File("../web/resources/milano.jpg"));
		
		CittaUniversitaria c3 = new CittaUniversitaria();
		c3.setNomeCitta("Roma");
		c.setFotoCitta(new File("../web/resources/roma.jpg"));
		
		//creazione universita
		Universita u = new Universita();
		u.setCitta(c);
		u.setNome("HalmaMatter");
		
		
		Universita u2 = new Universita();
		u2.setCitta(c2);
		u2.setNome("Politecnico di Milano");
		
		
		//creazione corsi di laurea
		CorsoDiLaurea cdl = new CorsoDiLaurea();
		cdl.setNome("Ingegneria informatica T");
		cdl.setTipo(TipoCorso.TRIENNALE);
		cdl.setAccesso("TOLC-I");
		cdl.setClasseDiCorso("ING-INF");
		cdl.setCoordinatore("Enrico Denti");
		cdl.setDipartimento("DISI");
		cdl.setLinkCorso("https://corsi.unibo.it/laurea/IngegneriaInformatica");
		cdl.setLingua("Italiano");
		
		cdl.setUniversita(u);
		u.aggiungiCorsoDiLaurea(cdl);
		
		CorsoDiLaurea cdl2 = new CorsoDiLaurea();
		cdl2.setNome("Ingengeria aereospaziale");
		cdl2.setTipo(TipoCorso.TRIENNALE);
		cdl2.setAccesso("TOLC-I");
		cdl2.setClasseDiCorso("L-9-INGEGNERIA INDUSTRIALE");
		cdl2.setCoordinatore("Fabrizio Giulietti");
		cdl2.setDipartimento("DIN");
		cdl2.setLinkCorso("https://corsi.unibo.it/laurea/IngegneriaAerospaziale");
		cdl2.setLingua("Italiano");
		
		cdl2.setUniversita(u);
		u.aggiungiCorsoDiLaurea(cdl2);
		
		CorsoDiLaurea cdl3 = new CorsoDiLaurea();
		cdl3.setNome("Fisica");
		cdl3.setTipo(TipoCorso.TRIENNALE);
		cdl3.setAccesso("Accesso Libero con test di autovalutazione obbligatorio prima dell'immatricolazione");
		cdl3.setClasseDiCorso(" ");
		cdl3.setCoordinatore("Guglielmetti Alessandra Ada Cecilia");
		cdl3.setDipartimento(" ");
		cdl3.setLinkCorso("https://www.unimi.it/it/corsi/laurea-triennale/fisica");
		cdl3.setLingua("Italiano");
		
		cdl3.setUniversita(u2);
		u2.aggiungiCorsoDiLaurea(cdl3);
		
		
		CorsoDiLaurea cdl4 = new CorsoDiLaurea();
		cdl4.setNome("Ingegneria informatica T");
		cdl4.setTipo(TipoCorso.TRIENNALE);
		cdl4.setAccesso("TOLC-I");
		cdl4.setClasseDiCorso("ING-INF");
		cdl4.setCoordinatore("Gemitaiz");
		cdl4.setDipartimento("DISI");
		cdl4.setLinkCorso("linkCorso");
		cdl4.setLingua("Romano");
		
		cdl4.setUniversita(u2);
		u2.aggiungiCorsoDiLaurea(cdl4);
		
		//creazione piani formativi
		PianoFormativo pianoFormativo = new PianoFormativo();
		pianoFormativo.setCorso(cdl);
		pianoFormativo.setAnnoImmatricolazione("2020/2021");
		
		cdl.aggiungiPianoFormativo(pianoFormativo);
		
		PianoFormativo pianoFormativo2 = new PianoFormativo();
		pianoFormativo2.setCorso(cdl);
		pianoFormativo2.setAnnoImmatricolazione("2021/2022");
		
		cdl.aggiungiPianoFormativo(pianoFormativo2);

		PianoFormativo pianoFormativo3 = new PianoFormativo();
		pianoFormativo3.setCorso(cdl2);
		pianoFormativo3.setAnnoImmatricolazione("2021/2022");
		
		cdl2.aggiungiPianoFormativo(pianoFormativo3);
		
		PianoFormativo pianoFormativo4 = new PianoFormativo();
		pianoFormativo4.setCorso(cdl3);
		pianoFormativo4.setAnnoImmatricolazione("2021/2022");
		
		cdl3.aggiungiPianoFormativo(pianoFormativo4);
		
		
		PianoFormativo pianoFormativo5 = new PianoFormativo();
		pianoFormativo5.setCorso(cdl4);
		pianoFormativo5.setAnnoImmatricolazione("2022/2023");
		
		cdl4.aggiungiPianoFormativo(pianoFormativo5);
		
		//creazione esami
		Esame esame = new Esame();
		esame.setNome("Analisi 1 T");
		esame.setAnno(1);
		esame.setCFU(9);
		esame.setLinkEsame("link1");
		esame.setPeriodo(1);
		esame.setSSO(" ");
		
		pianoFormativo.aggiungiEsame(esame);
		
		
		Esame esame2 = new Esame();
		esame2.setNome("Fondamenti di chimica");
		esame2.setAnno(1);
		esame2.setCFU(6);
		esame2.setLinkEsame("link2");
		esame2.setPeriodo(1);
		esame2.setSSO("CHIM/07");
		
		pianoFormativo3.aggiungiEsame(esame2);
		
		
		Esame esame3 = new Esame();
		esame3.setNome("Geometria ed Algebra");
		esame3.setAnno(1);
		esame3.setCFU(6);
		esame3.setLinkEsame("link3");
		esame3.setPeriodo(1);
		esame3.setSSO("MAT/03");
		
		pianoFormativo2.aggiungiEsame(esame3);
		
		Esame esame4 = new Esame();
		esame4.setNome("Laboratorio di fisica con elementi di statistica");
		esame4.setAnno(1);
		esame4.setCFU(10);
		esame4.setLinkEsame("https://www.unimi.it/it/corsi/insegnamenti-dei-corsi-di-laurea/2024/laboratorio-di-fisica-con-elementi-di-statistica");
		esame4.setPeriodo(1);
		esame4.setSSO("FIS/01");
		
		pianoFormativo3.aggiungiEsame(esame4);
		
		Esame esame5 = new Esame();
		esame5.setNome("Reti Logiche");
		esame5.setAnno(1);
		esame5.setCFU(6);
		esame5.setLinkEsame("link5");
		esame5.setPeriodo(1);
		esame5.setSSO("ING-INF/05");
		
		pianoFormativo.aggiungiEsame(esame5);
		
		
		Esame esame6 = new Esame();
		esame6.setNome("Fondamenti della mista");
		esame6.setAnno(1);
		esame6.setCFU(40);
		esame6.setLinkEsame("link6");
		esame6.setPeriodo(1);
		esame6.setSSO("ING-RAP/01");
		
		pianoFormativo5.aggiungiEsame(esame6);
		
		
		//creazione amministratori
		Amministratore amministratore = new Amministratore();
		amministratore.setUsername("admin1");
		
		Amministratore amministratore2 = new Amministratore();
		amministratore2.setUsername("admin2");
		
		//creazione utenti
		Utente utente = new Utente();
		utente.setNome("Luca");
		utente.setCognome("Bianchi");
		utente.setDataDiNascita(LocalDate.of(2001, 9, 8));
		utente.setUsername("LucaB");
		utente.setListaPreferiti(new ListaPreferiti());
		
		Utente utente2 = new Utente();
		utente2.setNome("Paolo");
		utente2.setCognome("Bitta");
		utente2.setDataDiNascita(LocalDate.of(2001, 9, 8));
		utente2.setUsername("Maruska");
		utente2.setListaPreferiti(new ListaPreferiti());
	
		
		//creazione studenti
		StudenteUniversitario studente = new StudenteUniversitario();
		studente.setUsername("mandarino87");
		studente.setNome("Mario");
		studente.setCognome("Rossi");
		studente.setPianoFormativo(pianoFormativo);
		studente.setCitta(c);
		studente.setLibretto(new Libretto());
		
		c.getStudenti().add(studente);
		
		StudenteUniversitario studente2 = new StudenteUniversitario();
		studente2.setUsername("MadMan");
		studente2.setNome("PierFrancesco");
		studente2.setCognome("Botrugno");
		studente2.setPianoFormativo(pianoFormativo2);
		studente2.setCitta(c);
		studente2.setLibretto(new Libretto());
		
		c.getStudenti().add(studente2);
		
		
		//creazione account
		Account a = new Account();
		a.setUsername(studente.getUsername());
		a.setRuolo("studente");
		a.setPassword("password");
		
		Account a2 = new Account();
		a2.setUsername(utente.getUsername());
		a2.setRuolo("utente");
		a2.setPassword("password");
		
		Account a3 = new Account();
		a3.setUsername(utente2.getUsername());
		a3.setRuolo("utente");
		a3.setPassword("password");
		
		Account a4 = new Account();
		a4.setUsername(studente2.getUsername());
		a4.setRuolo("utente");
		a4.setPassword("password");
		
		Account a5 = new Account();
		a5.setUsername(amministratore.getUsername());
		a5.setRuolo("amministratore");
		a5.setPassword("password");
		
		Account a6 = new Account();
		a6.setUsername(amministratore2.getUsername());
		a6.setRuolo("amministratore");
		a6.setPassword("password");
		
		
		//creazione recensioni corso
		RecensioneCorso r = new RecensioneCorso();
		r.setCorso(cdl);
		r.setTestoRecensione("Corso molto bello, lo consiglio");
		r.setOpportunitaOfferte("offre opportunità in ambito informatico");
		r.setQualitaInsegnamento(5);
		r.setSbocchiLavorativi("bidello");
		r.setStudente(studente);
		r.setCorso(cdl);
		
		cdl.getRecensioni().add(r);
		studente.setRecensioneCorso(r);
		
		RecensioneCorso r2 = new RecensioneCorso();
		r2.setCorso(cdl);
		r2.setTestoRecensione("Corsobrutto");
		r2.setOpportunitaOfferte("offre poco");
		r2.setQualitaInsegnamento(1);
		r2.setSbocchiLavorativi("bho");
		r2.setStudente(studente2);
		r2.setCorso(cdl);
		
		cdl.getRecensioni().add(r2);
		studente2.setRecensioneCorso(r2);
		
		
		//creazione recensioni esami
		RecensioneEsame re = new RecensioneEsame();
		re.setEsame(esame);
		re.setValutazioneProfessore(5);
		re.setVoto(30);
		re.setLode(true);
		re.setStudente(studente);
		re.setTestoRecensione("esame belissimo");
		re.setTempoDiStudio(Duration.ofDays(60));
		
		studente.getRecensioniEsami().add(re);
		esame.getRecensioni().add(re);
		
		
		RecensioneEsame re2 = new RecensioneEsame();
		re2.setEsame(esame2);
		re2.setValutazioneProfessore(0);
		re2.setVoto(18);
		re2.setLode(false);
		re2.setStudente(studente);
		re2.setTestoRecensione("esame orribile");
		re2.setTempoDiStudio(Duration.ofDays(3));
		
		studente.getRecensioniEsami().add(re2);
		esame2.getRecensioni().add(re2);
		
		
		//creazione libretti
		
		
		
		//creazione esami svolti
		
		
		
		//creazione segnalazione recensione Esame
		SegnalazioneRecensioneCorso src = new SegnalazioneRecensioneCorso();
		src.setId("1");
		src.setTestoSegnalazione("recensione non conforme");
		src.setTimeStamp(LocalDateTime.now());
		
		src.setUtenteSegnalante(utente);
		src.setRecensioneSegnalata(r);
				
				
		//creazione segnalazione recensione Esame
		SegnalazioneRecensioneEsame sre = new SegnalazioneRecensioneEsame();
		sre.setId("1");
		sre.setTestoSegnalazione("recensione non conforme");
		sre.setTimeStamp(LocalDateTime.now());
		
		sre.setUtenteSegnalante(utente2);
		sre.setRecensioneSegnalata(re);
		
		
		//agiunta al db delle universita
		universita.put("Bologna", u);
		universita.put("Milano", u2);
		
		//aggiunta dei corsi
		corsi.add(cdl);
		corsi.add(cdl2);
		corsi.add(cdl3);
		corsi.add(cdl4);
		
		//aggiunta al db delle citta
		citta.put(c.getNomeCitta(), c);
		citta.put(c2.getNomeCitta(), c2);
		citta.put(c3.getNomeCitta(), c3);
		
		//aggiunta al db degli account
		accounts.put(studente.getUsername(), a);
		accounts.put(utente.getUsername(), a2);
		accounts.put(studente2.getUsername(), a3);
		accounts.put(utente2.getUsername(), a4);
		accounts.put(amministratore.getUsername(), a5);
		accounts.put(amministratore2.getUsername(), a6);
		
		//aggiunta al db degli utenti 
		utenti.put(utente.getUsername(), utente);
		utenti.put(utente2.getUsername(), utente2);
		
		//aggiunta al db degli studenti
		studenti.put(studente.getUsername(), studente);
		studenti.put(studente2.getUsername(), studente2);
		
		//aggiunta al db delle recensioni corso
		recensioniCorso.add(r);
		recensioniCorso.add(r2);
		
		//aggiunta al db delle recensioni corso
		recensioniEsami.add(re);
		recensioniEsami.add(re2);
		
		//aggiunta al db delle recensioni corso
		segnalazioniCorso.add(src);
		
		//aggiunta al db delle recensioni corso
		segnalazioniEsami.add(sre);
	}

	public Map<String, Account> getAccounts() {
		return accounts;
	}

	public void setAccounts(Map<String, Account> accounts) {
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

	public List<RecensioneCorso> getRecensioniCorso() {
		return recensioniCorso;
	}

	public void setRecensioniCorso(List<RecensioneCorso> recensioniCorso) {
		this.recensioniCorso = recensioniCorso;
	}

	public List<SegnalazioneRecensioneCorso> getSegnalazioniCorso() {
		return segnalazioniCorso;
	}

	public void setSegnalazioniCorso(List<SegnalazioneRecensioneCorso> segnalazioniCorso) {
		this.segnalazioniCorso = segnalazioniCorso;
	}

	public List<RecensioneEsame> getRecensioniEsami() {
		return recensioniEsami;
	}

	public void setRecensioniEsami(List<RecensioneEsame> recensioniEsami) {
		this.recensioniEsami = recensioniEsami;
	}

	public List<SegnalazioneRecensioneEsame> getSegnalazioniEsami() {
		return segnalazioniEsami;
	}

	public void setSegnalazioniEsami(List<SegnalazioneRecensioneEsame> segnalazioniEsami) {
		this.segnalazioniEsami = segnalazioniEsami;
	}
	
}
