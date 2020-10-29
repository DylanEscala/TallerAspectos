import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;

public aspect Logger {
	File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();

    pointcut creado() : call(* create*(..) );
    after() : creado() {
    //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
    pointcut depositado() : call(* moneyMake*(..));
    after() : depositado(){
    	try(BufferedWriter bw = new BufferedWriter(new FileWriter(file,true));){
    		String hour = Integer.toString(cal.get(Calendar.HOUR));
    		String minute = Integer.toString(cal.get(Calendar.MINUTE));
    		String second = Integer.toString(cal.get(Calendar.SECOND));
        	String contenido = "DEPOSITO;" + hour + "-" + minute + "-" + second;
        	if(!file.exists()){
        	   file.createNewFile();
        	}
        	bw.write(contenido);
        	bw.newLine();
        	bw.close();
        	System.out.println("**** User deposited ****");
    	}catch(IOException ioe){
    		System.out.println("Exception occurred:");
        	ioe.printStackTrace();
        }
	}
    pointcut retirado() : call(* moneyWith*(..));
    after() : retirado(){
    	try(BufferedWriter bw = new BufferedWriter(new FileWriter(file,true));){
    		String hour = Integer.toString(cal.get(Calendar.HOUR));
    		String minute = Integer.toString(cal.get(Calendar.MINUTE));
    		String second = Integer.toString(cal.get(Calendar.SECOND));
        	String contenido = "RETIRO;" + hour + "-" + minute + "-" + second;
        	if(!file.exists()){
        	   file.createNewFile();
        	}
        	bw.write(contenido);
        	bw.newLine();
        	bw.close();
        	System.out.println("**** User withdrawed ****");
    	}catch(IOException ioe){
    		System.out.println("Exception occurred:");
        	ioe.printStackTrace();
        }
    }
    
}