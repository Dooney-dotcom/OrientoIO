package util;

import java.util.ArrayList;
import java.util.List;

public class PianoFormativoResult {
	private List<EsameResult> esami;
	private String name;
	
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public PianoFormativoResult() {
		this.esami = new ArrayList<>();
	}
	
	public List<EsameResult> getEsami() {
		return esami;
	}

	public void setEsami(List<EsameResult> esami) {
		this.esami = esami;
	}

	@Override
	public String toString() {
		return "PianoFormativoResult [esami=" + esami + ", name=" + name + "]";
	}
	
	
}
