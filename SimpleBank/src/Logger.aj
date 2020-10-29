import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.Calendar;

public aspect Logger {

    File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    
    pointcut creado() : call(* create*(..) );
    after() : creado() {
    //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
    pointcut success() : call(* moneyMakeTransaction*(..) );
    after() : success() {
        try
        {
        	BufferedWriter bw = new BufferedWriter(new FileWriter(file,true));
        	if(!file.exists()){
         	   file.createNewFile();
         	}
            bw.write("Se realizo una transaccion a las: "+Integer.toString(cal.get(Calendar.HOUR))+" horas "+Integer.toString(cal.get(Calendar.MINUTE))+" minutos "+Integer.toString(cal.get(Calendar.SECOND))+" segundos \n");
            bw.close();
            System.out.println("Transaction completed");
            
        } catch (Exception e) {
        	System.out.println("Error");
        }//System.out.println("**** User created ****");
    }
    pointcut success1() : call(* moneyWithdrawal(..) );
    after() : success1() {
    	try
        {
        	BufferedWriter bw = new BufferedWriter(new FileWriter(file,true));
        	if(!file.exists()){
          	   file.createNewFile();
          	}
            bw.write("Se realizo un retiro a las: "+Integer.toString(cal.get(Calendar.HOUR))+" horas "+Integer.toString(cal.get(Calendar.MINUTE))+" minutos "+Integer.toString(cal.get(Calendar.SECOND))+" segundos \n");
            bw.close();
            System.out.println("Money withrawed");
        } catch (Exception e) {
        	System.out.println("Error");
        }//System.out.println("**** User created ****");
    }
}