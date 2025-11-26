xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/payRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/payRemittancesTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRelConPagoBS";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/ConsultaRelConPagoBS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $input as element() (:: schema-element(ns1:pagoRemesas) ::) external;

declare function xq:consultaRelConPagoRem($input as element() (:: schema-element(ns1:pagoRemesas) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_CODIGOCONTRATO>{fn:data($input/ns1:REMITTER_ID)}</ns2:PV_CODIGOCONTRATO>
        <ns2:PV_CLAVEREMESA>{fn:data($input/ns1:REMITTANCE_ID)}</ns2:PV_CLAVEREMESA>
    </ns2:InputParameters>
};

xq:consultaRelConPagoRem($input)
