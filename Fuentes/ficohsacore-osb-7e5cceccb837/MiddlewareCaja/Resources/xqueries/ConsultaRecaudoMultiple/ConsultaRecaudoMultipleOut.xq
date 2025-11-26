(:: pragma bea:global-element-parameter parameter="$consultadedetallederecaudoResponse" element="ns0:ConsultadedetallederecaudoResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoMultipleResponse" location="../../xsds/ConsultaRecaudoMultiple/ConsultaRecaudoMultiple.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMultiple/ConsultaRecaudoMultipleOut/";

(: Se encarga de filtrar los recibos de acuerdo a los parámetros de entrada del servicio proxy :)
declare function filtrarRecibos(
	$recibos as item()*,
	$bill_number as xs:string,
	$number_of_bills as xs:string) as item()*{

	if (fn:string($bill_number) = "" and fn:string($number_of_bills) = "") then (
		for $bills in $recibos
		order by $bills/DUEDATE descending
		return
		    <BILL_RECORD>
		        {
		            for $BILLNUMBER in $bills/BILLNUMBER
		            return
		                <BILL_NUMBER>{ data($BILLNUMBER) }</BILL_NUMBER>
		        }
		        {
		            for $BILLCCY in $bills/BILLCCY
		            return
		                <BILL_CURRENCY>{ data($BILLCCY) }</BILL_CURRENCY>
		        }		        
		        {
		            for $BILLDATE in $bills/BILLDATE
		            return
		                <BILL_DATE>{ data($BILLDATE) }</BILL_DATE>
		        }
		        {
		            for $DUEDATE in $bills/DUEDATE
		            return
		                <DUE_DATE>{ data($DUEDATE) }</DUE_DATE>
		        }
		        {
		            for $BILLAMOUNT in $bills/BILLAMOUNT
		            return
		                <BILL_AMOUNT>{ data($BILLAMOUNT) }</BILL_AMOUNT>
		        }
		        {
		            for $LATEFEE in $bills/LATEFEE
		            return
		                <LATE_FEE>{ data($LATEFEE) }</LATE_FEE>
		        }
		        {
		            for $TOTALAMOUNT in $bills/TOTALAMOUNT
		            return
		                <TOTAL_AMOUNT>{ data($TOTALAMOUNT) }</TOTAL_AMOUNT>
		        }
		    </BILL_RECORD>
	) else if (fn:string($bill_number) != "") then (
		for $bills in $recibos
		where $bills/BILLNUMBER = $bill_number
		order by $bills/DUEDATE descending
		return
		    <BILL_RECORD>
		        {
		            for $BILLNUMBER in $bills/BILLNUMBER
		            return
		                <BILL_NUMBER>{ data($BILLNUMBER) }</BILL_NUMBER>
		        }
		        {
		            for $BILLCCY in $bills/BILLCCY
		            return
		                <BILL_CURRENCY>{ data($BILLCCY) }</BILL_CURRENCY>
		        }		        
		        {
		            for $BILLDATE in $bills/BILLDATE
		            return
		                <BILL_DATE>{ data($BILLDATE) }</BILL_DATE>
		        }
		        {
		            for $DUEDATE in $bills/DUEDATE
		            return
		                <DUE_DATE>{ data($DUEDATE) }</DUE_DATE>
		        }
		        {
		            for $BILLAMOUNT in $bills/BILLAMOUNT
		            return
		                <BILL_AMOUNT>{ data($BILLAMOUNT) }</BILL_AMOUNT>
		        }
		        {
		            for $LATEFEE in $bills/LATEFEE
		            return
		                <LATE_FEE>{ data($LATEFEE) }</LATE_FEE>
		        }
		        {
		            for $TOTALAMOUNT in $bills/TOTALAMOUNT
		            return
		                <TOTAL_AMOUNT>{ data($TOTALAMOUNT) }</TOTAL_AMOUNT>
		        }
		    </BILL_RECORD>
	) else (
		for $bills at $i in 
			for $item in $recibos
			order by $item/DUEDATE ascending
			return
				$item
		where $i <= $number_of_bills cast as xs:integer
		return
		    <BILL_RECORD>
		        {
		            for $BILLNUMBER in $bills/BILLNUMBER
		            return
		                <BILL_NUMBER>{ data($BILLNUMBER) }</BILL_NUMBER>
		        }
		        {
		            for $BILLCCY in $bills/BILLCCY
		            return
		                <BILL_CURRENCY>{ data($BILLCCY) }</BILL_CURRENCY>
		        }		        
		        {
		            for $BILLDATE in $bills/BILLDATE
		            return
		                <BILL_DATE>{ data($BILLDATE) }</BILL_DATE>
		        }
		        {
		            for $DUEDATE in $bills/DUEDATE
		            return
		                <DUE_DATE>{ data($DUEDATE) }</DUE_DATE>
		        }
		        {
		            for $BILLAMOUNT in $bills/BILLAMOUNT
		            return
		                <BILL_AMOUNT>{ data($BILLAMOUNT) }</BILL_AMOUNT>
		        }
		        {
		            for $LATEFEE in $bills/LATEFEE
		            return
		                <LATE_FEE>{ data($LATEFEE) }</LATE_FEE>
		        }
		        {
		            for $TOTALAMOUNT in $bills/TOTALAMOUNT
		            return
		                <TOTAL_AMOUNT>{ data($TOTALAMOUNT) }</TOTAL_AMOUNT>
		        }
		    </BILL_RECORD>
	)	
};

declare function xf:ConsultaRecaudoMultipleOut($consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse),
    $number_of_bills as xs:string,
    $bill_number as xs:string,
    $request_currency as xs:string)
    as element(ns1:consultaRecaudoMultipleResponse) {
        <ns1:consultaRecaudoMultipleResponse>
            {
                for $SERVICEID in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICEID
                return
                    <CONTRACT_ID>{ data($SERVICEID) }</CONTRACT_ID>
            }
            {
                for $SERVICENAME in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICENAME
                return
                    <CONTRACT_NAME>{ data($SERVICENAME) }</CONTRACT_NAME>
            }
            {
                for $DEBTORCODE in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORCODE
                return
                    <DEBTOR_CODE>{ data($DEBTORCODE) }</DEBTOR_CODE>
            }
            {
                for $DEBTORNAME in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORNAME
                return
                    <DEBTOR_NAME>{ data($DEBTORNAME) }</DEBTOR_NAME>
            }
            <BILL_DETAIL></BILL_DETAIL>
            {
                let $result :=
                    for $LATAMAGWSPENDINGBILLSType in $consultadedetallederecaudoResponse/LATAMAGWSPENDINGBILLSType
                    return
                        <BILLS>{ filtrarRecibos($LATAMAGWSPENDINGBILLSType/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType, $bill_number, $number_of_bills) }</BILLS>
                return
                    $result[1]
            }
            <REQUEST_CURRENCY>{ $request_currency }</REQUEST_CURRENCY>
        </ns1:consultaRecaudoMultipleResponse>
};

declare variable $consultadedetallederecaudoResponse as element(ns0:ConsultadedetallederecaudoResponse) external;
declare variable $number_of_bills as xs:string external;
declare variable $bill_number as xs:string external;
declare variable $request_currency as xs:string external;

xf:ConsultaRecaudoMultipleOut($consultadedetallederecaudoResponse,
    $number_of_bills,
    $bill_number,
    $request_currency)