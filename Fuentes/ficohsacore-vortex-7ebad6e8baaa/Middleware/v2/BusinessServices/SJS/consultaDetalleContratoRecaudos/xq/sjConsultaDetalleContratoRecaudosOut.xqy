xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetallecontratorecaudoResponse" element="ns0:ConsultadetallecontratorecaudoResponse" location="../../../../../Business_Resources/contratosConvenios/Resources/XMLSchema_266061745.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaDetalleContratoRecaudosResponse" location="../xsd/sjConsultaDetalleContratoRecaudosTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaDetalleContratoRecaudos/xq/sjConsultaDetalleContratoRecaudosOut/";

declare function xf:sjConsultaDetalleContratoRecaudosOut($consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse))
    as element(ns1:sjConsultaDetalleContratoRecaudosResponse) {
        <ns1:sjConsultaDetalleContratoRecaudosResponse>
            <RESPONSE_CODE>{ data($consultadetallecontratorecaudoResponse/Status/successIndicator) }</RESPONSE_CODE>
            {
                let $result :=
                    for $messages in $consultadetallecontratorecaudoResponse/Status/messages
                    return
                        <RESPONSE_MESSAGE>{ data($messages) }</RESPONSE_MESSAGE>
                return
                    $result[1]
            }
            {
                for $gWSCOLLECTIONCONDSDetailType in $consultadetallecontratorecaudoResponse/WSCOLLECTIONCONDSType[1]/gWSCOLLECTIONCONDSDetailType
                return
                    <ns1:sjConsultaDetalleContratoRecaudosResponseType>
                        {
                            for $mWSCOLLECTIONCONDSDetailType in $gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType
                            return
                                <ns1:sjConsultaDetalleContratoRecaudosResponseRecordType>
                                    {
                                        for $ID in $mWSCOLLECTIONCONDSDetailType/ID
                                        return
                                            <CONTRACT_ID>{ data($ID) }</CONTRACT_ID>
                                    }
                                    {
                                        for $DESCRIPTION in $mWSCOLLECTIONCONDSDetailType/DESCRIPTION
                                        return
                                            <CONTRACT_NAME>{ data($DESCRIPTION) }</CONTRACT_NAME>
                                    }
                                    {
                                        for $CUSTOMERNO in $mWSCOLLECTIONCONDSDetailType/CUSTOMERNO
                                        return
                                            <CUSTOMER_ID>{ data($CUSTOMERNO) }</CUSTOMER_ID>
                                    }
                                    {
                                        for $INFOEXCHANGETYPE in $mWSCOLLECTIONCONDSDetailType/INFOEXCHANGETYPE
                                        return
                                            <INFO_EXCHANGE_TYPE>{ data($INFOEXCHANGETYPE) }</INFO_EXCHANGE_TYPE>
                                    }
                                    {
                                        for $COLLECTIONTYPE in $mWSCOLLECTIONCONDSDetailType/COLLECTIONTYPE
                                        return
                                            <COLLECTION_TYPE>{ data($COLLECTIONTYPE) }</COLLECTION_TYPE>
                                    }
									<ALLOWED_BRANCHES>
                                        {
                                            for $ALLOWEDBRANCHE in fn:tokenize($mWSCOLLECTIONCONDSDetailType/ALLOWEDBRANCHES, "\|\|")
                                            return
                                            	if(fn:string($ALLOWEDBRANCHE) != "") then (
                                                	<BRANCH_CODE>{ $ALLOWEDBRANCHE }</BRANCH_CODE>
                                                ) else ()
                                        }
                                    </ALLOWED_BRANCHES>
                                    {
                                        for $PAYMENTVALUECHECK in $mWSCOLLECTIONCONDSDetailType/PAYMENTVALUECHECK
                                        return
                                            <PAYMENT_VALUE_CHECK>{ data($PAYMENTVALUECHECK) }</PAYMENT_VALUE_CHECK>
                                    }
                                    <PAYMENT_METHODS>
                                        {
                                            for $PAYMENT_METHOD in fn:tokenize($mWSCOLLECTIONCONDSDetailType/PAYMENTMETHOD, "\|\|")
                                            return
                                            	if(fn:string($PAYMENT_METHOD) != "") then (
                                                	<PAYMENT_METHOD>{ $PAYMENT_METHOD }</PAYMENT_METHOD>
                                                ) else ()
                                        }
                                    </PAYMENT_METHODS>  
                                    {
                                        for $PAYOLDBILLFIRST in $mWSCOLLECTIONCONDSDetailType/PAYOLDBILLFIRST
                                        return
                                            <PAY_OLD_BILL_FIRST>{ data($PAYOLDBILLFIRST) }</PAY_OLD_BILL_FIRST>
                                    }
                                    {
                                        for $DUEDATECHECK in $mWSCOLLECTIONCONDSDetailType/DUEDATECHECK
                                        return
                                            <DUE_DATE_CHECK>{ data($DUEDATECHECK) }</DUE_DATE_CHECK>
                                    }
                                    {
                                        for $PENALTYTYPE in $mWSCOLLECTIONCONDSDetailType/PENALTYTYPE
                                        return
                                            <PENALTY_TYPE>{ data($PENALTYTYPE) }</PENALTY_TYPE>
                                    }
                                    {
                                        for $MULTICCYCHECK in $mWSCOLLECTIONCONDSDetailType/MULTICCYCHECK
                                        return
                                            <MULTI_CCY_CHECK>{ data($MULTICCYCHECK) }</MULTI_CCY_CHECK>
                                    }
                                    <CONTRACT_ACCOUNTS>
                                    {
                                    	let $currencies := tokenize($mWSCOLLECTIONCONDSDetailType/ACCOUNTCCY,"\|\|")
                                    	let $account := tokenize($mWSCOLLECTIONCONDSDetailType/COLLACCOUNT,"\|\|")
                                    	for $currency at $i in $currencies
                                    	return
                                   		<CONTRACT_ACCOUNT>
                                    			<CURRENCY>{ $currencies[$i] }</CURRENCY>
                                    			<ACCOUNT>{ $account[$i] }</ACCOUNT>
                                   		</CONTRACT_ACCOUNT>
                                    }
                                    </CONTRACT_ACCOUNTS>
                                </ns1:sjConsultaDetalleContratoRecaudosResponseRecordType>
                        }
                    </ns1:sjConsultaDetalleContratoRecaudosResponseType>
            }
        </ns1:sjConsultaDetalleContratoRecaudosResponse>
};

declare variable $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse) external;

xf:sjConsultaDetalleContratoRecaudosOut($consultadetallecontratorecaudoResponse)