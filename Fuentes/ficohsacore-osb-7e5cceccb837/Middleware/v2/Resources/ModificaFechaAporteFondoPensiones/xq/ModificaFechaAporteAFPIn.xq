(:: pragma bea:global-element-parameter parameter="$modificaFechaAporteFondoPensionesRequest" element="ns0:modificaFechaAporteFondoPensionesRequest" location="../xsd/modificaFechaAporteFondoPensionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/ModificaFechaAporteAFP/xsd/ModificaFechaAporteAFP_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ModificaFechaAporteAFP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/modificaFechaAporteFondoPensionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaFechaAporteFondoPensiones/xq/ModificaFechaAporteAFPIn/";

declare function xf:ModificaFechaAporteAFPIn($modificaFechaAporteFondoPensionesRequest as element(ns0:modificaFechaAporteFondoPensionesRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_TIPO_MONEDA>{ data($modificaFechaAporteFondoPensionesRequest/CURRENCY) }</ns1:PV_TIPO_MONEDA>
            <ns1:PV_CODIGO_DEUDOR>{ data($modificaFechaAporteFondoPensionesRequest/ID) }</ns1:PV_CODIGO_DEUDOR>
            <ns1:PV_NUEVO_DIA>{ xs:date(data($modificaFechaAporteFondoPensionesRequest/NEW_COLLECTION_DATE)) }</ns1:PV_NUEVO_DIA>
        </ns1:InputParameters>
};

declare variable $modificaFechaAporteFondoPensionesRequest as element(ns0:modificaFechaAporteFondoPensionesRequest) external;

xf:ModificaFechaAporteAFPIn($modificaFechaAporteFondoPensionesRequest)
