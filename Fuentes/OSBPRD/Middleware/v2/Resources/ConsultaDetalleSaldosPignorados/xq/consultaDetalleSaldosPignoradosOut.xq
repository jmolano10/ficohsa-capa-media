xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadebloqueosporTDResponse" element="ns0:ConsultadebloqueosporTDResponse" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleSaldosPignoradosResponse" location="../xsd/consultaDetalleSaldosPignoradosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleSaldosPignorados/xq/consultaDetalleSaldosPignoradosOut/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleSaldosPignoradosTypes";

declare function xf:consultaDetalleSaldosPignoradosOut($consultadebloqueosporTDResponse as element(ns0:ConsultadebloqueosporTDResponse))
    as element(ns1:consultaDetalleSaldosPignoradosResponse) {
    <ns1:consultaDetalleSaldosPignoradosResponse>
        	{
            	if ( $consultadebloqueosporTDResponse/Status/successIndicator/text() = "Success" and empty($consultadebloqueosporTDResponse/WSFICOECUSTPOSVISATXNSType[1]/ZERORECORDS/text())) then (
		            <ACCOUNT_NAME>{ data($consultadebloqueosporTDResponse/WSFICOECUSTPOSVISATXNSType[1]/ACCOUNTNAME) }</ACCOUNT_NAME>,
		            <TOTAL_LOCKED_AMOUNT>{ data($consultadebloqueosporTDResponse/WSFICOECUSTPOSVISATXNSType[1]/TOTAMTBLOCKED) }</TOTAL_LOCKED_AMOUNT>,
		            <ns1:consultaDetalleSaldosPignoradosResponseType>
		                {
		                    for $mWSFICOECUSTPOSVISATXNSDetailType in $consultadebloqueosporTDResponse/WSFICOECUSTPOSVISATXNSType[1]/gWSFICOECUSTPOSVISATXNSDetailType/mWSFICOECUSTPOSVISATXNSDetailType
		                    return
		                        <ns1:consultaDetalleSaldosPignoradosResponseRecordType>
		                            <START_DATE>{ data($mWSFICOECUSTPOSVISATXNSDetailType/TXNDATE) }</START_DATE>
		                            <LIFTING_DATE>{ data($mWSFICOECUSTPOSVISATXNSDetailType/EXPIRYDATE) }</LIFTING_DATE>
		                            <DESCRIPTION>{ data($mWSFICOECUSTPOSVISATXNSDetailType/DESCRIPTION) }</DESCRIPTION>
		                            <AMOUNT>{ data($mWSFICOECUSTPOSVISATXNSDetailType/AMTBLOCKED) }</AMOUNT>
		                            <LOCK_ID>{ data($mWSFICOECUSTPOSVISATXNSDetailType/TRANSACTIONREF) }</LOCK_ID>		                    
		                            
		                        </ns1:consultaDetalleSaldosPignoradosResponseRecordType>
		                }
		            </ns1:consultaDetalleSaldosPignoradosResponseType>
	            ) else ()
            }
        </ns1:consultaDetalleSaldosPignoradosResponse>
};

declare variable $consultadebloqueosporTDResponse as element(ns0:ConsultadebloqueosporTDResponse) external;

xf:consultaDetalleSaldosPignoradosOut($consultadebloqueosporTDResponse)