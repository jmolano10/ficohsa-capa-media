(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CNV/transformarReciboRecaudo/xsd/transformarReciboRecaudo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transformarReciboRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/transformarReciboRecaudoIn/";

declare function xf:transformarReciboRecaudoIn($username as xs:string,
    $dealslip as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_USUARIO>{ $username }</ns0:PV_USUARIO>
            <ns0:PV_DEALSLIP>{ $dealslip }</ns0:PV_DEALSLIP>
        </ns0:InputParameters>
};

declare variable $username as xs:string external;
declare variable $dealslip as xs:string external;

xf:transformarReciboRecaudoIn($username,
    $dealslip)