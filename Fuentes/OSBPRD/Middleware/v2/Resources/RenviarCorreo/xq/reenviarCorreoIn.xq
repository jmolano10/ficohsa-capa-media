(:: pragma bea:global-element-parameter parameter="$renviarCorreo" element="ns0:renviarCorreo" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/EnvioCorreoLauKey/renviarCorreo/xsd/renviarCorreo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/renviarCorreo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RenviarCorreo/xq/reenviarCorreo/";

declare function xf:reenviarCorreo($renviarCorreo as element(ns0:renviarCorreo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ID_SENT_EMAIL>{ data($renviarCorreo/ID_SENT_EMAIL) }</ns1:ID_SENT_EMAIL>
        </ns1:InputParameters>
};

declare variable $renviarCorreo as element(ns0:renviarCorreo) external;

xf:reenviarCorreo($renviarCorreo)