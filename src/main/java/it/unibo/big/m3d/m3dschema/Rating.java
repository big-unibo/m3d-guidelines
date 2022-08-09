package it.unibo.big.m3d.m3dschema;

import java.util.Random;

public class Rating {

    public int rating;
    public String posNeg;

    public Rating(Random random){
        this.rating = random.nextInt(5)+1;
        if(rating <= 2) { this.posNeg = "NEG"; }
        else if(rating == 3) { this.posNeg = "NEU"; }
        else this.posNeg = "POS";
    }

    @Override
    public String toString() {
        return "Rating: " + rating + " - PosNeg: " + posNeg;
    }

}
