package it.unibo.big.m3d.m3dschema;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class MDate {

    public Date date;
    public String monthYear;
    public int month;
    public String quarter;
    public String fourMonthsPeriod;
    public String semester;
    public int year;

    private SimpleDateFormat formatMonthYear = new SimpleDateFormat("yyyy-MM");
    private SimpleDateFormat formatMonth = new SimpleDateFormat("MM");
    private SimpleDateFormat formatYear = new SimpleDateFormat("yyyy");

    public MDate(Calendar c){
        this.date = c.getTime();
        this.month = Integer.parseInt(formatMonth.format(c.getTime()));
        this.year = Integer.parseInt(formatYear.format(c.getTime()));
        this.monthYear = formatMonth.format(c.getTime());
        this.quarter = year + "-" + ((int)Math.floor((month-1)/3) + 1);
        this.fourMonthsPeriod = year + "-" + ((int)Math.floor((month-1)/4) + 1);
        this.semester = year + "-" + ((int)Math.floor((month-1)/6) + 1);
    }

    public String toString(){
        return "Date " + date + " - Month: " + month + " - MonthYear: " + monthYear + " - Quarter: " + quarter
                + " - 4MP: " + fourMonthsPeriod + " - Semester: " + semester + " - Year: " + year;
    }

}
