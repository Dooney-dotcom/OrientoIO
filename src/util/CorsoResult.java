package util;

import java.util.ArrayList;
import java.util.List;

public class CorsoResult {
	private List<PianoFormativoResult> piani;
	private String name;
	
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public CorsoResult() {
		this.piani = new ArrayList<>();
	}

	public List<PianoFormativoResult> getPiani() {
		return piani;
	}

	public void setPiani(List<PianoFormativoResult> piani) {
		this.piani = piani;
	}

	@Override
	public String toString() {
		return "CorsoResult [piani=" + piani + ", name=" + name + "]";
	}
	
	
	
}
