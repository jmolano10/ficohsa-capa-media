(:: pragma bea:global-element-parameter parameter="$consultadetipodeIdentJuridicaResponse1" element="ns0:ConsultadetipodeIdentJuridicaResponse" location="../Resources/XMLSchema_-125070348.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultasTipoIdentidadResponse" location="../consultasTipoIdentidadTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasTipoIdentidadTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasTipoIdentidad/consultaTipoIdentidadJuridica/ConsultaTipoIdentidadJuridicaOut/";

declare function xf:ConsultaTipoIdentidadJuridicaOut($consultadetipodeIdentJuridicaResponse1 as element(ns0:ConsultadetipodeIdentJuridicaResponse),
    $customer_type as xs:string)
    as element(ns1:consultasTipoIdentidadResponse) {
        <ns1:consultasTipoIdentidadResponse>
            <ns1:consultasTipoIdentidadResponseType>
                {
                    for $mWSFICOHCORPORATELEGALDOCNAMEDetailType in $consultadetipodeIdentJuridicaResponse1/WSFICOHCORPORATELEGALDOCNAMEType[1]/gWSFICOHCORPORATELEGALDOCNAMEDetailType/mWSFICOHCORPORATELEGALDOCNAMEDetailType
                    return
                        <ns1:consultasTipoIdentidadResponseRecordType>
                            <ID_TYPE>{ data($mWSFICOHCORPORATELEGALDOCNAMEDetailType/ID) }</ID_TYPE>
                            <CUSTOMER_TYPE>{ $customer_type }</CUSTOMER_TYPE>
                            <ID_NAME>{ data($mWSFICOHCORPORATELEGALDOCNAMEDetailType/LEGALDOCDESC) }</ID_NAME>
                        </ns1:consultasTipoIdentidadResponseRecordType>
                }
            </ns1:consultasTipoIdentidadResponseType>
        </ns1:consultasTipoIdentidadResponse>
};

declare variable $consultadetipodeIdentJuridicaResponse1 as element(ns0:ConsultadetipodeIdentJuridicaResponse) external;
declare variable $customer_type as xs:string external;

xf:ConsultaTipoIdentidadJuridicaOut($consultadetipodeIdentJuridicaResponse1,
    $customer_type)