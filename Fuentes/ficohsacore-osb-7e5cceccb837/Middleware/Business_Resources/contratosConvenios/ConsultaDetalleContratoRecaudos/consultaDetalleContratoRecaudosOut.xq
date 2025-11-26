(:: pragma bea:global-element-parameter parameter="$consultadetallecontratorecaudoResponse" element="ns0:ConsultadetallecontratorecaudoResponse" location="../Resources/XMLSchema_266061745.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleContratoRecaudosResponse" location="consultaDetalleContratoRecaudosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/contratosConvenios/ConsultaDetalleContratoRecaudos/consultaDetalleContratoRecaudosOut/";

declare function xf:consultaDetalleContratoRecaudosOut($consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse))
    as element(ns1:consultaDetalleContratoRecaudosResponse) {
        <ns1:consultaDetalleContratoRecaudosResponse>
            {
                for $gWSCOLLECTIONCONDSDetailType in $consultadetallecontratorecaudoResponse/WSCOLLECTIONCONDSType[1]/gWSCOLLECTIONCONDSDetailType
                return
                    <ns1:consultaDetalleContratoRecaudosResponseType>
                        {
                            for $mWSCOLLECTIONCONDSDetailType in $gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType
                            return
                                <ns1:consultaDetalleContratoRecaudosResponseRecordType>
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
                                </ns1:consultaDetalleContratoRecaudosResponseRecordType>
                        }
                    </ns1:consultaDetalleContratoRecaudosResponseType>
            }
        </ns1:consultaDetalleContratoRecaudosResponse>
};

declare variable $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse) external;

xf:consultaDetalleContratoRecaudosOut($consultadetallecontratorecaudoResponse)