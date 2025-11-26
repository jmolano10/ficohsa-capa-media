xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetaClienteHN";
(:: import schema at "../../../../../../CreditCardProcessor/ProviderServices/XSD/GetCustomerLiabilities/conDatoTarjetaClienteHN_sp.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/ConDatosTarjetaClienteIn";

declare variable $customerId as xs:string external;
declare variable $codigoPais as xs:string external;

declare function ns2:conDatosTarjetaClienteIn($customerId as xs:string, 
                                              $codigoPais as xs:string) 
                                              as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:Pais>{fn:data($codigoPais)}</ns1:Pais>
        <ns1:NumCliente>{fn-bea:pad-left($customerId, 19, '0')}</ns1:NumCliente>
    </ns1:InputParameters>
};

ns2:conDatosTarjetaClienteIn($customerId, $codigoPais)