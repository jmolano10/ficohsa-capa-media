(:: pragma bea:global-element-parameter parameter="$consultaarchdeudoresporcontratoResponse" element="ns1:ConsultaarchdeudoresporcontratoResponse" location="../Resources/XMLSchema_-525487073.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetarchdeudoresokResponse" element="ns1:ConsultadedetarchdeudoresokResponse" location="../Resources/XMLSchema_-525487073.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetarchdeudoreserrorResponse" element="ns1:ConsultadedetarchdeudoreserrorResponse" location="../Resources/XMLSchema_-525487073.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleArchivoDeudoresResponse" location="consultaDetalleArchivoDeudoresTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleArchivoDeudoresTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/archivosConvenios/consultaDetalleArchivoDeudores/consultaDetalleArchivoDeudoresOut/";

declare function xf:consultaDetalleArchivoDeudoresOut($consultaarchdeudoresporcontratoResponse as element(ns1:ConsultaarchdeudoresporcontratoResponse),
    $consultadedetarchdeudoresokResponse as element(ns1:ConsultadedetarchdeudoresokResponse),
    $consultadedetarchdeudoreserrorResponse as element(ns1:ConsultadedetarchdeudoreserrorResponse))
    as element(ns0:consultaDetalleArchivoDeudoresResponse) {
        <ns0:consultaDetalleArchivoDeudoresResponse>
            {
                for $AGRCONTRACTID in $consultaarchdeudoresporcontratoResponse/FICOHNAGFILESTATUSDEBAFFENQType[1]/gFICOHNAGFILESTATUSDEBAFFENQDetailType/mFICOHNAGFILESTATUSDEBAFFENQDetailType[1]/AGRCONTRACTID
                return
                    <CONTRACT_ID>{ data($AGRCONTRACTID) }</CONTRACT_ID>
            }
            {
                for $AGRCONTRACTNAME in $consultaarchdeudoresporcontratoResponse/FICOHNAGFILESTATUSDEBAFFENQType[1]/gFICOHNAGFILESTATUSDEBAFFENQDetailType/mFICOHNAGFILESTATUSDEBAFFENQDetailType[1]/AGRCONTRACTNAME
                return
                    <CONTRACT_NAME>{ data($AGRCONTRACTNAME) }</CONTRACT_NAME>
            }
            {
                for $FILENAME in $consultaarchdeudoresporcontratoResponse/FICOHNAGFILESTATUSDEBAFFENQType[1]/gFICOHNAGFILESTATUSDEBAFFENQDetailType/mFICOHNAGFILESTATUSDEBAFFENQDetailType[1]/FILENAME
                return
                    <FILE_NAME>{ data($FILENAME) }</FILE_NAME>
            }
            {
                for $TOTALBODYLINES in $consultaarchdeudoresporcontratoResponse/FICOHNAGFILESTATUSDEBAFFENQType[1]/gFICOHNAGFILESTATUSDEBAFFENQDetailType/mFICOHNAGFILESTATUSDEBAFFENQDetailType[1]/TOTALBODYLINES
                return
                    <TOTAL_RECORDS>{ data($TOTALBODYLINES) }</TOTAL_RECORDS>
            }
            {
                for $FILESTATUS in $consultaarchdeudoresporcontratoResponse/FICOHNAGFILESTATUSDEBAFFENQType[1]/gFICOHNAGFILESTATUSDEBAFFENQDetailType/mFICOHNAGFILESTATUSDEBAFFENQDetailType[1]/FILESTATUS
                return
                    <FILE_STATUS>{ data($FILESTATUS) }</FILE_STATUS>
            }
            {
                for $PROCESSDATEANDTIME in $consultaarchdeudoresporcontratoResponse/FICOHNAGFILESTATUSDEBAFFENQType[1]/gFICOHNAGFILESTATUSDEBAFFENQDetailType/mFICOHNAGFILESTATUSDEBAFFENQDetailType[1]/PROCESSDATEANDTIME
                return
                    <DATE_TIME>{ data($PROCESSDATEANDTIME) }</DATE_TIME>
            }
            <DETAIL>
                {
                    for $mFICOHNAGDEBAFFFILEPROCESSEDDetailType in $consultadedetarchdeudoresokResponse/FICOHNAGDEBAFFFILEPROCESSEDType[1]/gFICOHNAGDEBAFFFILEPROCESSEDDetailType/mFICOHNAGDEBAFFFILEPROCESSEDDetailType
                    return
                        <DETAIL_RECORD>
                            {
                                for $DEBTORCODE in $mFICOHNAGDEBAFFFILEPROCESSEDDetailType/DEBTORCODE
                                return
                                    <DEBTOR_CODE>{ data($DEBTORCODE) }</DEBTOR_CODE>
                            }
                            {
                                for $DEBTORNAME in $mFICOHNAGDEBAFFFILEPROCESSEDDetailType/DEBTORNAME
                                return
                                    <DEBTOR_NAME>{ data($DEBTORNAME) }</DEBTOR_NAME>
                            }
                            <RECORD_STATUS>PROCESSED</RECORD_STATUS>
                        </DETAIL_RECORD>
                }
                {
                    for $mFICOHNAGDEBAFFFILEUPLOADERRDetailType in $consultadedetarchdeudoreserrorResponse/FICOHNAGDEBAFFFILEUPLOADERRType[1]/gFICOHNAGDEBAFFFILEUPLOADERRDetailType/mFICOHNAGDEBAFFFILEUPLOADERRDetailType
                    return
                        <DETAIL_RECORD>
                            {
                                for $DEBTORCODE in $mFICOHNAGDEBAFFFILEUPLOADERRDetailType/DEBTORCODE
                                return
                                    <DEBTOR_CODE>{ data($DEBTORCODE) }</DEBTOR_CODE>
                            }
                            {
                                for $DEBTORNAME in $mFICOHNAGDEBAFFFILEUPLOADERRDetailType/DEBTORNAME
                                return
                                    <DEBTOR_NAME>{ data($DEBTORNAME) }</DEBTOR_NAME>
                            }
                            {
                                for $STATUSCODE in $mFICOHNAGDEBAFFFILEUPLOADERRDetailType/STATUSCODE
                                return
                                    <RECORD_STATUS>{ data($STATUSCODE) }</RECORD_STATUS>
                            }
                        </DETAIL_RECORD>
                }
            </DETAIL>
        </ns0:consultaDetalleArchivoDeudoresResponse>
};

declare variable $consultaarchdeudoresporcontratoResponse as element(ns1:ConsultaarchdeudoresporcontratoResponse) external;
declare variable $consultadedetarchdeudoresokResponse as element(ns1:ConsultadedetarchdeudoresokResponse) external;
declare variable $consultadedetarchdeudoreserrorResponse as element(ns1:ConsultadedetarchdeudoreserrorResponse) external;

xf:consultaDetalleArchivoDeudoresOut($consultaarchdeudoresporcontratoResponse,
    $consultadedetarchdeudoresokResponse,
    $consultadedetarchdeudoreserrorResponse)