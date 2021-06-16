trigger ApplyCouponTriggerCustomSetting on QuoteLineItem (Before insert) 
{
 public List<Promo__C> code {get;set;}
code=new list<Promo__C>();
 
for(QuoteLineItem  QLI:trigger.new)
{
 Map<string,Promo__C> Settings = Promo__C.getAll();
 
 /* Promo__c settings = Promo__c.getinstance('1'); //This method will fetch only 1 value.
 system.debug('----------------------'+settings);
 String Code= settings.Code__c;
 Decimal Percentage=settings.Percentage__c;
    if(QLi.Promo_Code__c==Code)
    {
        QLI.Discount=Percentage;
        System.debug(QLI.Discount);
    }
  */
    For(Promo__C S:Promo__C.getAll().Values()) //This will retrieve the list of values from Custom settings
  {
      system.debug(S.Code__c);
      System.debug(S.Percentage__c);
      if(QLI.Promo_Code__c==S.Code__c)
      {
          QLI.Discount=S.Percentage__c;
          
      }
  }
    
  
} 
}