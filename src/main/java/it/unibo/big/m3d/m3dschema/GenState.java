package it.unibo.big.m3d.m3dschema;

import java.util.ArrayList;
import java.util.Random;

public class GenState extends Gen {

    public int nValues;
    public GenCountry genCountry;
    public ArrayList<State> states = new ArrayList<>();
    public Random random;

    public GenState(int nValues, int maxCountries, Random random) {
        this.nValues = nValues;
        this.genCountry = new GenCountry(maxCountries);
        this.random = random;
    }

    @Override
    public void initialize(){
        genCountry.initialize();
        for(int i = 0; i< nValues; i++){
            states.add(new State(i, genCountry.getCountry(random)));
        }
    }

    public State getState(Random random) {
        return this.states.get(random.nextInt(this.states.size()));
    }

}
