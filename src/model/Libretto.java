package model;

import java.util.ArrayList;
import java.util.List;

public class Libretto {
	
	private Double media;
	private Integer CFU;
	private Double baseDiLaurea;
	private List<EsameSvolto> esamiSvolti;
	
	public Libretto() {
		this.esamiSvolti = new ArrayList<>();
	}
	
	public Double getMedia() {
		return media;
	}
	
	public void setMedia(Double media) {
		this.media = media;
	}
	
	public Integer getCFU() {
		return CFU;
	}
	public void setCFU(Integer cFU) {
		CFU = cFU;
	}
	public Double getBaseDiLaurea() {
		return baseDiLaurea;
	}
	public void setBaseDiLaurea(Double baseDiLaurea) {
		this.baseDiLaurea = baseDiLaurea;
	}
	public List<EsameSvolto> getEsamiSvolti() {
		return esamiSvolti;
	}
	public void setEsamiSvolti(List<EsameSvolto> esamiSvolti) {
		this.esamiSvolti = esamiSvolti;
	}
	
	public synchronized void registraVoto(EsameSvolto e) {
		this.getEsamiSvolti().add(e);
		this.CFU += e.getEsame().getCFU();
		System.out.println("CFU: " + this.CFU);
		
		double somma = 0;
		for(EsameSvolto ex : this.esamiSvolti) {
			somma += ex.getVoto() * ex.getEsame().getCFU();
		}
		System.out.println("SOMMA: " + somma);
		
		this.media = somma / CFU;
		System.out.println("MEDIA: " + media);
		
		this.baseDiLaurea = media * 110 / 30;
		System.out.println("BDL: " + baseDiLaurea);
	}

	public synchronized Proiezione proiettaVoto(int voto, int cfu2, boolean lode) {
		int cfuProiezione = this.CFU + cfu2;
		double somma = 0;
		for(EsameSvolto ex : this.esamiSvolti) {
			somma += ex.getVoto() * ex.getEsame().getCFU();
		}
		
		somma+=voto*cfu2;
		
		double media = somma / cfuProiezione;
		
		double baseDiLaurea = media * 110 / 30;
		
		Proiezione proiezione = new Proiezione();
		proiezione.setMedia(media);
		proiezione.setBaseDiLaurea(baseDiLaurea);
		proiezione.setCFU(cfuProiezione);
		
		return proiezione;
	}

	public synchronized void modificaEsame(String nomeEsame, int voto, boolean lode) {
		EsameSvolto esameSvolto = null;
		
		for(EsameSvolto x : esamiSvolti) {
			if(x.getEsame().getNome().equals(nomeEsame)) {
				esameSvolto = x;
				break;
			}
		}
		
		esameSvolto.setVoto(voto);
		esameSvolto.setLode(lode);
		
		double somma = 0;
		for(EsameSvolto ex : this.esamiSvolti) {
			somma += ex.getVoto() * ex.getEsame().getCFU();
		}
		System.out.println("SOMMA: " + somma);
		
		this.media = somma / CFU;
		System.out.println("MEDIA: " + media);
		
		this.baseDiLaurea = media * 110 / 30;
		System.out.println("BDL: " + baseDiLaurea);
	}

	public synchronized void rimuoviEsame(String esame) {
		int index = -1;
		EsameSvolto e = null;
		for(int i = 0; i < esamiSvolti.size(); i++) {
			if(esame.equals(esamiSvolti.get(i).getEsame().getNome())) {
				index = i;
				e = esamiSvolti.get(i);
				break;
			}
		}
		
		esamiSvolti.remove(index);
		
		this.CFU -= e.getEsame().getCFU();
		
		if(CFU == 0) {
			media = 0.0;
			baseDiLaurea = 0.0;
		} else {
			double somma = 0;
			for(EsameSvolto ex : this.esamiSvolti) {
				somma += ex.getVoto() * ex.getEsame().getCFU();
			}
			System.out.println("SOMMA: " + somma);
			
			this.media = somma / CFU;
			System.out.println("MEDIA: " + media);
			
			this.baseDiLaurea = media * 110 / 30;
			System.out.println("BDL: " + baseDiLaurea);
		}
	}
}
