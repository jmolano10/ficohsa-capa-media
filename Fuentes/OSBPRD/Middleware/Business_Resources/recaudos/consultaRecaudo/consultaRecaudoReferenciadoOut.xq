(:: pragma bea:global-element-parameter parameter="$pagoderecaudoreferenciadoefec_ValidateResponse" element="ns0:Pagoderecaudoreferenciadoefec_ValidateResponse" location="../../pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetallecontratorecaudoResponse" element="ns0:ConsultadetallecontratorecaudoResponse" location="../../contratosConvenios/Resources/XMLSchema_266061745.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoResponse" location="consultaRecaudoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoReferenciadoOut/";

declare function xf:consultaRecaudoReferenciadoOut($pagoderecaudoreferenciadoefec_ValidateResponse as element(ns0:Pagoderecaudoreferenciadoefec_ValidateResponse),
    $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse))
    as element(ns1:consultaRecaudoResponse) {
    	if (fn:string($pagoderecaudoreferenciadoefec_ValidateResponse/Status/successIndicator/text())="Success") then (
	        <ns1:consultaRecaudoResponse>
	            {
	                for $LRAGCLIENTID in $pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/LRAGCLIENTID
	                return
	                    <CONTRACT_ID>{ data($LRAGCLIENTID) }</CONTRACT_ID>
	            }
	            {
	                for $DESCRIPTION in $consultadetallecontratorecaudoResponse/WSCOLLECTIONCONDSType[1]/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType[1]/DESCRIPTION
	                return
	                    <CONTRACT_NAME>{ data($DESCRIPTION) }</CONTRACT_NAME>
	            }
	            {
	                for $LRPAYCODE in $pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/LRPAYCODE
	                return
	                    <DEBTOR_CODE>{ data($LRPAYCODE) }</DEBTOR_CODE>
	            }
	            <BILLS>
	                <BILL_RECORD>
	                    {
	                        for $LRINVOICENO in $pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/gLRINVOICENO/mLRINVOICENO[1]/LRINVOICENO
	                        return
	                            <BILL_NUMBER>{ data($LRINVOICENO) }</BILL_NUMBER>
	                    }
	                    {
	                        for $CURRENCY1 in $pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/CURRENCY1
	                        return
	                            <BILL_CURRENCY>{ data($CURRENCY1) }</BILL_CURRENCY>
	                    }
	                    {
	                        for $LRDUEDATE in $pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/gLRINVOICENO/mLRINVOICENO[1]/LRDUEDATE
	                        return
	                            <BILL_DATE>{ data($LRDUEDATE) }</BILL_DATE>
	                    }
	                    {
	                        for $LRDUEDATE in $pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/gLRINVOICENO/mLRINVOICENO[1]/LRDUEDATE
	                        return
	                            <DUE_DATE>{ data($LRDUEDATE) }</DUE_DATE>
	                    }
	                    {
	                        for $LRAMT in $pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/gLRINVOICENO/mLRINVOICENO[1]/LRAMT
	                        return
	                            <BILL_AMOUNT>{ substring($LRAMT,4) }</BILL_AMOUNT>
	                    }
	                    {
	                        let $NETAMOUNT := fn:string($pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/NETAMOUNT/text())
	                        let $LRAMT := substring(fn:string($pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/gLRINVOICENO/mLRINVOICENO[1]/LRAMT/text()),4)
	                        return
	                            <LATE_FEE>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even((xs:double($NETAMOUNT) - xs:double($LRAMT)),2),"######0.00"),-1) }</LATE_FEE>
	                    }
	                    {
	                        for $NETAMOUNT in $pagoderecaudoreferenciadoefec_ValidateResponse/TELLERType/NETAMOUNT
	                        return
	                            <TOTAL_AMOUNT>{ data($NETAMOUNT) }</TOTAL_AMOUNT>
	                    }
	                </BILL_RECORD>
	            </BILLS>
	        </ns1:consultaRecaudoResponse>
        ) else (
        	<ns1:consultaRecaudoResponse/>
        )
};

declare variable $pagoderecaudoreferenciadoefec_ValidateResponse as element(ns0:Pagoderecaudoreferenciadoefec_ValidateResponse) external;
declare variable $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse) external;

xf:consultaRecaudoReferenciadoOut($pagoderecaudoreferenciadoefec_ValidateResponse,
    $consultadetallecontratorecaudoResponse)