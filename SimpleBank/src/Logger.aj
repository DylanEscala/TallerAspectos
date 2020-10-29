import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public aspect Logger {
	 
	File archivo= new File("log.txt");
	Date fecha;
	
	pointcut success() : call(* create*(..) );
    after() : success() {
    	System.out.println("Usuario Creado");
    }
    
    pointcut depositarDinero() : call(* moneyMakeTransac*());
    after():depositarDinero(){
    	guardar("Deposito de Dinero");
    }
    
    pointcut retirarDinero() : call(* moneyWith*());
    after():retirarDinero(){
    	guardar("Retiro de Dinero");
    }
   
    private String TiempoTransaccion(){
    	fecha = Calendar.getInstance().getTime();
    	//System.out.println(fecha);
    	SimpleDateFormat formateo = new SimpleDateFormat("HH:mm:ss");
    	return formateo.format(fecha);
    }
    
    private void guardar(String mensaje) {
    	String tiempo = TiempoTransaccion();	
    	System.out.println("Tiempo de Transaccion: "+tiempo+" "+"Tipo: " + mensaje);
    	
    	try(BufferedWriter bw = new BufferedWriter(new FileWriter(archivo,true))){
    		bw.append("Tiempo de Transaccion" + tiempo + " - Tipo:" + mensaje+"\n");
    	}catch(IOException ex) {
    		System.out.println(ex.getMessage());
    	}
    }
}


