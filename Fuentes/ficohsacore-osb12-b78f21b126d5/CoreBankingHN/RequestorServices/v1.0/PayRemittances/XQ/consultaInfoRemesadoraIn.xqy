xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/payRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/payRemittancesTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerRemesadoraBS";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/ObtenerRemesadoraBS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $userName as xs:string external;
declare variable $input as element() (:: schema-element(ns1:pagoRemesas) ::) external;

declare function xq:consultaInfoRemesadoraIn($input as element() (:: schema-element(ns1:pagoRemesas) ::),$userName as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_ID_CONVENIO_T24>{fn:data($input/ns1:REMITTER_ID)}</ns2:PV_ID_CONVENIO_T24>
        <ns2:PV_USUARIO_SERVICIO>{fn:data($userName)}</ns2:PV_USUARIO_SERVICIO>
    </ns2:InputParameters>
};

xq:consultaInfoRemesadoraIn($input,$userName)
