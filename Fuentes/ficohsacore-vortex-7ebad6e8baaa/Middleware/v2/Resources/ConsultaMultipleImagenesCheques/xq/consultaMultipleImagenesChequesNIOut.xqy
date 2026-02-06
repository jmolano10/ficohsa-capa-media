xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaImagenesChequesResponse" element="ns1:ConsultaImagenesChequesResponse" location="../../../BusinessServices/ConsultaMultipleImagenesCheques/wsdl/ConsultaMultipleImagenesCheques.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaMultipleImagenesChequesResponse" location="../xsd/procesoImagenesChequesTypes.xsd" ::)

declare namespace ns1 = "http://schemas.xmlsoap.org/soap/http";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleImagenesCheques/xq/consultaMultipleImagenesChequesNIOut/";

declare function xf:consultaMultipleImagenesChequesNIOut($consultaImagenesChequesResponse as element(ns1:ConsultaImagenesChequesResponse))
    as element(ns0:consultaMultipleImagenesChequesResponse) {
        <ns0:consultaMultipleImagenesChequesResponse>
            {
                for $ACCOUNT_NUMBER in $consultaImagenesChequesResponse/ns1:ConsultaImagenesChequesResult/ns1:ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            }
            <TOTAL_CHEQUES_FOUND>1</TOTAL_CHEQUES_FOUND>
			<TOTAL_CHEQUES_RETURNED>1</TOTAL_CHEQUES_RETURNED>
			<INITIAL_POSITION_RETURNED>1</INITIAL_POSITION_RETURNED>
			<LAST_POSITION_RETURNED>1</LAST_POSITION_RETURNED>
	        <ns0:consultaMultipleImagenesChequesResponseType>
                {
                    for $CHEQUE_NUMBER in $consultaImagenesChequesResponse/ns1:ConsultaImagenesChequesResult/ns1:CHEQUE_NUMBER
                    return
                        <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
                }
                {
                    for $TRANSACTION_DATE in $consultaImagenesChequesResponse/ns1:ConsultaImagenesChequesResult/ns1:TRANSACTION_DATE
                    return
                        <TRANSACTION_DATE>{ data($TRANSACTION_DATE) }</TRANSACTION_DATE>
                }
                {
                    for $CHEQUE_IMAGE_FRONT in $consultaImagenesChequesResponse/ns1:ConsultaImagenesChequesResult/ns1:CHEQUE_IMAGE_FRONT
                    return
                        <CHEQUE_IMAGE_FRONT>{ data($CHEQUE_IMAGE_FRONT) }</CHEQUE_IMAGE_FRONT>
                }
                {
                    for $CHEQUE_IMAGE_BACK in $consultaImagenesChequesResponse/ns1:ConsultaImagenesChequesResult/ns1:CHEQUE_IMAGE_BACK
                    return
                        <CHEQUE_IMAGE_BACK>{ data($CHEQUE_IMAGE_BACK) }</CHEQUE_IMAGE_BACK>
                }
                {
                    for $FILE_EXTENSION in $consultaImagenesChequesResponse/ns1:ConsultaImagenesChequesResult/ns1:FILE_EXTENSION
                    return
                        <FILE_EXTENSION>{ data($FILE_EXTENSION) }</FILE_EXTENSION>
                }
            </ns0:consultaMultipleImagenesChequesResponseType>
        </ns0:consultaMultipleImagenesChequesResponse>
};

declare variable $consultaImagenesChequesResponse as element(ns1:ConsultaImagenesChequesResponse) external;

xf:consultaMultipleImagenesChequesNIOut($consultaImagenesChequesResponse)