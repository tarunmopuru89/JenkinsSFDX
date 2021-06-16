trigger CampaginMemberUpdate on Campaign (after update) {
    Boolean B;
    String CampaginId;
    for(Campaign Campaign : Trigger.New){
        Campaign OldCampaignLink = Trigger.OldMap.get(Campaign.Id);
        if(OldCampaignLink.Name != Campaign.Name){        
        B = TRUE;
        CampaginId = Campaign.id;
        }else{
        B = False;
        }     
    }  
    
    if(B){
    List<CampaignMember> UpdateCampaignMember =  new List<CampaignMember>();
        for(CampaignMember CampaignMember : [select id from CampaignMember where id =: CampaginId]){
            UpdateCampaignMember.add(CampaignMember );                
        }
        Update UpdateCampaignMember;
    } 
}