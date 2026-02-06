xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bloqueodepasivosResponse" element="ns0:BloqueodepasivosResponse" location="../../../../Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592.xsd" ::)
(:: pragma bea:global-element-return element="ns1:bloqueoFondosCuentaResponse" location="../xsd/bloqueoFondosCuentaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bloqueoFondosCuentaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoFondosCuenta/xq/bloqueoFondosCuentaOut/";

declare function xf:bloqueoFondosCuentaOut($bloqueodepasivosResponse as element(ns0:BloqueodepasivosResponse))
    as element(ns1:bloqueoFondosCuentaResponse) {
        <ns1:bloqueoFondosCuentaResponse>
            {
        		let $DATETIME := fn:string($bloqueodepasivosResponse/ACLOCKEDEVENTSType/gDATETIME/DATETIME[1]/text())
        		return
        			if($DATETIME != "") then (
        				<TRANSACTION_DATE>{ concat("20",$DATETIME) }</TRANSACTION_DATE>
        			) else ()
            }
            {
                for $ACCOUNTNUMBER in $bloqueodepasivosResponse/ACLOCKEDEVENTSType/ACCOUNTNUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNTNUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $LOCKEDAMOUNT in $bloqueodepasivosResponse/ACLOCKEDEVENTSType/LOCKEDAMOUNT
                return
                    <LOCKED_AMOUNT>{ data($LOCKEDAMOUNT) }</LOCKED_AMOUNT>
            }
            {
                for $FROMDATE in $bloqueodepasivosResponse/ACLOCKEDEVENTSType/FROMDATE
                return
                    <BEGIN_DATE>{ data($FROMDATE) }</BEGIN_DATE>
            }
            {
                for $TODATE in $bloqueodepasivosResponse/ACLOCKEDEVENTSType/TODATE
                return
                    <END_DATE>{ data($TODATE) }</END_DATE>
            }
        </ns1:bloqueoFondosCuentaResponse>
};

declare variable $bloqueodepasivosResponse as element(ns0:BloqueodepasivosResponse) external;

xf:bloqueoFondosCuentaOut($bloqueodepasivosResponse)