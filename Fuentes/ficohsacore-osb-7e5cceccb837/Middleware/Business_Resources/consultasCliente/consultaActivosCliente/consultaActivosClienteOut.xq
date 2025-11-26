(:: pragma bea:global-element-parameter parameter="$ahorroResponse" element="ns0:ConsultadectasahorroporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$corrienteResponse" element="ns0:ConsultactascorrienteporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoResponse" element="ns0:ConsultadecertifdepporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaActivosClienteResponse" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/consultaActivosClienteOut/";

declare function xf:consultaActivosClienteOut($ahorroResponse as element(ns0:ConsultadectasahorroporclienteResponse),
    $corrienteResponse as element(ns0:ConsultactascorrienteporclienteResponse),
    $depositoResponse as element(ns0:ConsultadecertifdepporclienteResponse))
    as element(ns1:consultaActivosClienteResponse) {
        <ns1:consultaActivosClienteResponse>
            <ns1:consultaActivosClienteAhorrosResponseType>
                {
                    for $mFICOLINKSAVINGSACCTDetailType in $ahorroResponse/WSFICOLINKSAVINGSACCTType[1]/gWSFICOLINKSAVINGSACCTDetailType/mWSFICOLINKSAVINGSACCTDetailType
                    return
                        <ns1:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>AHO</ASSET_TYPE>
                            {
                                let $ACCOUNTNUMBER := $mFICOLINKSAVINGSACCTDetailType/ACCOUNTNUMBER/text()
                                let $ALTACCTID := $mFICOLINKSAVINGSACCTDetailType/ALTACCTID/text()
                                return
                                if ( exists($ALTACCTID) ) then (
                                	<ASSET_NUMBER>{ $ALTACCTID }</ASSET_NUMBER>
                                ) else (
                                	<ASSET_NUMBER>{ concat("000000", $ACCOUNTNUMBER) }</ASSET_NUMBER>
                                )                              
                            }
                            {
                                for $ACCOUNTTITLE in $mFICOLINKSAVINGSACCTDetailType/ACCOUNTTITLE
                                return
                                    <ASSET_NAME>{ data($ACCOUNTTITLE) }</ASSET_NAME>
                            }                            
                            {
                                for $CURRENCY in $mFICOLINKSAVINGSACCTDetailType/CURRENCY
                                return
                                    <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY>
                            }
                            {
                                for $TOTALBALANCE in $mFICOLINKSAVINGSACCTDetailType/TOTALBALANCE
                                return
                                    <ASSET_TOTAL_BALANCE>{ data($TOTALBALANCE) }</ASSET_TOTAL_BALANCE>
                            }
                            {
                                for $RESERVEBALANCE in $mFICOLINKSAVINGSACCTDetailType/RESERVEBALANCE
                                return
                                    <ASSET_RESERVE_BALANCE>{ data($RESERVEBALANCE) }</ASSET_RESERVE_BALANCE>
                            }
                            {
                                for $LIENBALANCE in $mFICOLINKSAVINGSACCTDetailType/LIENBALANCE
                                return
                                    <ASSET_LOCKED_BALANCE>{ data($LIENBALANCE) }</ASSET_LOCKED_BALANCE>
                            }
                            {
                                for $BLOCKEDFUNDSPOS in $mFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSPOS,
                                    $BLOCKEDFUNDSATM in $mFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSATM
                                return
                                    <ASSET_VISA_FLOATING_BALANCE>
                                        {
                                            if ((string(number($BLOCKEDFUNDSPOS)) = "NaN" and string(number($BLOCKEDFUNDSATM)) = "NaN")) then
                                                (0)
                                            else 
                                                if (string(number($BLOCKEDFUNDSPOS)) != "NaN" and string(number($BLOCKEDFUNDSATM)) != "NaN") then (
                                                number($BLOCKEDFUNDSPOS) + number($BLOCKEDFUNDSATM)
                                                ) else if (string(number($BLOCKEDFUNDSPOS)) = "NaN") then (
                                                data($BLOCKEDFUNDSATM)
                                                ) else (
                                                data($BLOCKEDFUNDSPOS)
                                                )
                                        }
									</ASSET_VISA_FLOATING_BALANCE>
                            }
                            {
                                for $AVAILABLEBAL in $mFICOLINKSAVINGSACCTDetailType/AVAILABLEBAL
                                return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AVAILABLEBAL) }</ASSET_AVAILABLE_BALANCE>
                            }
                        </ns1:consultaActivosClienteResponseRecordType>
                }
            </ns1:consultaActivosClienteAhorrosResponseType>
            <ns1:consultaActivosClienteCorrienteResponseType>
                {
                    for $mFICOLINKCURRENTACCTDetailType in $corrienteResponse/WSFICOLINKCURRENTACCTType[1]/gWSFICOLINKCURRENTACCTDetailType/mWSFICOLINKCURRENTACCTDetailType
                    return
                        <ns1:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>CHQ</ASSET_TYPE>
                            {
                                let $ACCOUNTNUMBER := $mFICOLINKCURRENTACCTDetailType/ACCOUNTNUMBER/text()
                                let $ALTACCTID := $mFICOLINKCURRENTACCTDetailType/ALTACCTID/text()
                                return
                                if ( exists($ALTACCTID) ) then (
                                	<ASSET_NUMBER>{ $ALTACCTID }</ASSET_NUMBER>
                                ) else (
                                	<ASSET_NUMBER>{ concat("000000", $ACCOUNTNUMBER) }</ASSET_NUMBER>
                                )                              
                            }
                            {
                                for $ACCOUNTNAME in $mFICOLINKCURRENTACCTDetailType/ACCOUNTNAME
                                return
                                    <ASSET_NAME>{ data($ACCOUNTNAME) }</ASSET_NAME>
                            }
                            {
                                for $CURRENCY in $mFICOLINKCURRENTACCTDetailType/CURRENCY
                                return
                                    <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY>
                            }
                            {
                                for $TOTALBALANCE in $mFICOLINKCURRENTACCTDetailType/TOTALBALANCE
                                return
                                    <ASSET_TOTAL_BALANCE>{ data($TOTALBALANCE) }</ASSET_TOTAL_BALANCE>
                            }
                            {
                                for $RESERVEBALANCE in $mFICOLINKCURRENTACCTDetailType/RESERVEBALANCE
                                return
                                    <ASSET_RESERVE_BALANCE>{ data($RESERVEBALANCE) }</ASSET_RESERVE_BALANCE>
                            }
                            {
                                for $LIENBALANCE in $mFICOLINKCURRENTACCTDetailType/LIENBALANCE
                                return
                                    <ASSET_LOCKED_BALANCE>{ data($LIENBALANCE) }</ASSET_LOCKED_BALANCE>
                            }
                            {
                                for $BLOCKEDFUNDSPOS in $mFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSPOS,
                                    $BLOCKEDFUNDSATM in $mFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSATM
                                return
                                    <ASSET_VISA_FLOATING_BALANCE>
                                        {
                                            if ((string(number($BLOCKEDFUNDSPOS)) = "NaN" and string(number($BLOCKEDFUNDSATM)) = "NaN")) then
                                                (0)
                                            else 
                                                if (string(number($BLOCKEDFUNDSPOS)) != "NaN" and string(number($BLOCKEDFUNDSATM)) != "NaN") then (
                                                number($BLOCKEDFUNDSPOS) + number($BLOCKEDFUNDSATM)
                                                ) else if (string(number($BLOCKEDFUNDSPOS)) = "NaN") then (
                                                data($BLOCKEDFUNDSATM)
                                                ) else (
                                                data($BLOCKEDFUNDSPOS)
                                                )
                                        }
									</ASSET_VISA_FLOATING_BALANCE>
                            }
                            {
                                for $AVAILABLEBALANCE in $mFICOLINKCURRENTACCTDetailType/AVAILABLEBALANCE
                                return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AVAILABLEBALANCE) }</ASSET_AVAILABLE_BALANCE>
                            }
                        </ns1:consultaActivosClienteResponseRecordType>
                }
            </ns1:consultaActivosClienteCorrienteResponseType>
            <ns1:consultaActivosClienteDepositosResponseType>
                {
                    for $mWSFICOTERMDEPOSITDetailType in $depositoResponse/WSFICOTERMDEPOSITType[1]/gWSFICOTERMDEPOSITDetailType/mWSFICOTERMDEPOSITDetailType
                    return
                        <ns1:consultaActivosClienteResponseRecordType>
                            <ASSET_TYPE>DEP</ASSET_TYPE>
                            {
                                let $DEPOSITNUMBER := $mWSFICOTERMDEPOSITDetailType/DEPOSITNUMBER/text()
                                let $ALTACCTID := $mWSFICOTERMDEPOSITDetailType/ALTACCTID/text()
                                return
                                if ( exists($ALTACCTID) ) then (
                                	<ASSET_NUMBER>{ $ALTACCTID }</ASSET_NUMBER>
                                ) else (
                                	<ASSET_NUMBER>{ concat("000000", $DEPOSITNUMBER) }</ASSET_NUMBER>
                                )                              
                            }  
                            {
                                for $CUSTOMERNAME in $mWSFICOTERMDEPOSITDetailType/CUSTOMERNAME
                                return
                                    <ASSET_NAME>{ data($CUSTOMERNAME) }</ASSET_NAME>
                            }                                                      
                            {
                                for $CURRENCY in $mWSFICOTERMDEPOSITDetailType/CURRENCY
                                return
                                    <ASSET_CURRENCY>{ data($CURRENCY) }</ASSET_CURRENCY>
                            }
                            {
                                for $AMOUNT in $mWSFICOTERMDEPOSITDetailType/AMOUNT
                                return
                                    <ASSET_TOTAL_BALANCE>{ data($AMOUNT) }</ASSET_TOTAL_BALANCE>
                            }
                            {
                                for $AMOUNT in $mWSFICOTERMDEPOSITDetailType/AMOUNT
                                return
                                    <ASSET_AVAILABLE_BALANCE>{ data($AMOUNT) }</ASSET_AVAILABLE_BALANCE>
                            }
                        </ns1:consultaActivosClienteResponseRecordType>
                }
            </ns1:consultaActivosClienteDepositosResponseType>
        </ns1:consultaActivosClienteResponse>
};

declare variable $ahorroResponse as element(ns0:ConsultadectasahorroporclienteResponse) external;
declare variable $corrienteResponse as element(ns0:ConsultactascorrienteporclienteResponse) external;
declare variable $depositoResponse as element(ns0:ConsultadecertifdepporclienteResponse) external;

xf:consultaActivosClienteOut($ahorroResponse,
    $corrienteResponse,
    $depositoResponse)