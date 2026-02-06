xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadechequeconfirmadoResponse1" element="ns0:ConsultadechequeconfirmadoResponse" location="../Resources/XMLSchema_-1265051491.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaChequeConfirmadoResponse" location="consultaChequeConfirmadoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequeConfirmadoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaChequeConfirmado/consultaChequeConfirmadoOut/";

declare function xf:consultaChequeConfirmadoOut($consultadechequeconfirmadoResponse1 as element(ns0:ConsultadechequeconfirmadoResponse))
    as element(ns1:consultaChequeConfirmadoResponse) {
        <ns1:consultaChequeConfirmadoResponse>
            {
            	if ( $consultadechequeconfirmadoResponse1/Status/successIndicator/text() = "Success" and empty($consultadechequeconfirmadoResponse1/WSLATAMAGCHEQUECONFIRMBROWENQType[1]/ZERORECORDS/text())) then (
		            <ns1:consultaChequeConfirmadoResponseType>
		                {
		                    for $mWSLATAMAGCHEQUECONFIRMBROWENQDetailType in $consultadechequeconfirmadoResponse1/WSLATAMAGCHEQUECONFIRMBROWENQType[1]/gWSLATAMAGCHEQUECONFIRMBROWENQDetailType/mWSLATAMAGCHEQUECONFIRMBROWENQDetailType
		                    return
		                        <ns1:consultaChequeConfirmadoResponseRecordType>
		                            <ACCOUNT_NUMBER>{ data($mWSLATAMAGCHEQUECONFIRMBROWENQDetailType/CHQACCOUNT) }</ACCOUNT_NUMBER>
		                            <CHEQUE_NUMBER>{ data($mWSLATAMAGCHEQUECONFIRMBROWENQDetailType/CHEQUENO) }</CHEQUE_NUMBER>
		                            <BENEFICIARY_NAME>{ data($mWSLATAMAGCHEQUECONFIRMBROWENQDetailType/BENEFICIARYNAME) }</BENEFICIARY_NAME>
		                            <RESERVE_DATE>{ data($mWSLATAMAGCHEQUECONFIRMBROWENQDetailType/ISSUINGDATE) }</RESERVE_DATE>
		                            <AMOUNT>{ data($mWSLATAMAGCHEQUECONFIRMBROWENQDetailType/AMOUNT) }</AMOUNT>
		                            <RESERVE_FUNDS_YES_NO>{ data($mWSLATAMAGCHEQUECONFIRMBROWENQDetailType/RESERVEFUNDSYN) }</RESERVE_FUNDS_YES_NO>
		                        </ns1:consultaChequeConfirmadoResponseRecordType>
		                }
		            </ns1:consultaChequeConfirmadoResponseType>
				) else ()
			}
        </ns1:consultaChequeConfirmadoResponse>
};

declare variable $consultadechequeconfirmadoResponse1 as element(ns0:ConsultadechequeconfirmadoResponse) external;

xf:consultaChequeConfirmadoOut($consultadechequeconfirmadoResponse1)