xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/ChequeBooksOperations/XMLSchema_21306858.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/accountsTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/accountsTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $t24Response as element() (:: schema-element(ns1:SolicituddechequeraResponse) ::) external;

declare function xq:Tx_T24_ToCreateChequeBooksResponse($uuid as xs:string, 
                                                       $t24Response as element() (:: schema-element(ns1:SolicituddechequeraResponse) ::)) 
                                                       as element() (:: schema-element(ns2:createCheckBooksResponse) ::) {
    <ns2:createCheckBooksResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            {
                if ($t24Response/Status/transactionId)
                then <com:TransactionId>{fn:data($t24Response/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:AccountNumber>{fn:data($t24Response/FICOHCHECKBOOKREQUESTType/ACCOUNTNUMBER)}</ns2:AccountNumber>
        {
            if ($t24Response/FICOHCHECKBOOKREQUESTType/DESTINAGENCYCODE)
            then <ns2:DestinationBranch>{fn:data($t24Response/FICOHCHECKBOOKREQUESTType/DESTINAGENCYCODE)}</ns2:DestinationBranch>
            else ()
        }
        {
            if ($t24Response/FICOHCHECKBOOKREQUESTType/CHECKBOOKTYPE)
            then 
                if ($t24Response/FICOHCHECKBOOKREQUESTType/CHEQUETYPEID)
                then <ns2:ChequeBookType>{fn:data($t24Response/FICOHCHECKBOOKREQUESTType/CHEQUETYPEID)}</ns2:ChequeBookType>
                else ()
            else ()
        }
        {
            if ($t24Response/FICOHCHECKBOOKREQUESTType/NOOFBOOKS)
            then <ns2:NoOfBooks>{fn:data($t24Response/FICOHCHECKBOOKREQUESTType/NOOFBOOKS)}</ns2:NoOfBooks>
            else ()
        }
        {
            if ($t24Response/FICOHCHECKBOOKREQUESTType/CHEQUENOSTART)
            then <ns2:FirstChequeNumber>{fn:data($t24Response/FICOHCHECKBOOKREQUESTType/CHEQUENOSTART)}</ns2:FirstChequeNumber>
            else ()
        }
        {
            if ($t24Response/FICOHCHECKBOOKREQUESTType/CHEQUENOEND)
            then <ns2:LastChequeNumber>{fn:data($t24Response/FICOHCHECKBOOKREQUESTType/CHEQUENOEND)}</ns2:LastChequeNumber>
            else ()
        }
        {
            if ($t24Response/FICOHCHECKBOOKREQUESTType/CLAIMPERSON)
            then <ns2:AuthorizedClaimer>{fn:data($t24Response/FICOHCHECKBOOKREQUESTType/CLAIMPERSON)}</ns2:AuthorizedClaimer>
            else ()
        }
        <ns2:DateTime>{        
        fn:concat('20',fn:substring(fn:data($t24Response/FICOHCHECKBOOKREQUESTType/gDATETIME/DATETIME[1]),1,2),'-',fn:substring(fn:data($t24Response/FICOHCHECKBOOKREQUESTType/gDATETIME/DATETIME[1]),3,2),'-',fn:substring(fn:data($t24Response/FICOHCHECKBOOKREQUESTType/gDATETIME/DATETIME[1]),5,2),'T',fn:substring(fn:data($t24Response/FICOHCHECKBOOKREQUESTType/gDATETIME/DATETIME[1]),7,2),':',fn:substring(fn:data($t24Response/FICOHCHECKBOOKREQUESTType/gDATETIME/DATETIME[1]),9,2),':00')
        }</ns2:DateTime>
    </ns2:createCheckBooksResponse>
};

xq:Tx_T24_ToCreateChequeBooksResponse($uuid, $t24Response)
