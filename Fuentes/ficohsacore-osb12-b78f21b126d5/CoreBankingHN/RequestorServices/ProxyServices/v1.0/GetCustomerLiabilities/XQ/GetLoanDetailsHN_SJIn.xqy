xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/getLoanDetailsHN_SJ";
(:: import schema at "../XSD/GetLoanDetailsHN_SJ.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSHN/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
(:: import schema at "../../../../../../LegacyCoreBankingHN/ProviderServices/XSD/GetCustomerLiabilities/ConsultaListaPrestamos.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/GetLoanDetailsHN_SJIn";

declare variable $consultaListaPrestamos as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $applicationId as xs:string external;
declare variable $language as xs:string external;
declare variable $uuid as xs:string external;

declare function ns1:getLoanDetailsHN_SJIn($sourceBank as xs:string,
                                          $destinationBank as xs:string,
                                          $applicationId as xs:string,
                                          $language as xs:string,
                                          $uuid as xs:string,
                                          $consultaListaPrestamos as element() (:: schema-element(ns2:OutputParameters) ::)) as element() (:: schema-element(ns3:getLoanDetailsHN_SJRequest) ::) {
    <ns3:getLoanDetailsHN_SJRequest>
        <ns3:LOANS>
            {
                for $ITEM in $consultaListaPrestamos/ns2:LIABILITY_NUMBER/ns2:ITEM
                return 
                <ns3:LOAN_ID>{fn:data($ITEM)}</ns3:LOAN_ID>
            }
        </ns3:LOANS>
        <ns3:SOURCE_BANK>{fn:data($sourceBank)}</ns3:SOURCE_BANK>
        <ns3:DESTINATION_BANK>{fn:data($destinationBank)}</ns3:DESTINATION_BANK>
        <ns3:APPLICATION_ID>{fn:data($applicationId)}</ns3:APPLICATION_ID>
        <ns3:LANGUAGE>{fn:data($language)}</ns3:LANGUAGE>
        <ns3:UUID>{fn:data($uuid)}</ns3:UUID>
    </ns3:getLoanDetailsHN_SJRequest>
};

ns1:getLoanDetailsHN_SJIn($sourceBank, $destinationBank, $applicationId, $language, $uuid, $consultaListaPrestamos)