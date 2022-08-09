package it.unibo.big.m3d.m3dschema;

public class State {

    public String state;
    public Country country;


    public State(int i, Country country){
        this.state = "STATE" + i;
        this.country = country;
    }

    @Override
    public String toString() {
        return "State: " + state + " - " + country;
    }

}
