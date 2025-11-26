(:: pragma bea:global-element-parameter parameter="$consultadetipodeIdentJuridicaResponse" element="ns0:ConsultadetipodeIdentJuridicaResponse" location="../Resources/XMLSchema_-125070348.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetipodeIdentNaturalResponse" element="ns0:ConsultadetipodeIdentNaturalResponse" location="../Resources/XMLSchema_-125070348.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultasTipoIdentidadResponse" location="../consultasTipoIdentidadTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasTipoIdentidadTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasTipoIdentidad/consultaTipoIdentidadMixto/consultaTipoIdentidadMixtoOut/";

declare function xf:consultaTipoIdentidadMixtoOut($consultadetipodeIdentJuridicaResponse as element(ns0:ConsultadetipodeIdentJuridicaResponse),
    $consultadetipodeIdentNaturalResponse as element(ns0:ConsultadetipodeIdentNaturalResponse))
    as element(ns1:consultasTipoIdentidadResponse) {
        <ns1:consultasTipoIdentidadResponse>
            <ns1:consultasTipoIdentidadResponseType>
                {
                    for $mWSFICOHCORPORATELEGALDOCNAMEDetailType in $consultadetipodeIdentJuridicaResponse/WSFICOHCORPORATELEGALDOCNAMEType[1]/gWSFICOHCORPORATELEGALDOCNAMEDetailType/mWSFICOHCORPORATELEGALDOCNAMEDetailType
                    return
                        <ns1:consultasTipoIdentidadResponseRecordType>
                            <ID_TYPE>{ data($mWSFICOHCORPORATELEGALDOCNAMEDetailType/ID) }</ID_TYPE>
                            <CUSTOMER_TYPE>CORPORATE</CUSTOMER_TYPE>
                            <ID_NAME>{ data($mWSFICOHCORPORATELEGALDOCNAMEDetailType/LEGALDOCDESC) }</ID_NAME>
                        </ns1:consultasTipoIdentidadResponseRecordType>
                }
                {
                    for $mWSFICOHINDIVIDUALLEGALDOCNAMEDetailType in $consultadetipodeIdentNaturalResponse/WSFICOHINDIVIDUALLEGALDOCNAMEType[1]/gWSFICOHINDIVIDUALLEGALDOCNAMEDetailType/mWSFICOHINDIVIDUALLEGALDOCNAMEDetailType
                    return
                        <ns1:consultasTipoIdentidadResponseRecordType>
                            <ID_TYPE>{ data($mWSFICOHINDIVIDUALLEGALDOCNAMEDetailType/ID) }</ID_TYPE>
                            <CUSTOMER_TYPE>INDIVIDUAL</CUSTOMER_TYPE>
                            <ID_NAME>{ data($mWSFICOHINDIVIDUALLEGALDOCNAMEDetailType/LEGALDOCDESC) }</ID_NAME>
                        </ns1:consultasTipoIdentidadResponseRecordType>
                }
            </ns1:consultasTipoIdentidadResponseType>
        </ns1:consultasTipoIdentidadResponse>
};

declare variable $consultadetipodeIdentJuridicaResponse as element(ns0:ConsultadetipodeIdentJuridicaResponse) external;
declare variable $consultadetipodeIdentNaturalResponse as element(ns0:ConsultadetipodeIdentNaturalResponse) external;

xf:consultaTipoIdentidadMixtoOut($consultadetipodeIdentJuridicaResponse,
    $consultadetipodeIdentNaturalResponse)