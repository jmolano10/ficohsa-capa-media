(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse" element="ns0:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaFondoPensiones/xsd/consultaFondoPensiones_sp.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFondoPensiones";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondoPensiones/xq/consultaFondoPensionesIn/";

declare function xf:consultaFondoPensionesIn($consultadeclienteResponse as element(ns0:ConsultadeclienteResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $LEGALID in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALID
                return
                    <ns1:PV_IDENTIFICACION>{ data($LEGALID) }</ns1:PV_IDENTIFICACION>
            }
        </ns1:InputParameters>
};

declare variable $consultadeclienteResponse as element(ns0:ConsultadeclienteResponse) external;

xf:consultaFondoPensionesIn($consultadeclienteResponse)