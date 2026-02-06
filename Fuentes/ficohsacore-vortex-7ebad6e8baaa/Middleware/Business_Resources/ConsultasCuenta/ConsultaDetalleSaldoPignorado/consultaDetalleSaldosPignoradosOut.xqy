xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadebloqueosporTDResponse1" element="ns0:ConsultadebloqueosporTDResponse" location="../../tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleSaldosPignoradosResponse" location="consultaDetalleSaldosPignoradosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleSaldosPignoradosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetalleSaldoPignorado/consultaDetalleSaldosPignoradosOut/";

declare function xf:consultaDetalleSaldosPignoradosOut($consultadebloqueosporTDResponse1 as element(ns0:ConsultadebloqueosporTDResponse))
    as element(ns1:consultaDetalleSaldosPignoradosResponse) {
        <ns1:consultaDetalleSaldosPignoradosResponse>
        	{
            	if ( $consultadebloqueosporTDResponse1/Status/successIndicator/text() = "Success" and empty($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/ZERORECORDS/text())) then (
		            <ACCOUNT_NAME>{ data($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/ACCOUNTNAME) }</ACCOUNT_NAME>,
		            <TOTAL_LOCKED_AMOUNT>{ data($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/TOTAMTBLOCKED) }</TOTAL_LOCKED_AMOUNT>,
		            <ns1:consultaDetalleSaldosPignoradosResponseType>
		                {
		                    for $mWSFICOECUSTPOSVISATXNSDetailType in $consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/gWSFICOECUSTPOSVISATXNSDetailType/mWSFICOECUSTPOSVISATXNSDetailType
		                    return
		                        <ns1:consultaDetalleSaldosPignoradosResponseRecordType>
		                            <START_DATE>{ data($mWSFICOECUSTPOSVISATXNSDetailType/TXNDATE) }</START_DATE>
		                            <LIFTING_DATE></LIFTING_DATE>
		                            <DESCRIPTION>{ data($mWSFICOECUSTPOSVISATXNSDetailType/DESCRIPTION) }</DESCRIPTION>
		                            <AMOUNT>{ data($mWSFICOECUSTPOSVISATXNSDetailType/AMTBLOCKED) }</AMOUNT>
		                        </ns1:consultaDetalleSaldosPignoradosResponseRecordType>
		                }
		            </ns1:consultaDetalleSaldosPignoradosResponseType>
	            ) else ()
            }
        </ns1:consultaDetalleSaldosPignoradosResponse>
};

declare variable $consultadebloqueosporTDResponse1 as element(ns0:ConsultadebloqueosporTDResponse) external;

xf:consultaDetalleSaldosPignoradosOut($consultadebloqueosporTDResponse1)