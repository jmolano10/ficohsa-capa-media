(:: pragma bea:global-element-parameter parameter="$consultadebloqueosporTDResponse1" element="ns0:ConsultadebloqueosporTDResponse" location="../Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleBloqueosTDResponse" location="consultaDetalleBloqueosTDTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleBloqueosTDTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDOut/";

declare function xf:consultaDetalleBloqueosTDOut($consultadebloqueosporTDResponse1 as element(ns0:ConsultadebloqueosporTDResponse))
    as element(ns1:consultaDetalleBloqueosTDResponse) {
        <ns1:consultaDetalleBloqueosTDResponse>
            {
            	if ( $consultadebloqueosporTDResponse1/Status/successIndicator/text() = "Success" and empty($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/ZERORECORDS/text())) then (
		            <ACCOUNT_NUMBER>{ data($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/ACCOUNTNUMBER) }</ACCOUNT_NUMBER>,
		            <ACCOUNT_NAME>{ data($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/ACCOUNTNAME) }</ACCOUNT_NAME>,
		            <TOTAL_VISA_LOCKED_AMOUNT>{ data($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/TOTAMTBLOCKED) }</TOTAL_VISA_LOCKED_AMOUNT>,
		            <ns1:consultaDetalleBloqueosTDResponseType>
		                {
		                    for $mWSFICOECUSTPOSVISATXNSDetailType in $consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/gWSFICOECUSTPOSVISATXNSDetailType/mWSFICOECUSTPOSVISATXNSDetailType
		                    return
		                        <ns1:consultaDetalleBloqueosTDResponseRecordType>
		                            <VALUE_DATE>{ data($mWSFICOECUSTPOSVISATXNSDetailType/TXNDATE) }</VALUE_DATE>
		                            <TERMINAL_DESCRIPTION>{ data($mWSFICOECUSTPOSVISATXNSDetailType/TERMINALNAME) }</TERMINAL_DESCRIPTION>
		                            <RELEASE_DATE></RELEASE_DATE>
		                            <CURRENCY>{ data($mWSFICOECUSTPOSVISATXNSDetailType/ACCOUNTCURRENCY) }</CURRENCY>
		                            <ORIGINAL_AMOUNT>{ data($mWSFICOECUSTPOSVISATXNSDetailType/AMTBLOCKED) }</ORIGINAL_AMOUNT>
		                            <BLOCK_STATUS></BLOCK_STATUS>
		                            <CONFIRMED_AMOUNT></CONFIRMED_AMOUNT>
		                        </ns1:consultaDetalleBloqueosTDResponseRecordType>
		                }
		            </ns1:consultaDetalleBloqueosTDResponseType>
	            ) else ()
            }
        </ns1:consultaDetalleBloqueosTDResponse>
};

declare variable $consultadebloqueosporTDResponse1 as element(ns0:ConsultadebloqueosporTDResponse) external;

xf:consultaDetalleBloqueosTDOut($consultadebloqueosporTDResponse1)