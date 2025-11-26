(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DataWarehouse/consultaClienteBancarizacionDwh/xsd/consultaClienteBancarizacionDwh_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClienteBancarizacionDwh";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteBancarizacion/xq/body/";

declare function xf:body($body as element(*))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Archivo_XML>{ $body }</ns0:Archivo_XML>
        </ns0:InputParameters>
};

declare variable $body as element(*) external;

xf:body($body)
