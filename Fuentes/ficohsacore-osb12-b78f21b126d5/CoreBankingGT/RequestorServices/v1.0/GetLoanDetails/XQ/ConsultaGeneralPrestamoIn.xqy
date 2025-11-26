xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetLoanDetailsGT_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetLoanDetails/GetLoanDetailsGT_BS_sp.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/middleware.services/consultaGeneralPrestamo";

declare variable $loanId as xs:string external;

declare function ns2:consultaGeneralPrestamoIn($loanId as xs:string) as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        <ns3:LOAN_ID>{fn:data($loanId)}</ns3:LOAN_ID>
    </ns3:InputParameters>
};

ns2:consultaGeneralPrestamoIn($loanId)