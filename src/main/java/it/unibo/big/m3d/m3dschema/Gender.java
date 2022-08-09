package it.unibo.big.m3d.m3dschema;

import java.util.Random;

public class Gender {

    public String gender;
    public String[] genderList = { "M", "F" };

    public Gender(Random random){
        this.gender = genderList[random.nextInt(genderList.length)];
    }

    @Override
    public String toString() {
        return "Gender: " + gender;
    }
}
