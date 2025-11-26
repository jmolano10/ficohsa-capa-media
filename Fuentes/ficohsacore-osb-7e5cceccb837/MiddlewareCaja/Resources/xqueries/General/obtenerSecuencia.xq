(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/General/obtenerSecuencia/obtenerSecuencia_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSecuencia";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/General/obtenerSecuencia/";

declare function xf:obtenerSecuencia($sequenceType as xs:string,
    $seed as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TIPO_SECUENCIA>{ $sequenceType }</ns0:PV_TIPO_SECUENCIA>
            <ns0:PV_SEMILLA>{ $seed }</ns0:PV_SEMILLA>
        </ns0:InputParameters>
};

declare variable $sequenceType as xs:string external;
declare variable $seed as xs:string external;

xf:obtenerSecuencia($sequenceType,
    $seed)