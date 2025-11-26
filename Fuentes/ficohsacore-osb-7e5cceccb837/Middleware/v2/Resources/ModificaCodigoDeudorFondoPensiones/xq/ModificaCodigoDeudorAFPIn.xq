(:: pragma bea:global-element-parameter parameter="$modificaCodigoDeudorFondoPensionesRequest" element="ns1:modificaCodigoDeudorFondoPensionesRequest" location="../xsd/modificaCodigoDeudorFondoPensionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/ModificaCodigoDeudorAFP/xsd/ModificaCodigoDeudorAFP_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/modificaCodigoDeudorFondoPensionesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ModificaCodigoDeudorAFP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaCodigoDeudorFondoPensiones/xq/ModificaCodigoDeudorAFPIn/";

declare function xf:ModificaCodigoDeudorAFPIn($modificaCodigoDeudorFondoPensionesRequest as element(ns1:modificaCodigoDeudorFondoPensionesRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_DEUDOR_NUEVO>{ data($modificaCodigoDeudorFondoPensionesRequest/NEW_ID) }</ns0:PV_CODIGO_DEUDOR_NUEVO>
            <ns0:PV_CODIGO_DEUDOR>{ data($modificaCodigoDeudorFondoPensionesRequest/ID) }</ns0:PV_CODIGO_DEUDOR>
            <ns0:PV_CUENTA_AHORRO>{ data($modificaCodigoDeudorFondoPensionesRequest/ACCOUNT) }</ns0:PV_CUENTA_AHORRO>
        </ns0:InputParameters>
};

declare variable $modificaCodigoDeudorFondoPensionesRequest as element(ns1:modificaCodigoDeudorFondoPensionesRequest) external;

xf:ModificaCodigoDeudorAFPIn($modificaCodigoDeudorFondoPensionesRequest)
