(:: pragma bea:global-element-parameter parameter="$sjConsultaTipoTarjeta1" element="ns1:sjConsultaTipoTarjeta" location="../xsd/sjConsultaTipoTarjeta.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../ABK/consultarBinesTC/xsd/consultarBinesTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjeta";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarBines";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/xq/sjConsultaBinesTCIn/";

declare function xf:sjConsultaBinesTCIn($sjConsultaTipoTarjeta1 as element(ns1:sjConsultaTipoTarjeta))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_BIN>{ fn:string($sjConsultaTipoTarjeta1/ns1:BIN_NUMBER/text()) }</ns0:PV_BIN>
        </ns0:InputParameters>
};

declare variable $sjConsultaTipoTarjeta1 as element(ns1:sjConsultaTipoTarjeta) external;

xf:sjConsultaBinesTCIn($sjConsultaTipoTarjeta1)