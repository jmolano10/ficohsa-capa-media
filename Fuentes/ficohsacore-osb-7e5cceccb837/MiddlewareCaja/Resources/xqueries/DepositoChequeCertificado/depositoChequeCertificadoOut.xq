(:: pragma bea:global-element-parameter parameter="$depositodechequecertificadoResponse1" element="ns0:DepositodechequecertificadoResponse" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:depositoChequeCertificadoResponse" location="../../xsds/DepositoChequeCertificado/DepositoChequeCertificado.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeCertificado";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCertificado/depositoChequeCertificadoOut/";

declare function xf:depositoChequeCertificadoOut($depositodechequecertificadoResponse1 as element(ns0:DepositodechequecertificadoResponse),
    $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse),
    $branchName as xs:string)
    as element(ns1:depositoChequeCertificadoResponse) {
    	if (fn:string($depositodechequecertificadoResponse1/Status/successIndicator/text()) = "Success") then (
	        <ns1:depositoChequeCertificadoResponse>
	            {
	                for $ID in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID,
	                    $ALTACCTID in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID
	                return
	                    <ACCOUNT_NUMBER>{ concat($ID , "/", $ALTACCTID) }</ACCOUNT_NUMBER>
	            }
	            {
	                for $SHORTTITLE in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE
	                return
	                    <ACCOUNT_NAME>{ data($SHORTTITLE) }</ACCOUNT_NAME>
	            }
	            {
	                for $CURRENCY2 in $depositodechequecertificadoResponse1/TELLERType/CURRENCY2
	                return
	                    <CREDIT_CURRENCY>{ data($CURRENCY2) }</CREDIT_CURRENCY>
	            }
	            {
	                for $NETAMOUNT in $depositodechequecertificadoResponse1/TELLERType/NETAMOUNT
	                return
	                    <CREDIT_AMOUNT>{ data($NETAMOUNT) }</CREDIT_AMOUNT>
	            }
	            {
	                for $LRCERTCHQNUM in $depositodechequecertificadoResponse1/TELLERType/LRCERTCHQNUM
	                return
	                    <CHEQUE_NUMBER>{ data($LRCERTCHQNUM) }</CHEQUE_NUMBER>
	            }
	            {
	                for $LRCERTCHQISS in $depositodechequecertificadoResponse1/TELLERType/LRCERTCHQISS
	                return
	                    <CHEQUE_NUMBER_ACCOUNT>{ data($LRCERTCHQISS) }</CHEQUE_NUMBER_ACCOUNT>
	            }
	            {
	                let $result :=
	                    for $NARRATIVE2 in $depositodechequecertificadoResponse1/TELLERType/gNARRATIVE2/NARRATIVE2
	                    return
	                        <DESCRIPTION>{ data($NARRATIVE2) }</DESCRIPTION>
	                return
	                    $result[1]
	            }
	            {
	                let $result :=
	                    for $DATETIME in $depositodechequecertificadoResponse1/TELLERType/gDATETIME/DATETIME
	                    return
	                        <DATE_TIME>{ fn:concat("20",data($DATETIME)) }</DATE_TIME>
	                return
	                    $result[1]
	            }
	            {
	                let $INPUTTER := fn:tokenize(fn:string($depositodechequecertificadoResponse1/TELLERType/gINPUTTER/INPUTTER/text()),"_")
                    return
                        <INPUTTER>{ $INPUTTER[2] }</INPUTTER>
	            }
	            <BRANCH_NAME>{ $branchName }</BRANCH_NAME>
	        </ns1:depositoChequeCertificadoResponse>
	    ) else (
	        <ns1:depositoChequeCertificadoResponse/>
	    )
};

declare variable $depositodechequecertificadoResponse1 as element(ns0:DepositodechequecertificadoResponse) external;
declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;
declare variable $branchName as xs:string external;

xf:depositoChequeCertificadoOut($depositodechequecertificadoResponse1,
    $consultadedetallesdelacuentaResponse1,
    $branchName)