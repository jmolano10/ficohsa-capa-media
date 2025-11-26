(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/obtenerInformacionConvenio/xsd/ObtenerInfomacionConvenio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerInfomacionConvenio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/ObtenerInformacionConvenio/";

declare function xf:ObtenerInformacionConvenio($codContrato as xs:string,
    $codPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_PAIS>{ $codPais }</ns0:PV_PAIS>
            <ns0:PV_CONTRATO>{ $codContrato }</ns0:PV_CONTRATO>
        </ns0:InputParameters>
};

declare variable $codContrato as xs:string external;
declare variable $codPais as xs:string external;

xf:ObtenerInformacionConvenio($codContrato,
    $codPais)