(:: pragma bea:global-element-parameter parameter="$consultadetipodeIdentNaturalResponse1" element="ns0:ConsultadetipodeIdentNaturalResponse" location="../Resources/XMLSchema_-125070348.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultasTipoIdentidadResponse" location="../consultasTipoIdentidadTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasTipoIdentidadTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasTipoIdentidad/consultaTipoIdentidadNatural/ConsultaTipoIdentidadNaturalOut/";

declare function xf:ConsultaTipoIdentidadNaturalOut($consultadetipodeIdentNaturalResponse1 as element(ns0:ConsultadetipodeIdentNaturalResponse),
    $customer_type as xs:string)
    as element(ns1:consultasTipoIdentidadResponse) {
        <ns1:consultasTipoIdentidadResponse>
            <ns1:consultasTipoIdentidadResponseType>
                {
                    for $mWSFICOHINDIVIDUALLEGALDOCNAMEDetailType in $consultadetipodeIdentNaturalResponse1/WSFICOHINDIVIDUALLEGALDOCNAMEType[1]/gWSFICOHINDIVIDUALLEGALDOCNAMEDetailType/mWSFICOHINDIVIDUALLEGALDOCNAMEDetailType
                    return
                        <ns1:consultasTipoIdentidadResponseRecordType>
                            <ID_TYPE>{ data($mWSFICOHINDIVIDUALLEGALDOCNAMEDetailType/ID) }</ID_TYPE>
                            <CUSTOMER_TYPE>{ $customer_type }</CUSTOMER_TYPE>
                            <ID_NAME>{ data($mWSFICOHINDIVIDUALLEGALDOCNAMEDetailType/LEGALDOCDESC) }</ID_NAME>
                        </ns1:consultasTipoIdentidadResponseRecordType>
                }
            </ns1:consultasTipoIdentidadResponseType>
        </ns1:consultasTipoIdentidadResponse>
};

declare variable $consultadetipodeIdentNaturalResponse1 as element(ns0:ConsultadetipodeIdentNaturalResponse) external;
declare variable $customer_type as xs:string external;

xf:ConsultaTipoIdentidadNaturalOut($consultadetipodeIdentNaturalResponse1,
    $customer_type)