xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/DataWarehouse/consultaClienteBancarizacionDwh/xsd/consultaClienteBancarizacionDwh_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClienteBancarizacionDwh";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteBancarizacion/xq/ConsultaClienteBancarizacionDwhOut/";

declare function xf:ConsultaClienteBancarizacionDwhOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $Msj in $outputParameters1/ns1:Msj
                return
                    <successIndicator>{ data($Msj) }</successIndicator>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ConsultaClienteBancarizacionDwhOut($outputParameters1)