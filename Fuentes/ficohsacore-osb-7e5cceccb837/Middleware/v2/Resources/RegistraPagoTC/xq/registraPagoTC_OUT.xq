(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/OperacionesACH/RegistraPagoTC/xsd/RegistraPagoTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegistraPagoTC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoTC/xq/registraPagoTC_OUT/";

declare function xf:registraPagoTC_OUT($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $GV_COD_ERROR in $outputParameters1/ns1:GV_COD_ERROR
                return
                    <successIndicator>{ data($GV_COD_ERROR) }</successIndicator>
            }
            {
                for $GV_MENSAJE in $outputParameters1/ns1:GV_MENSAJE
                return
                    <messages>{ data($GV_MENSAJE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:registraPagoTC_OUT($outputParameters1)
