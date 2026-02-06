xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse" element="ns1:ConsultadeclienteResponse" location="../../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../FPC/consultaSituacionFinanciera/xsd/consultaSituacionFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSituacionFinanciera";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/sjConsultaSituacionFinancieraFicopenIn/";

declare function xf:sjConsultaSituacionFinancieraFicopenIn($pais as xs:string,
    $consultadeclienteResponse as element(ns1:ConsultadeclienteResponse))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_BANCO_ORIGEN>{ $pais }</ns0:PV_BANCO_ORIGEN>
            <ns0:PT_NUMERO_IDENTIFICACION>
                {
                    for $mWSCUSTOMERDetailType in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType,
                        $LEGALID in $mWSCUSTOMERDetailType/LEGALID
                    return
                        <ns0:PT_NUMERO_IDENTIFICACION_ITEM>{ data($LEGALID) }</ns0:PT_NUMERO_IDENTIFICACION_ITEM>
                }
            </ns0:PT_NUMERO_IDENTIFICACION>
        </ns0:InputParameters>
};

declare variable $pais as xs:string external;
declare variable $consultadeclienteResponse as element(ns1:ConsultadeclienteResponse) external;

xf:sjConsultaSituacionFinancieraFicopenIn($pais,
    $consultadeclienteResponse)