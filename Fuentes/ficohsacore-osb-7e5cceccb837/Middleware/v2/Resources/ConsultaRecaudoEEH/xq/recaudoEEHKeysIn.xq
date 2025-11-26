(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/RecaudoEEHKeys/xsd/recaudoEEHKeys_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/TERCEROS/OSB_K_OPER_ASYNC/CV_P_ENVIAR_PARAMETROS/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoEEH/xq/recaudoEEHKeysIn/";

declare function xf:recaudoEEHKeysIn($uuiddb as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pv_Solicitud>{ $uuiddb }</ns0:Pv_Solicitud>
        </ns0:InputParameters>
};

declare variable $uuiddb as xs:string external;

xf:recaudoEEHKeysIn($uuiddb)