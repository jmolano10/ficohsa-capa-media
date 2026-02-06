xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/RegistroTransaccionesBALCAM/xsd/registroTransaccionesBalcam_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroTransaccionesBalcam";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistroTransaccionesBALCAM/xq/registroTransaccionesBALCAMIn/";

declare function xf:registroTransaccionesBALCAMIn($transactions as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SET_TRANSACCIONES>{ $transactions }</ns0:PV_SET_TRANSACCIONES>
        </ns0:InputParameters>
};

declare variable $transactions as xs:string external;

xf:registroTransaccionesBALCAMIn($transactions)