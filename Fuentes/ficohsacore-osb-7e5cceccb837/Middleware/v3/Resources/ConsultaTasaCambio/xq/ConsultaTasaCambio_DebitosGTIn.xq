(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/ABKGT/consultaTasaCambio/xsd/ConsultaTasaCambio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaTasaCambio";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaTasaCambio/xq/ConsultaTasaCambio_DebitosGTIn/";

declare function xf:ConsultaTasaCambio_DebitosGTIn($SourceCurrency as xs:string,
    $TargetCurrency as xs:string,
    $UserName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:FROM_CURRENCY>{ $SourceCurrency }</ns0:FROM_CURRENCY>
            <ns0:TO_CURRENCY>{ $TargetCurrency }</ns0:TO_CURRENCY>
            <ns0:EXCHANGE_TYPE></ns0:EXCHANGE_TYPE>
            <ns0:EXCHANGE_DATE></ns0:EXCHANGE_DATE>
            <ns0:USER_NAME>{ $UserName }</ns0:USER_NAME>
        </ns0:InputParameters>
};

declare variable $SourceCurrency as xs:string external;
declare variable $TargetCurrency as xs:string external;
declare variable $UserName as xs:string external;

xf:ConsultaTasaCambio_DebitosGTIn($SourceCurrency,
    $TargetCurrency,
    $UserName)
