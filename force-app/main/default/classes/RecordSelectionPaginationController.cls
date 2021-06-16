/**  
  *@Description:Extension Class for Querying the Data and setting the Pagination  
 **/  
 public with sharing class RecordSelectionPaginationController{  
   // Map stores all the records queried as per the pagenumber   
   Map<integer,List<cOpportunity>> mapOpportunityPages = new Map<integer,List<cOpportunity>>();   
   // Pagenumber  
   public integer intPageNumber{get;set;}  
   // total number of pages  
   public integer intNumberofPages{get;set;}  
   // returns the data to be displayed on the page  
   
   public string textmsg{get;set;}
   
   Public static String ENDPOINT = 'http://pridesms.in/api/v1/sendSMS.php?user=manjeera&password=manjeera&senderid=MNJERA&flashsms=0&number=';
   
   public List<cOpportunity> getLstOppRecords(){  
     List<cOpportunity> lstOpp= new List<cOpportunity>();  
     lstOpp.addAll(mapOpportunityPages.get(intPageNumber));  
     return lstOpp;  
   }  
   // Controller  
   public RecordSelectionPaginationController(ApexPages.StandardController controller) {  
   }  
   // sets the pagination data  
   public Pagereference setPagination() {  
     integer NumberofRecords = 0;  
     integer pagenumber = 1;  
     // Looping through the records of Opportunity  
     for (Opportunity objOpp :[SELECT Id,Name,StageName,Account.Name,PhoneNumber__c FROM Opportunity LIMIT 10000]) {  
       if (NumberofRecords < 10) {  
         if (mapOpportunityPages.containsKey(pagenumber)){  
           mapOpportunityPages.get(pagenumber).add(new cOpportunity(objOpp,false));  
         }  
         else {  
           mapOpportunityPages.put(pagenumber,new List<cOpportunity>{new cOpportunity(objOpp,false)});  
         }  
         NumberofRecords++;  
         if (NumberofRecords == 10) {  
           NumberofRecords = 0;  
           pagenumber++;  
         }  
       }  
     }  
     intNumberofPages = mapOpportunityPages.size();  
     intPageNumber =1;  
     getLstOppRecords();  
     return null;  
   }  
   public Boolean hasNext {  
     get {  
       if (intNumberofPages <= intPageNumber) {  
         return false;  
       }  
       else {  
         return true;  
       }  
     }  
     set;  
   }  
   public Boolean hasPrevious {  
     get {  
       if (intPageNumber == 1) {  
         return false;  
       }  
       else {  
         return true;  
       }  
     }  
     set;  
   }  
   public void first() {  
      intPageNumber = 1;  
      getLstOppRecords();  
   }  
   public void last() {  
      intPageNumber=intNumberofPages;   
      getLstOppRecords();  
   }   
   public void previous() {  
      intPageNumber--;  
      getLstOppRecords();  
   }  
    public void next() {  
      intPageNumber++;  
      getLstOppRecords();  
    }  
   // Wrapper to wrap the Checkbox value and Objrecord together  
   public class cOpportunity {  
     public Opportunity objOpp{get;set;}  
     public Boolean Selected{get;set;}   
     public cOpportunity(Opportunity objOpp,Boolean bSel) {  
       this.objOpp = objOpp;  
       this.Selected = bSel;  
     }   
   }  
   
   public void selectedOpportunity(){
       
       for(cOpportunity oo:getLstOppRecords()){
           if(oo.Selected==True){
               ENDPOINT=ENDPOINT+oo.objOpp.PhoneNumber__c+',';
           }
       }
       
        ENDPOINT=ENDPOINT.substring(0,ENDPOINT.length()-1);
        
        system.debug('------textmessage-------'+textmsg);
        
        ENDPOINT=ENDPOINT+'&text='+textmsg;
        
        system.debug('------url-------'+ENDPOINT);
        
        system.debug('---------'+ENDPOINT);
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ENDPOINT);
        req.setMethod('POST');
        HttpResponse res = new Http().send(req);
   
   }
 }