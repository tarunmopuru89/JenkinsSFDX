Global Class SMScontorller
{
private static String ENDPOINT = 'http://pridesms.in/api/v1/sendSMS.php?user=manjeera&password=manjeera&senderid=MNJERA&flashsms=0';
Public static string TEXT = 'test';

public static map<integer,string> numbers=new map<integer,string>();
public static map<integer,string> messagedata=new map<integer,string>();

public static integer i=1;

webservice static void querymethod()
{

system.debug('---into the method----------');
for(Account obj:[Select id,Phone,website from Account]){
    
    
    system.debug('-----obj data----------------'+obj);
    
    numbers.put(i,obj.Phone);
    messagedata.put(i,obj.website);
    i=i+1;
    
    
   }
   
   system.debug('---map values----------'+numbers.values());
    
    
    ENDPOINT =ENDPOINT+ 'http://pridesms.in/api/v1/sendSMS.php?user=manjeera&password=manjeera&senderid=MNJERA&flashsms=0&number=';
    for(integer i=1;i<numbers.size();i++)
    {
        ENDPOINT=ENDPOINT+numbers.get(i)+',';
        system.debug('------check end point url----------------'+ENDPOINT);
    }
    
    ENDPOINT=ENDPOINT.substring(0,ENDPOINT.length()-1);
    
    ENDPOINT=ENDPOINT+'&text=test';
     system.debug('------check final point url----------------'+ENDPOINT);
    
    /*
    ENDPOINT=ENDPOINT+'&text=';
    for(integer i=1;i<messagedata.size();i++)
    {
        ENDPOINT=ENDPOINT+messagedata.get(i);
        system.debug('------check end point url----------------'+ENDPOINT);
    }
    
    */
    
    
    HttpRequest req = new HttpRequest();
    req.setEndpoint(ENDPOINT);
    req.setMethod('POST');
    req.setBody(TEXT);
    
    //HttpResponse res = new Http().send(req);
    
    
} 
}