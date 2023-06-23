package model;


import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import db.DataSource;

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
	private List<PianoFormativo> pianiFormativi;
	
	//Alessandro
	private List<InformazioniCitta> infoCitta;
	
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
		this.pianiFormativi = new ArrayList<>();
		//
		
		this.infoCitta = new ArrayList<>();
		
		
		/*
		 * Get delle Citta da DB
		 */
		
		try {
			DataSource dataSource = new DataSource(DataSource.DB2);
			Connection connection = dataSource.getConnection();
			
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM CITTA_UNIVERSITARIE");
			ResultSet rs = statement.executeQuery();
			
			while(rs.next()) {
				CittaUniversitaria c = new CittaUniversitaria();
				c.setNomeCitta(rs.getString("NOME"));
				c.setFotoCitta(new File(""));
				
				System.out.println(c);
				
				this.citta.put(c.getNomeCitta(), c);
			}
			
			rs.close();
			statement.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/*
		 * Get delle università da DB
		 */
		try {
			DataSource dataSource = new DataSource(DataSource.DB2);
			Connection connection = dataSource.getConnection();
			
			PreparedStatement statement = connection.prepareStatement("SELECT u.*, c.nome as NOMECITTA "
					+ "FROM UNIVERSITA u "
					+ "JOIN CITTA_UNIVERSITARIE c "
					+ "ON c.ID = u.IDCITTAUNIVERSITARIA ");
			ResultSet rs = statement.executeQuery();
			
			while(rs.next()) {
				Universita u = new Universita();
				u.setNome(rs.getString("NOME"));
				u.setLinkBorsaDiStudio("linkBorsaDiStudio");
				u.setLinkUniversita(rs.getString("linkUniversita"));
				
				CittaUniversitaria c = this.citta.get(rs.getString("NOMECITTA"));
				
				u.setCitta(c);
				
				System.out.println(u);
				
				this.universita.put(u.getNome(), u);
			}
			
			rs.close();
			statement.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/*
		 * GET dei corsi da DB
		 */
		
		try {
			DataSource dataSource = new DataSource(DataSource.DB2);
			Connection connection = dataSource.getConnection();
			
			PreparedStatement statement = connection.prepareStatement("SELECT c.*, u.nome as UNIVERSITA "
					+ "FROM UNIVERSITA u "
					+ "JOIN CORSI c "
					+ "ON c.IDUNIVERSITA = u.ID ");
			ResultSet rs = statement.executeQuery();
			
			
			/*
			 * CREATE TABLE CORSI (
	ID INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
	nome varchar(300) NOT NULL, 
	coordinatore varchar(300) NOT NULL, 
	dipartimento varchar(50) NOT NULL, 
	tipo varchar(50) NOT NULL, 
	lingua varchar(50) NOT NULL, 
	accesso varchar (100) NOT NULL, 
	link varchar(300) NOT NULL,
	classeDiCorso varchar(50) NOT NULL, 
	idUniversita int NOT NULL REFERENCES UNIVERSITA(ID)
);
			 */
			
			while(rs.next()) {
				CorsoDiLaurea c = new CorsoDiLaurea();
				c.setNome(rs.getString("NOME"));
				c.setCoordinatore(rs.getString("COORDINATORE"));
				c.setDipartimento(rs.getString("DIPARTIMENTO"));
				c.setTipo(TipoCorso.valueOf(rs.getString("TIPO")));
				c.setLingua(rs.getString("LINGUA"));
				c.setAccesso(rs.getString("ACCESSO"));
				c.setLinkCorso(rs.getString("LINK"));
				c.setClasseDiCorso(rs.getString("CLASSEDICORSO"));
				
				Universita u = this.universita.get(rs.getString("UNIVERSITA"));
				c.setUniversita(u);
				u.getCorsiDiLaurea().add(c);
				this.corsi.add(c);
				
				System.out.println(c);
			}
			
			rs.close();
			statement.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/*
		 * GET dei piani formativi da Database
		 */
		try {
			DataSource dataSource = new DataSource(DataSource.DB2);
			Connection connection = dataSource.getConnection();
			
			PreparedStatement statement = connection.prepareStatement("SELECT p.* "
					+ "FROM PIANI_FORMATIVI p "
					+ "JOIN CORSI c "
					+ "ON c.ID = p.ID_CORSO ");
			ResultSet rs = statement.executeQuery();
			
			while(rs.next()) {
				PianoFormativo p = new PianoFormativo();
				p.setAnnoImmatricolazione(rs.getString("ANNOIMMATRICOLAZIONE"));
				
				CorsoDiLaurea c = this.corsi.get(rs.getInt("ID_CORSO") - 1);
				p.setCorso(c);
				c.getPianiFormativi().add(p);
				
				this.pianiFormativi.add(p);
				
				System.out.println(p);
			}
			
			rs.close();
			statement.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		/*
		 * Get degli esami dal DB per fare prima
		 */
		try {
			DataSource dataSource = new DataSource(DataSource.DB2);
			Connection connection = dataSource.getConnection();
			
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT e.*, p.ID AS ID_PIANO from esami e join piani_formativi p on e.idPianoFormativo = p.id");
			
			while(rs.next()) {
				Esame e = new Esame();
				e.setNome(rs.getString("NOME"));
				e.setSSO(rs.getString("SSD"));
				e.setCFU(rs.getInt("CFU"));
				e.setPeriodo(rs.getInt("PERIODO"));
				e.setAnno(rs.getInt("ANNO"));
				e.setLinkEsame(rs.getString("LINKESAME"));
				
				PianoFormativo p = pianiFormativi.get(rs.getInt("ID_PIANO") - 1);
				
				p.getEsami().add(e);
				Collections.sort(p.getEsami(), Comparator.comparingInt(Esame::getAnno).thenComparingInt(Esame::getPeriodo).thenComparingInt(Esame::getCFU).thenComparing(Esame::getNome));
				
				System.out.println(e);
			}
			
			rs.close();
			statement.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		//creazione esami
		Esame esame = new Esame();
		esame.setNome("Analisi 1 T");
		esame.setAnno(1);
		esame.setCFU(9);
		esame.setLinkEsame("link1");
		esame.setPeriodo(1);
		esame.setSSO(" ");
		
		//pianoFormativo.aggiungiEsame(esame);
		
		
		Esame esame2 = new Esame();
		esame2.setNome("Fondamenti di chimica");
		esame2.setAnno(1);
		esame2.setCFU(6);
		esame2.setLinkEsame("link2");
		esame2.setPeriodo(1);
		esame2.setSSO("CHIM/07");
		
		//pianoFormativo3.aggiungiEsame(esame2);
		
		
		Esame esame3 = new Esame();
		esame3.setNome("Geometria ed Algebra");
		esame3.setAnno(1);
		esame3.setCFU(6);
		esame3.setLinkEsame("link3");
		esame3.setPeriodo(1);
		esame3.setSSO("MAT/03");
		
		//pianoFormativo2.aggiungiEsame(esame3);
		
		Esame esame4 = new Esame();
		esame4.setNome("Laboratorio di fisica con elementi di statistica");
		esame4.setAnno(1);
		esame4.setCFU(10);
		esame4.setLinkEsame("https://www.unimi.it/it/corsi/insegnamenti-dei-corsi-di-laurea/2024/laboratorio-di-fisica-con-elementi-di-statistica");
		esame4.setPeriodo(1);
		esame4.setSSO("FIS/01");
		
		//pianoFormativo3.aggiungiEsame(esame4);
		
		Esame esame5 = new Esame();
		esame5.setNome("Reti Logiche");
		esame5.setAnno(1);
		esame5.setCFU(6);
		esame5.setLinkEsame("link5");
		esame5.setPeriodo(1);
		esame5.setSSO("ING-INF/05");
		
		//pianoFormativo.aggiungiEsame(esame5);
		
		
		Esame esame6 = new Esame();
		esame6.setNome("Fondamenti della mista");
		esame6.setAnno(1);
		esame6.setCFU(40);
		esame6.setLinkEsame("link6");
		esame6.setPeriodo(1);
		esame6.setSSO("ING-RAP/01");
		
		//pianoFormativo5.aggiungiEsame(esame6);
		
		
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
		studente.setPianoFormativo(this.pianiFormativi.get(0));
		studente.setCitta(this.citta.get("Bologna"));
		studente.setLibretto(new Libretto());
		
		this.citta.get("Bologna").getStudenti().add(studente);
		
		StudenteUniversitario studente2 = new StudenteUniversitario();
		studente2.setUsername("MadMan");
		studente2.setNome("PierFrancesco");
		studente2.setCognome("Botrugno");
		studente2.setPianoFormativo(this.pianiFormativi.get(1));
		studente2.setCitta(this.citta.get("Bologna"));
		studente2.setLibretto(new Libretto());
		
		this.citta.get("Bologna").getStudenti().add(studente2);
		
		
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
		r.setCorso(this.corsi.get(0));
		r.setTestoRecensione("Corso molto bello, lo consiglio");
		r.setOpportunitaOfferte("offre opportunità in ambito informatico");
		r.setQualitaInsegnamento(5);
		r.setSbocchiLavorativi("bidello");
		r.setStudente(studente);
		r.setCorso(this.corsi.get(0));
		
		this.corsi.get(0).getRecensioni().add(r);
		studente.setRecensioneCorso(r);
		
		RecensioneCorso r2 = new RecensioneCorso();
		r2.setCorso(this.corsi.get(0));
		r2.setTestoRecensione("Corsobrutto");
		r2.setOpportunitaOfferte("offre poco");
		r2.setQualitaInsegnamento(1);
		r2.setSbocchiLavorativi("bho");
		r2.setStudente(studente2);
		r2.setCorso(this.corsi.get(0));
		
		this.corsi.get(0).getRecensioni().add(r2);
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

	public List<InformazioniCitta> getInfoCitta() {
		return infoCitta;
	}

	public void setInfoCitta(List<InformazioniCitta> infoCitta) {
		this.infoCitta = infoCitta;
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
