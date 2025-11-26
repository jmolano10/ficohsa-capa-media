xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/createBankingUser";
(:: import schema at "../../../../../../MWBanking/Users/RequestorServices/XSD/createBankingUser.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/CreateBankingUserIN";
declare namespace ns3 = "urn:tailored.icbanking.services.administration.general";

declare variable $creaUsuarioSistemaIN as element() (:: schema-element(ns1:createBankingUserRequest) ::) external;
declare variable $SubsidiaryID as xs:string external;
declare variable $ProductTypeID as xs:string external;
declare variable $DocumentTypeID as xs:string external;

declare function ns2:createBankingUserIN($creaUsuarioSistemaIN as element() (:: schema-element(ns1:createBankingUserRequest) ::), 
                                         $SubsidiaryID as xs:string, 
                                         $ProductTypeID as xs:string, 
                                         $DocumentTypeID as xs:string) as element(*) {
   <ns3:UsersOnboardingProcessMessageIn>
         <ns3:SubsidiaryId>{$SubsidiaryID}</ns3:SubsidiaryId>  
         <ns3:DocumentNumber>{fn:data($creaUsuarioSistemaIN/ns1:DocumentNumber)}</ns3:DocumentNumber>
         <ns3:DocumentTypeId>{$DocumentTypeID}</ns3:DocumentTypeId>
         <ns3:Names>{fn:data($creaUsuarioSistemaIN/ns1:CustomerNames)}</ns3:Names>
         <ns3:LastNames>{fn:data($creaUsuarioSistemaIN/ns1:CustomerLastNames)}</ns3:LastNames>
         <ns3:Mail>{fn:data($creaUsuarioSistemaIN/ns1:Email)}</ns3:Mail>
         <ns3:Phone>{fn:data($creaUsuarioSistemaIN/ns1:Phone)}</ns3:Phone>
         <ns3:ProductTypeId>{$ProductTypeID}</ns3:ProductTypeId>
         <ns3:ProductNumber>{fn:data($creaUsuarioSistemaIN/ns1:ProductNumber)}</ns3:ProductNumber>
         <ns3:UserName>{fn:data($creaUsuarioSistemaIN/ns1:UserName)}</ns3:UserName>
    </ns3:UsersOnboardingProcessMessageIn>
};

ns2:createBankingUserIN($creaUsuarioSistemaIN, $SubsidiaryID, $ProductTypeID, $DocumentTypeID)
